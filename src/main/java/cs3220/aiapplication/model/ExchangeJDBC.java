package cs3220.aiapplication.model;

import jakarta.persistence.*;
import jakarta.persistence.Id;

@Entity
@Table(name="exchanges")
public class ExchangeJDBC {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String userMessage;
    @Column(columnDefinition="TEXT")
    private String aiResponse;

    @ManyToOne
    @JoinColumn(name="user_id")
    private UserJDBC user;

    public ExchangeJDBC(){}

    public ExchangeJDBC(String userMessage, String aiResponse){
        this.userMessage = userMessage;
        this.aiResponse = aiResponse;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserMessage() {
        return userMessage;
    }

    public void setUserMessage(String userMessage) {
        this.userMessage = userMessage;
    }

    public String getAiResponse() {
        return aiResponse;
    }

    public void setAiResponse(String aiResponse) {
        this.aiResponse = aiResponse;
    }
}
