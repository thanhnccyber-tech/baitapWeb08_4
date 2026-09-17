package vn.utepro.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "products")
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Long productId;

    @Column(name = "product_name", columnDefinition = "NVARCHAR(255)")
    private String productName;

    @Column(name = "images", columnDefinition = "NVARCHAR(255)")
    private String images;

    @Column(name = "unit_price")
    private Double unitPrice;

    @Column(name = "discount")
    private Double discount;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "status")
    private Short status;

    @Column(name = "description", columnDefinition = "NVARCHAR(1000)")
    private String description;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "create_date")
    private Date createDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    public Product() {}

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
    public Double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(Double unitPrice) { this.unitPrice = unitPrice; }
    public Double getDiscount() { return discount; }
    public void setDiscount(Double discount) { this.discount = discount; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public Short getStatus() { return status; }
    public void setStatus(Short status) { this.status = status; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }
    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}