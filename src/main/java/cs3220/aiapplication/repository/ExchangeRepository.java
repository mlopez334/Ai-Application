package cs3220.aiapplication.repository;

import cs3220.aiapplication.model.ExchangeJDBC;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExchangeRepository extends CrudRepository<ExchangeJDBC, Integer> {
    List<ExchangeJDBC> findByUserId(Integer userId);
}
