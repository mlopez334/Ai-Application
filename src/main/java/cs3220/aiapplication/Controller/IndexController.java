package cs3220.aiapplication.Controller;

import cs3220.aiapplication.model.*;
import cs3220.aiapplication.repository.IngredientRepository;
import cs3220.aiapplication.repository.RecipeRepository;
import cs3220.aiapplication.repository.UserRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

@Controller
public class IndexController {

    private final UserBean userBean;
    private final UserRepository userRepository;
    private final RecipeRepository recipeRepository;
    private final IngredientRepository ingredientRepository;

    public IndexController(UserBean userBean, UserRepository userRepository, RecipeRepository recipeRepository, IngredientRepository ingredientRepository) {
        this.userBean = userBean;
        this.userRepository = userRepository;
        this.ingredientRepository = ingredientRepository;
        this.recipeRepository = recipeRepository;
    }

    @GetMapping("/")
    public String landingPage() {
    // create root + guest user it not already
        // add ingrdients to root user
        if(userRepository.findUserJDBCByEmail("root@example.com") == null) {
            UserJDBC root = new UserJDBC();
            root.setEmail("root@example.com");
            root.setUsername("root@example.com");
            root.setPassword("1234");
            userRepository.save(root);

        }

        if(userRepository.findUserJDBCByEmail("guest@example.com") == null) {
            UserJDBC guest = new UserJDBC();
            guest.setEmail("guest@example.com");
            guest.setUsername("guest@example.com");
            guest.setPassword("1234");
            userRepository.save(guest);
        }

        return "landingPage";
    }


    @GetMapping("/inventory")
    public String inventoryPage(
            @RequestParam(value = "tab", defaultValue = "history") String tab,
            Model model
    ) {
        if (!userBean.isLoggedIn()) {
            return "redirect:/login";
        }

        UserJDBC user = userBean.getUser();
        int userId = user.getId();

        List<IngredientJDBC> ingredients = ingredientRepository.findByUserId(userId);
        List<RecipeJDBC> recipes = recipeRepository.findByUserId(userId);
        List<RecipeJDBC> favorites = recipes.stream().filter(RecipeJDBC::isFavorite).toList();

        model.addAttribute("ingredients", ingredients);
        model.addAttribute("recipes", recipes);
        model.addAttribute("favorites", favorites);
        model.addAttribute("tab", tab);
        model.addAttribute("user", user);

        return "inventoryPage";
    }

    @GetMapping("/results")
    public String resultsPage(Model model){
        if(!userBean.isLoggedIn()) {
            return "redirect:/login";

        }

        int userId = userBean.getUser().getId();
        List<RecipeJDBC> recipes = recipeRepository.findByUserId(userId);
        List<RecipeJDBC> favorites = recipes.stream().filter(RecipeJDBC::isFavorite).toList();

        model.addAttribute("recipes", recipes);
        model.addAttribute("favorites", favorites);

        return "resultsPage";


    }

    @GetMapping("/favorites")
    public String favoritesPage(Model model) {
        if (!userBean.isLoggedIn()) {
            return "redirect:/login";

        }

        int userId = userBean.getUser().getId();
        List<RecipeJDBC> recipes = recipeRepository.findByUserId(userId);
        List<RecipeJDBC> favorites = recipes.stream().filter(RecipeJDBC::isFavorite).toList();

        model.addAttribute("recipes", recipes);
        model.addAttribute("favorites", favorites);

        return "favoritesPage";

    }

    @GetMapping("/profile")
    public String profilePage(Model model,  @RequestParam(value = "tab", defaultValue = "history") String tab){
        if(!userBean.isLoggedIn()) {
            return "redirect:/login";
        }
    UserJDBC user = userBean.getUser();
        int userId = user.getId();
        List<RecipeJDBC> recipes = recipeRepository.findByUserId(userId);
        List<RecipeJDBC> favorites = recipes.stream().filter(RecipeJDBC::isFavorite).toList();
        List<IngredientJDBC> ingredients = ingredientRepository.findByUserId(userId);
        model.addAttribute("user", user);
        model.addAttribute("recipeHistory", recipes);
        model.addAttribute("favoriteHistory", favorites);
        model.addAttribute("ingredientCount", ingredients.size());
        model.addAttribute("tab", tab);


        return "userProfile";
    }

