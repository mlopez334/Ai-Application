package cs3220.aiapplication.model;

import cs3220.aiapplication.Controller.IngredientController;
import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name="ingredients")
public class IngredientJDBC {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;
    private String quantity;

    @ManyToOne
    @JoinColumn(name="user_id")
    private UserJDBC user;

    public IngredientJDBC(){}

    public IngredientJDBC(String name, String quantity){
        this.name = name;
        this.quantity = quantity;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public UserJDBC getUser() {
        return user;
    }

    public void setUser(UserJDBC user) {
        this.user = user;
    }


}
