package vn.utepro.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.utepro.entity.Category;
import vn.utepro.entity.Product;
import vn.utepro.model.Response;
import vn.utepro.service.ICategoryService;
import vn.utepro.service.IProductService;
import vn.utepro.service.IStorageService;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/product")
public class ProductApiController {

    @Autowired private IProductService productService;
    @Autowired private ICategoryService categoryService;
    @Autowired private IStorageService storageService;

    /** GET ALL */
    @GetMapping
    public ResponseEntity<?> getAllProduct() {
        return new ResponseEntity<>(
                new Response(true, "Thành công", productService.findAll()),
                HttpStatus.OK);
    }

    /** GET BY ID */
    @PostMapping("/getProduct")
    public ResponseEntity<?> getProduct(@RequestParam("id") Long id) {
        Optional<Product> p = productService.findById(id);
        return p.map(prod -> new ResponseEntity<>(
                        new Response(true, "Thành công", prod), HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(
                        new Response(false, "Không tìm thấy Product", null),
                        HttpStatus.NOT_FOUND));
    }

    /** ADD */
    @PostMapping("/addProduct")
    public ResponseEntity<?> addProduct(
            @RequestParam("productName") String productName,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam("unitPrice") Double unitPrice,
            @RequestParam("discount") Double discount,
            @RequestParam("description") String description,
            @RequestParam("categoryId") Long categoryId,
            @RequestParam("quantity") Integer quantity,
            @RequestParam("status") Short status) {

        Optional<Product> existing = productService.findByProductName(productName);
        if (existing.isPresent()) {
            return new ResponseEntity<>(
                    new Response(false, "Sản phẩm này đã tồn tại", existing.get()),
                    HttpStatus.BAD_REQUEST);
        }

        Product product = new Product();
        Timestamp timestamp = new Timestamp(new Date().getTime());
        try {
            product.setProductName(productName);
            product.setUnitPrice(unitPrice);
            product.setDiscount(discount);
            product.setDescription(description);
            product.setQuantity(quantity);
            product.setStatus(status);
            product.setCreateDate(timestamp);

            Category cat = new Category();
            cat.setCategoryId(categoryId);
            product.setCategory(cat);

            if (imageFile != null && !imageFile.isEmpty()) {
                UUID uuid = UUID.randomUUID();
                product.setImages(storageService.getStorageFilename(imageFile, uuid.toString()));
                storageService.store(imageFile, product.getImages());
            }

            productService.save(product);
            Optional<Product> saved = productService.findByCreateDate(timestamp);
            return new ResponseEntity<>(
                    new Response(true, "Thêm thành công", saved.orElse(product)),
                    HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(
                    new Response(false, "Lỗi: " + e.getMessage(), null),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /** UPDATE */
    @PutMapping("/updateProduct")
    public ResponseEntity<?> updateProduct(
            @RequestParam("productId") Long productId,
            @RequestParam("productName") String productName,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam("unitPrice") Double unitPrice,
            @RequestParam("discount") Double discount,
            @RequestParam("description") String description,
            @RequestParam("categoryId") Long categoryId,
            @RequestParam("quantity") Integer quantity,
            @RequestParam("status") Short status) {

        Optional<Product> opt = productService.findById(productId);
        if (opt.isEmpty()) {
            return new ResponseEntity<>(
                    new Response(false, "Không tìm thấy Product", null),
                    HttpStatus.BAD_REQUEST);
        }
        Product p = opt.get();
        p.setProductName(productName);
        p.setUnitPrice(unitPrice);
        p.setDiscount(discount);
        p.setDescription(description);
        p.setQuantity(quantity);
        p.setStatus(status);

        Category cat = new Category();
        cat.setCategoryId(categoryId);
        p.setCategory(cat);

        if (imageFile != null && !imageFile.isEmpty()) {
            UUID uuid = UUID.randomUUID();
            p.setImages(storageService.getStorageFilename(imageFile, uuid.toString()));
            storageService.store(imageFile, p.getImages());
        }
        productService.save(p);
        return new ResponseEntity<>(
                new Response(true, "Cập nhật thành công", p), HttpStatus.OK);
    }

    /** DELETE */
    @DeleteMapping("/deleteProduct")
    public ResponseEntity<?> deleteProduct(@RequestParam("productId") Long productId) {
        Optional<Product> opt = productService.findById(productId);
        if (opt.isEmpty()) {
            return new ResponseEntity<>(
                    new Response(false, "Không tìm thấy Product", null),
                    HttpStatus.BAD_REQUEST);
        }
        productService.delete(opt.get());
        return new ResponseEntity<>(
                new Response(true, "Xóa thành công", opt.get()), HttpStatus.OK);
    }
}