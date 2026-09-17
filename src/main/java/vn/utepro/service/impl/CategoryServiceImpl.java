package vn.utepro.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.utepro.entity.Category;
import vn.utepro.repository.CategoryRepository;
import vn.utepro.service.ICategoryService;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryServiceImpl implements ICategoryService {

    @Autowired private CategoryRepository categoryRepository;

    @Override public List<Category> findAll() { return categoryRepository.findAll(); }
    @Override public Optional<Category> findById(Long id) { return categoryRepository.findById(id); }
    @Override public Optional<Category> findByCategoryName(String name) {
        return categoryRepository.findByCategoryName(name);
    }
    @Override public Category save(Category c) { return categoryRepository.save(c); }
    @Override public void delete(Category c) { categoryRepository.delete(c); }
}