    @GetMapping("/changeUsername")
    public String changeUsernamePage(){
        if (!userBean.isLoggedIn()) {
            return "redirect:/login";
        } else {
            return "changeUsernamePage";
        }
    }

    @PostMapping("/changeUsername")
    public String changeUsername(@RequestParam("username") String username) {
        if (!userBean.isLoggedIn()) {
            return "redirect:/login";
        }
            UserJDBC user = userBean.getUser();
            user.setUsername(username);
            userRepository.save(user);

            return "redirect:/profile";

    }
        @GetMapping("/viewRecipe")
        public String viewRecipe(@RequestParam(value="tab", defaultValue="history") String tab, @RequestParam("id") int id, Model model){
            if(!userBean.isLoggedIn()){
                return "redirect:/login";
            }

            int userId = userBean.getUser().getId();
            Optional<RecipeJDBC> recipeOpt = recipeRepository.findById(id);


            if(recipeOpt.isEmpty()){
                return "redirect:/home";
            }

            RecipeJDBC recipe = recipeOpt.get();
            List<RecipeJDBC> recipes = recipeRepository.findByUserId(userId);
            List<RecipeJDBC> favorites = recipes.stream().filter(RecipeJDBC::isFavorite).toList();

            model.addAttribute("tab", tab);
            model.addAttribute("recipes", recipes);
            model.addAttribute("favorites", favorites);
            model.addAttribute("recipeById", recipe);
            model.addAttribute("user", userBean.getUser());
            return "viewRecipe";

    }

    @GetMapping("/favoriteRecipe")
    public String favoriteRecipe(@RequestParam int id,
                                 @RequestParam(required=false, defaultValue="history") String tab) {

        int userId = userBean.getUser().getId();
        RecipeJDBC recipe = recipeRepository.findById(id).orElse(null);

        // Prevent null user reference crash
        if (recipe != null) {
            UserJDBC recipeUser = recipe.getUser();

            if (recipeUser != null && recipeUser.getId() == userId) {
                recipe.setFavorite(!recipe.isFavorite());
                recipeRepository.save(recipe);
            }
        }

        return "redirect:/viewRecipe?id=" + id + "&tab=" + tab;
    }



    @GetMapping("/deleteRecipe")
    public String deleteRecipe(@RequestParam int id, @RequestParam(required=false, defaultValue="history") String tab) {

        int userId = userBean.getUser().getId();

        RecipeJDBC recipe = recipeRepository.findById(id).orElse(null);

        if (recipe != null && recipe.getUser() != null && recipe.getUser().getId() == userId) {
            recipeRepository.deleteById(id);
        }

        return "redirect:/home?tab=" + tab;
    }

    @PostMapping("/uploadProfilePicture")
    public String uploadProfilePicture(
            @RequestParam("profilePic") MultipartFile profilePic,
            @RequestParam(required = false, defaultValue = "history") String tab
    ) throws IOException {

        if (!userBean.isLoggedIn()) {
            return "redirect:/login";
        }

        UserJDBC user = userBean.getUser();

        String uploadFolder = "src/main/resources/static/images/";
        String fileName = "user_" + user.getId() + "-" + profilePic.getOriginalFilename();

        Files.copy(profilePic.getInputStream(),java.nio.file.Paths.get(uploadFolder + fileName), StandardCopyOption.REPLACE_EXISTING);

        user.setProfilePicture(fileName);
        userRepository.save(user);

        return "redirect:/profile?tab=" + tab;
    }

    @PostMapping("/deleteProfilePicture")
    public String deleteProfilePicture(@RequestParam(required = false, defaultValue = "history") String tab) {
        if (!userBean.isLoggedIn()) {
            return "redirect:/login";
        }

        UserJDBC user = userBean.getUser();
        String filename = user.getProfilePicture();

        if (filename != null && !filename.isEmpty()) {
            // Delete the file from static/images
            try {
                java.nio.file.Path filePath = java.nio.file.Paths.get("src/main/resources/static/images", filename);
                java.nio.file.Files.deleteIfExists(filePath);
            } catch (Exception e) {
                e.printStackTrace();
            }
            // Remove from user entity
            user.setProfilePicture(null);
            userRepository.save(user);
        }

        return "redirect:/profile?tab=" + tab;
    }

}

