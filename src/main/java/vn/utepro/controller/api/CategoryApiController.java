package vn.utepro.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import vn.utepro.entity.Category;
import vn.utepro.model.Response;
import vn.utepro.service.ICategoryService;
import vn.utepro.service.IStorageService;

import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping(path = "/api/category")
public class CategoryApiController {

    @Autowired private ICategoryService categoryService;
    @Autowired private IStorageService storageService;

    /** GET ALL */
    @GetMapping
    public ResponseEntity<?> getAllCategory() {
        return ResponseEntity.ok().body(categoryService.findAll());
    }

    /** GET BY ID */
    @PostMapping("/getCategory")
    public ResponseEntity<?> getCategory(@RequestParam("id") Long id) {
        Optional<Category> c = categoryService.findById(id);
        return c.map(category -> new ResponseEntity<>(
                        new Response(true, "Thành công", category), HttpStatus.OK))
                .orElseGet(() -> new ResponseEntity<>(
                        new Response(false, "Không tìm thấy Category", null),
                        HttpStatus.NOT_FOUND));
    }

    /** ADD */
    @PostMapping("/addCategory")
    public ResponseEntity<?> addCategory(
            @RequestParam("categoryName") String categoryName,
            @RequestParam(value = "icon", required = false) MultipartFile icon) {

        Optional<Category> opt = categoryService.findByCategoryName(categoryName);
        if (opt.isPresent()) {
            return new ResponseEntity<>(
                    new Response(false, "Category đã tồn tại", opt.get()),
                    HttpStatus.BAD_REQUEST);
        }

        Category category = new Category();
        if (icon != null && !icon.isEmpty()) {
            UUID uuid = UUID.randomUUID();
            category.setIcon(storageService.getStorageFilename(icon, uuid.toString()));
            storageService.store(icon, category.getIcon());
        }
        category.setCategoryName(categoryName);
        categoryService.save(category);
        return new ResponseEntity<>(
                new Response(true, "Thêm thành công", category), HttpStatus.OK);
    }

    /** UPDATE */
    @PutMapping("/updateCategory")
    public ResponseEntity<?> updateCategory(
            @RequestParam("categoryId") Long categoryId,
            @RequestParam("categoryName") String categoryName,
            @RequestParam(value = "icon", required = false) MultipartFile icon) {

        Optional<Category> opt = categoryService.findById(categoryId);
        if (opt.isEmpty()) {
            return new ResponseEntity<>(
                    new Response(false, "Không tìm thấy Category", null),
                    HttpStatus.BAD_REQUEST);
        }
        Category c = opt.get();
        if (icon != null && !icon.isEmpty()) {
            UUID uuid = UUID.randomUUID();
            c.setIcon(storageService.getStorageFilename(icon, uuid.toString()));
            storageService.store(icon, c.getIcon());
        }
        c.setCategoryName(categoryName);
        categoryService.save(c);
        return new ResponseEntity<>(
                new Response(true, "Cập nhật thành công", c), HttpStatus.OK);
    }

    /** DELETE */
    @DeleteMapping("/deleteCategory")
    public ResponseEntity<?> deleteCategory(@RequestParam("categoryId") Long categoryId) {
        Optional<Category> opt = categoryService.findById(categoryId);
        if (opt.isEmpty()) {
            return new ResponseEntity<>(
                    new Response(false, "Không tìm thấy Category", null),
                    HttpStatus.BAD_REQUEST);
        }
        categoryService.delete(opt.get());
        return new ResponseEntity<>(
                new Response(true, "Xóa thành công", opt.get()), HttpStatus.OK);
    }
}