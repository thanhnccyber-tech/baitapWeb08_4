package vn.utepro.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.utepro.entity.Category;
import vn.utepro.repository.CategoryRepository;
import vn.utepro.service.ICategoryService;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class CategoryServiceImpl implements ICategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    @Transactional(readOnly = true)
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Category> findById(Long id) {
        return categoryRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Category> findByCategoryName(String name) {
        return categoryRepository.findByCategoryName(name);
    }

    @Override
    public Category save(Category c) {
        return categoryRepository.save(c);
    }

    @Override
    public void delete(Category c) {
        categoryRepository.delete(c);
    }
}