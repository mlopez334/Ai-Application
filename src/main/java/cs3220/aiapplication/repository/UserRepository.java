package cs3220.aiapplication.repository;

import cs3220.aiapplication.model.UserJDBC;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<UserJDBC, Integer> {
    UserJDBC findByUsername(String username);

}
