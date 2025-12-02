package cs3220.aiapplication.Controller;

import cs3220.aiapplication.model.*;
import cs3220.aiapplication.repository.IngredientRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class IngredientController {
    public final UserBean userBean;
    public final IngredientRepository ingredientRepository;

    public IngredientController(UserBean userBean, IngredientRepository ingredientRepository) {
        this.userBean = userBean;
        this.ingredientRepository = ingredientRepository;
    }

    @GetMapping("/addIngredientPage")
    public String addIngredientPage() {
        if(!userBean.isLoggedIn()) {
            return "redirect:/login";
        }
        return "addIngredient";
    }

    @PostMapping("/addIngredientPage")
    public String addIngredient(@RequestParam("name") String name, @RequestParam("quantity") String quantity) {
        UserJDBC currUser = userBean.getUser();
        if (currUser == null) {
            return "redirect:/login";
        } else {
            //dataStore.addIngredient(currUser.getId(), new Ingredient(name, quantity));
            IngredientJDBC ingredient = new IngredientJDBC();
            ingredient.setName(name);
            ingredient.setQuantity(quantity);
            ingredient.setUser(currUser);
            ingredientRepository.save(ingredient);
        }

        return "redirect:/inventory";
    }


    @GetMapping("/edit/{id}")
    public String editIngredient(Model model, @PathVariable("id") Integer id){
        if(!userBean.isLoggedIn()) {
            return "redirect:/login";
        }
        UserJDBC user =  userBean.getUser();
        if(user == null){
            return "redirect:/inventory";
        }
//        Ingredient ingredient = dataStore.getIngredient(user.getId())
//                .stream()
//                .filter(i -> i.getId() == id)
//                .findFirst()
//                .orElse(null);
        IngredientJDBC ingredient = ingredientRepository.findById(id).orElse(null);
        if(ingredient == null){
            return "redirect:/inventory";
        }

        model.addAttribute("ingredient", ingredient);
        return "editInventory";
    }

    @PostMapping("/edit/{id}")
    public String editIngredientPost(@PathVariable("id") Integer id, @RequestParam("name") String name, @RequestParam("quantity") String quantity) {
        if (!userBean.isLoggedIn()) {
            return "redirect:/login";
        }
        UserJDBC user = userBean.getUser();

        //Ingredient ingredient = dataStore.getIngredient(user.getId()).stream().filter(i -> i.getId() == id).findFirst().orElse(null);
        IngredientJDBC ingredient = ingredientRepository.findById(id).orElse(null);
        if (ingredient == null) {
            return "redirect:/inventory";
        } else {
            ingredient.setName(name);
            ingredient.setQuantity(quantity);
            ingredient.setUser(user);
            ingredientRepository.save(ingredient);
            return "redirect:/inventory";
        }
    }

    @GetMapping("/delete/{id}")
    public String deleteIngredient(@PathVariable("id") Integer id){
        if(!userBean.isLoggedIn()){
            return "redirect:/login";
        }
        UserJDBC user = userBean.getUser();
       // dataStore.deleteIngredient(user.getId(), id);
        IngredientJDBC ingredient = ingredientRepository.findById(id).orElse(null);
        if(ingredient != null){
            ingredientRepository.delete(ingredient);
        }
        return "redirect:/inventory";

    }

}
