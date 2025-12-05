package cs3220.aiapplication.Controller;

import com.lowagie.text.*;
import cs3220.aiapplication.model.*;
import cs3220.aiapplication.repository.IngredientRepository;
import cs3220.aiapplication.repository.RecipeRepository;
import cs3220.aiapplication.repository.UserRepository;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.core.io.InputStreamResource;
import java.io.*;
import org.springframework.core.io.Resource;
import com.lowagie.text.pdf.PdfWriter;


@Controller
public class AiController {
    private final ChatClient chatClient;
    public final UserBean userBean;
    private final List<RecipeJDBC> recipeHistory = new ArrayList<>();
    private final UserRepository userRepository;
    private final RecipeRepository recipeRepository;
    private final IngredientRepository ingredientRepository;

    public AiController(UserBean userBean, ChatClient.Builder chatClientBuilder, UserRepository userRepository, RecipeRepository recipeRepository, IngredientRepository ingredientRepository) {
        this.userBean = userBean;
        this.chatClient = chatClientBuilder.build();
        this.userRepository = userRepository;
        this.recipeRepository = recipeRepository;
        this.ingredientRepository = ingredientRepository;
    }

    private String realChat(String message){
       List<Message> messages = new ArrayList<>();
       messages.add(new SystemMessage("You are a helpful assistant. Generate a recipe using the user's ingredients, try to closely follow each ingredient's quantity. " + "Output Format: Title, list of main ingredients, and the instructions"));

       for(RecipeJDBC recipe: recipeHistory){
           messages.add(new UserMessage(recipe.getPrompt()));
           messages.add(new AssistantMessage(recipe.getContent()));
       }

       messages.add(new UserMessage(message));

       try {
           return chatClient.prompt(new Prompt(messages)).call().content();
       } catch(Exception e){
           e.printStackTrace();
           return "error contacting AI: " + e.getMessage();
       }
    }

    private String extractTitle(String aiResponse) {
        return aiResponse.lines()
                .filter(line -> line.startsWith("Title:"))
                .map(line -> line.replace("Title:", "").trim())
                .findFirst()
                .orElse("Untitled Recipe");
    }

    private String extractMainIngredients(String aiResponse) {
        List<String> lines = aiResponse.lines().toList();
        List<String> ingredients = new ArrayList<>();
        boolean inIngredients = false;

        for (String line : lines) {
            if (line.startsWith("Main Ingredients")) {
                inIngredients = true;
                continue;
            }
            if (inIngredients) {
                if (line.startsWith("Instructions")) break;
                if (!line.isBlank()) ingredients.add(line.trim());
            }
        }

        return String.join("\n", ingredients);
    }

    private String extractInstructions(String aiResponse){
        List<String> lines = aiResponse.lines().toList();
        List<String> instructions = new ArrayList<>();
        boolean inInstructions = false;

        for(String line : lines){
            if(line.startsWith("Instructions")){
                inInstructions = true;
                continue;
            }
            if(inInstructions){
                if(line.startsWith("Main Ingredients") || line.startsWith("Title:")) break;
                instructions.add(line.trim());
            }
        }
        return String.join("\n", instructions);
    }


    @GetMapping("/home")
    public String showHomePage(@RequestParam(value="tab", defaultValue="history") String tab, Model model){
        if(!userBean.isLoggedIn()) {
            return "redirect:/login";

        }
            int userId = userBean.getUser().getId();
            // send homepage what tab we are in
            model.addAttribute("tab", tab);
            List<RecipeJDBC> recipes = recipeRepository.findByUserId(userId);
            List<RecipeJDBC> favorites = recipes.stream().filter(RecipeJDBC::isFavorite).toList();
            model.addAttribute("recipes", recipes);
            model.addAttribute("favorites", favorites);
//            model.addAttribute("recipes", dataStore.getRecipes(userId));
//            model.addAttribute("favorites", dataStore.getFavorites(userId));
            //find if inventory is empty and pass that to jte
        model.addAttribute("emptyInv", ingredientRepository.count() <= 0);
        model.addAttribute("user", userBean.getUser());

            return "homePage";

    }

