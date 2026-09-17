package vn.utepro.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.utepro.entity.Product;
import java.util.Date;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    Optional<Product> findByProductName(String productName);
    Optional<Product> findByCreateDate(Date createDate);
}