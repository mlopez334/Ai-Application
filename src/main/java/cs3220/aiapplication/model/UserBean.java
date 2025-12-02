package cs3220.aiapplication.model;

import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.SessionScope;

import java.util.ArrayList;
import java.util.List;

@Component
@SessionScope
public class UserBean {
    private UserJDBC user;
    private final List<Exchange> exchangeHistory  = new ArrayList<>();

    public boolean isLoggedIn() {
        return user != null;
    }

    public void login(UserJDBC user) {
        this.user = user;
    }

    public void logout() {
        this.user = null;
    }

    public UserJDBC getUser() {
        return user;
    }

    public List<Exchange> getExchangeHistory(){
        return exchangeHistory;
    }

    public void addExchange(Exchange exchange){
        exchangeHistory.add(exchange);
    }

    public void setUser(UserJDBC user){
        this.user = user;
    }


}
