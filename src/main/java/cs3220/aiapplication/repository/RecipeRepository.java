package cs3220.aiapplication.repository;

import cs3220.aiapplication.model.Recipe;
import cs3220.aiapplication.model.RecipeJDBC;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface RecipeRepository extends CrudRepository<RecipeJDBC, Integer> {
    List<RecipeJDBC> findByUserId(Integer userId);
}
