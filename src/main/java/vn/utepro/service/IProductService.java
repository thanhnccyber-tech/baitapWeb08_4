package vn.utepro.service;

import vn.utepro.entity.Product;
import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface IProductService {
    List<Product> findAll();
    Optional<Product> findById(Long id);
    Optional<Product> findByProductName(String name);
    Optional<Product> findByCreateDate(Date date);
    Product save(Product product);
    void delete(Product product);
}