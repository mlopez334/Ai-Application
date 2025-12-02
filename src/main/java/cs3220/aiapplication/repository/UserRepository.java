package cs3220.aiapplication.repository;

import cs3220.aiapplication.model.UserJDBC;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserRepository extends CrudRepository<UserJDBC, Integer> {

    UserJDBC findUserJDBCByUsername(String username);

    @Query("select u from UserJDBC u where u.email =?1")
    UserJDBC findUserJDBCByEmail(String email);

    @Query("select u from UserJDBC u where u.email = ?1 and u.password = ?2")
    UserJDBC findUserJDBCByEmailAndPassword(String email, String password);

}
