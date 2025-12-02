package cs3220.aiapplication.repository;

import cs3220.aiapplication.model.IngredientJDBC;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface IngredientRepository extends CrudRepository<IngredientJDBC,Integer> {
    List<IngredientJDBC> findByUserId(Integer userId);

}
