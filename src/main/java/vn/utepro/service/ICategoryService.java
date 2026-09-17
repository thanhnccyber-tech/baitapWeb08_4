package vn.utepro.service;

import vn.utepro.entity.Category;
import java.util.List;
import java.util.Optional;

public interface ICategoryService {
    List<Category> findAll();
    Optional<Category> findById(Long id);
    Optional<Category> findByCategoryName(String name);
    Category save(Category category);
    void delete(Category category);
}