    @PostMapping("/home")
    public String homePrompt(@RequestParam("prompt") String prompt, @RequestParam(value="level", required =false) String level, Model model){
        if(!userBean.isLoggedIn()){
            return "redirect:/login";
        }

        int userId = userBean.getUser().getId();
        //List<String> ingredientsName = dataStore.getIngredient(userId).stream().map(Ingredient::getName).toList();
        List<IngredientJDBC> ingredientList = ingredientRepository.findByUserId(userId);
        List<String> ingredientsName = ingredientList.stream().map(IngredientJDBC::getName).toList();

        List<String> ingredientsWithQuantity = new ArrayList<>();

        for(int i = 0; i < ingredientList.size(); i++){
            String name = ingredientList.get(i).getName();
            String quantity = ingredientList.get(i).getQuantity();
            ingredientsWithQuantity.add(name + "(" + quantity + ")");

        }

        String ingredientsString = String.join(", ", ingredientsWithQuantity);



        String cookingLevel = (level == null) ?"beginner": level;

        System.out.println("Ingredients: " + ingredientsName);
        String ingredients = String.join(", ", ingredientsName);
        System.out.println("Ingredients String: " + ingredients);
        String userPrompt =
                "Using ONLY these ingredients as the base: " + ingredientsString + ", " +
                        "create a recipe based on: " + prompt + ". " +
                        "The recipe must follow this exact format:\n\n" +
                        "Title: <short recipe title>\n" +
                        "Main Ingredients:\n" +
                        "- List only 1 to 4 main ingredients NAMES from the provided ingredient list. No extras.\n" +
                        "- DO NOT include the quantities for the ingredients.\n" +
                        "Instructions:\n" +
                        "<simple clear steps suitable for a " + cookingLevel + " cook>\n\n" +
                        "Each step MUST be its own line (NOT just 1 large paragraph, use \\n to separate each step) and number each step.\n"+
                        "IMPORTANT RULES:\n" +
                        "- You MAY use the ingredient quantities (inside parentheses) to decide realistic amounts during cooking.\n" +
                        "- BUT in the Main Ingredients list, ONLY SHOW THE INGREDIENT NAME (e.g., 'Tomato', NOT 'Tomato (2 cups)').\n" +
                        "- Main Ingredients list must contain ONLY 1–4 UNIQUE items.\n" +
                        "- Keep formatting clean: exactly three sections and nothing else.";

        String aiResponse = realChat(userPrompt);
        String mainIngredients = extractMainIngredients(aiResponse);

        String title = extractTitle(aiResponse);

        RecipeJDBC recipe = new RecipeJDBC();
        recipe.setCookingLevel(cookingLevel);
        recipe.setUser(userBean.getUser());
        recipe.setTitle(title);
        recipe.setDate(LocalDate.now());
        recipe.setPrompt(prompt);
        recipe.setMainIngredients(mainIngredients);
        String instructions = extractInstructions(aiResponse);
        recipe.setContent(instructions);
        recipe.setFavorite(false);

        recipeRepository.save(recipe);
        recipeHistory.add(recipe);


        // Use DataStore recipes for the sidebar
        List<RecipeJDBC> recipes = recipeRepository.findByUserId(userId);
        List<RecipeJDBC> favorites = recipes.stream().filter(RecipeJDBC::isFavorite).toList();
        model.addAttribute("recipes", recipes);
        model.addAttribute("favorites", favorites);
        model.addAttribute("aiResponse", aiResponse);
        model.addAttribute("user", userBean.getUser());

        return "redirect:/viewRecipe?id=" + recipe.getId();
    }


    @GetMapping("/download/{id}")
    public  ResponseEntity<Resource>  export(@PathVariable int id, Model model) throws FileNotFoundException {

        UserJDBC user = userBean.getUser();
        RecipeJDBC r = recipeRepository.findById(id).get();

        Document document = new Document();

        try (FileOutputStream fos = new FileOutputStream("src/main/resources/generatedPdf/recipe" + id + ".pdf")) {
            PdfWriter.getInstance(document, fos);
            document.open();

            Font title = new Font(1, 24);

            document.addTitle(r.getTitle());

            Paragraph username = new Paragraph("Recipe created by: " + user.getUsername(), title);
            username.setAlignment(Paragraph.ALIGN_CENTER);


            String imgFile = "src/main/resources/static/images/" + user.getProfilePicture();
            Image image = Image.getInstance(imgFile);
            image.scaleAbsolute(75,75);
            image.setAlignment(Image.ALIGN_RIGHT);
            username.add(image);
            document.add(username);

            Paragraph p = new Paragraph(r.getTitle(), title);
            p.setAlignment(Element.ALIGN_LEFT);
            document.add(p);

            p =  new Paragraph("\nIngredients: \n" + r.getMainIngredients());
            p.setAlignment(Element.ALIGN_LEFT);
            document.add(p);

            p = new Paragraph("Instructions:\n", title);
            p.setAlignment(Element.ALIGN_LEFT);
            document.add(p);

            p = new Paragraph(r.getContent());
            p.setAlignment(Element.ALIGN_LEFT);
            document.add(p);
            document.close();

        } catch (DocumentException | IOException e) {
            e.printStackTrace();
        }

        InputStreamResource resource = new InputStreamResource(new FileInputStream("src/main/resources/generatedPdf/recipe" + id + ".pdf"));
        File file = new File("src/main/resources/generatedPdf/recipe" + id + ".pdf");
        HttpHeaders header = new HttpHeaders();
        header.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=recipe" + id + ".pdf");
        header.add("Cache-Control", "no-cache, no-store, must-revalidate");
        header.add("Pragma", "no-cache");
        header.add("Expires", "0");


        return  ResponseEntity.ok()
                .headers(header)
                .contentLength(file.length())
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(resource);
    }




}
