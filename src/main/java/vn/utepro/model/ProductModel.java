package vn.utepro.model;

import org.springframework.web.multipart.MultipartFile;

public class ProductModel {
    private Long productId;
    private String productName;
    private MultipartFile imageFile;
    private String images;
    private Double unitPrice;
    private Double discount;
    private String description;
    private Long categoryId;
    private Integer quantity;
    private Short status;

    public ProductModel() {}

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public MultipartFile getImageFile() { return imageFile; }
    public void setImageFile(MultipartFile imageFile) { this.imageFile = imageFile; }
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    public Double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(Double unitPrice) { this.unitPrice = unitPrice; }
    public Double getDiscount() { return discount; }
    public void setDiscount(Double discount) { this.discount = discount; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Long getCategoryId() { return categoryId; }
    public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public Short getStatus() { return status; }
    public void setStatus(Short status) { this.status = status; }
}