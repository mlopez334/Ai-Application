package cs3220.aiapplication.Controller;

import cs3220.aiapplication.model.DataStore;
import cs3220.aiapplication.model.User;
import cs3220.aiapplication.model.UserBean;
import cs3220.aiapplication.model.UserJDBC;
import cs3220.aiapplication.repository.UserRepository;
import org.springframework.messaging.simp.user.UserDestinationResolver;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
    private final UserRepository userRepository;
    private final UserBean userBean;

    public LoginController( UserBean userBean, UserRepository userRepository) {
        this.userBean = userBean;
        this.userRepository = userRepository;
    }

    @GetMapping("/login")
    public String login(){
        return "loginPage";
    }

    @PostMapping("/login")
    public String login(@RequestParam("username") String username, @RequestParam("password") String password, Model model) {
       // look up user
        UserJDBC user = userRepository.findUserJDBCByEmailAndPassword(username,password);

        if(user == null){
            model.addAttribute("error", "Wrong Username or Password.");
            return "loginPage";
        }

        userBean.setUser(user);
        return "redirect:/home";
    }

    @GetMapping("/logout")
    public String logout() {
        userBean.logout();
        return "redirect:/";
    }

    @GetMapping("/createAccount")
    public String createAccount(){
        return "createAccountPage";
    }

    @PostMapping("/newAccount")
    public String newAccount(@RequestParam("email") String email, @RequestParam("password") String password, Model model){

        // if acc alr exists dont make a copy
        if(userRepository.findUserJDBCByEmail(email) != null){
            model.addAttribute("error", "Email already registered.");
            return "createAccountPage";
        }

        // create new user
        UserJDBC newUser = new UserJDBC();
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setUsername(email);

        userRepository.save(newUser);
        userBean.setUser(newUser);

       return "redirect:/home";

    }



}
