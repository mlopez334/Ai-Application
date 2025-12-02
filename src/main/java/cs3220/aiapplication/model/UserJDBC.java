package cs3220.aiapplication.model;


import jakarta.persistence.*;
import java.util.*;

@Entity
@Table(name="users")
public class UserJDBC {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(unique = true)
    private String email;


    private String username;

    private String password;

    @OneToMany(mappedBy = "user")
    private List<IngredientJDBC> ingredients = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    private List<RecipeJDBC> recipes = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    private List<ExchangeJDBC> exchanges = new ArrayList<>();


    public UserJDBC(){}

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

}
