package vn.utepro.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.utepro.entity.Product;
import vn.utepro.repository.ProductRepository;
import vn.utepro.service.IProductService;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProductServiceImpl implements IProductService {

    @Autowired
    private ProductRepository productRepository;

    @Override
    @Transactional(readOnly = true)
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Product> findById(Long id) {
        return productRepository.findById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Product> findByProductName(String n) {
        return productRepository.findByProductName(n);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<Product> findByCreateDate(Date d) {
        return productRepository.findByCreateDate(d);
    }

    @Override
    public Product save(Product p) {
        return productRepository.save(p);
    }

    @Override
    public void delete(Product p) {
        productRepository.delete(p);
    }
}