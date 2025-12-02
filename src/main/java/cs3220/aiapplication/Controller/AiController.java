package cs3220.aiapplication.Controller;

import cs3220.aiapplication.model.*;
import cs3220.aiapplication.repository.IngredientRepository;
import cs3220.aiapplication.repository.RecipeRepository;
import cs3220.aiapplication.repository.UserRepository;
import org.hibernate.graph.InvalidGraphException;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

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


        String cookingLevel = (level == null) ?"beginner": level;
        System.out.println("Ingredients: " + ingredientsName);
        String ingredients = String.join(", ", ingredientsName);
        System.out.println("Ingredients String: " + ingredients);
        String userPrompt =
                "Using ONLY these ingredients as the base: " + ingredients + ", " +
                        "create a recipe based on: " + prompt + ". " +
                        "The recipe must follow this exact format:\n\n" +
                        "Title: <short recipe title>\n" +
                        "Main Ingredients:\n" +
                        "- List only 3 to 5 main ingredients from the provided ingredient list. No extras.\n" +
                        "Instructions:\n" +
                        "<simple clear steps suitable for a " + cookingLevel + " cook>\n\n" +
                        "IMPORTANT RULES:\n" +
                        "- Main Ingredients list must contain ONLY 3–5 items.\n" +
                        "- Keep the output clean and formatted exactly with the three sections.";

        String aiResponse = realChat(userPrompt);
        String mainIngredients = extractMainIngredients(aiResponse);

        String title = extractTitle(aiResponse);

        RecipeJDBC recipe = new RecipeJDBC();
        recipe.setUser(userBean.getUser());
        recipe.setTitle(title);
        recipe.setDate(LocalTime.now());
        recipe.setPrompt(prompt);
        recipe.setMainIngredients(mainIngredients);
        recipe.setContent(aiResponse);
        recipe.setFavorite(false);

        recipeRepository.save(recipe);
        recipeHistory.add(recipe);


        // Use DataStore recipes for the sidebar
        List<RecipeJDBC> recipes = recipeRepository.findByUserId(userId);
        List<RecipeJDBC> favorites = recipes.stream().filter(RecipeJDBC::isFavorite).toList();
        model.addAttribute("recipes", recipes);
        model.addAttribute("favorites", favorites);
        model.addAttribute("aiResponse", aiResponse);

        return "redirect:/viewRecipe?id=" + recipe.getId();
    }





}
