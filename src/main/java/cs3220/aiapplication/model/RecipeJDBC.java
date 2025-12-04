package cs3220.aiapplication.model;

import jakarta.persistence.*;
import jakarta.persistence.Id;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name="recipes")
public class RecipeJDBC {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name="user_id")
    private UserJDBC user;

    private String title;
    private LocalDate date;
    private String prompt;
    private String cookingLevel;
    @Column(columnDefinition = "TEXT")
    private String content;

    @Column(columnDefinition = "TEXT")
    private String mainIngredients;
    private boolean favorite;

    public RecipeJDBC(){}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getPrompt() {
        return prompt;
    }

    public void setPrompt(String prompt) {
        this.prompt = prompt;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getMainIngredients() {
        return mainIngredients;
    }

    public void setMainIngredients(String mainIngredients) {
        this.mainIngredients = mainIngredients;
    }

    public boolean isFavorite() {
        return favorite;
    }

    public void setFavorite(boolean favorite) {
        this.favorite = favorite;
    }

    public UserJDBC getUser(){
        return user;
    }

    public String getCookingLevel() {
        return cookingLevel;
    }

    public void setCookingLevel(String cookingLevel) {
        this.cookingLevel = cookingLevel;
    }

    public void setUser(UserJDBC user){
        this.user = user;
    }
}
