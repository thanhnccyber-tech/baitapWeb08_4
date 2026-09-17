<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Product - AJAX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-3">Quản lý Product (AJAX + REST API)</h2>

    <p>
        <button class="btn btn-success" onclick="showCreateNewProductModal()">
            <i class="fas fa-plus"></i> Thêm Product Ajax
        </button>
        <a href="${pageContext.request.contextPath}/admin/category" class="btn btn-info">
            <i class="fas fa-tags"></i> Quản lý Category
        </a>
    </p>

    <table class="table table-bordered table-hover" id="productTable">
        <thead class="table-dark">
            <tr>
                <th>Id</th>
                <th>Image</th>
                <th>Name</th>
                <th>Price</th>
                <th>Discount</th>
                <th>Qty</th>
                <th>Category</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<!-- MODAL ADD -->
<div class="modal fade" id="createProductModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form id="addProduct" enctype="multipart/form-data" onsubmit="return false;">
                <div class="modal-header">
                    <h5 class="modal-title">Add Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>Product Name</label>
                            <input type="text" class="form-control" name="productName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Image</label>
                            <input type="file" class="form-control" name="imageFile" accept="image/*">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Unit Price</label>
                            <input type="number" step="0.01" class="form-control" name="unitPrice" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Discount</label>
                            <input type="number" step="0.01" class="form-control" name="discount" value="0">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Quantity</label>
                            <input type="number" class="form-control" name="quantity" required>
                        </div>
                        <div class="col-md-8 mb-3">
                            <label>Category</label>
                            <select class="form-control" name="categoryId" id="categorySelectAdd" required></select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Status</label>
                            <select class="form-control" name="status">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                        <div class="col-12 mb-3">
                            <label>Description</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Add</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- MODAL UPDATE -->
<div class="modal fade" id="updateProductModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form id="updateProduct" enctype="multipart/form-data" onsubmit="return false;">
                <div class="modal-header">
                    <h5 class="modal-title">Update Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="productId" id="productId_up">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label>Product Name</label>
                            <input type="text" class="form-control" id="productName_up" name="productName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label>Image (để trống nếu không đổi)</label>
                            <input type="file" class="form-control" name="imageFile" accept="image/*">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Unit Price</label>
                            <input type="number" step="0.01" class="form-control" id="unitPrice_up" name="unitPrice" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Discount</label>
                            <input type="number" step="0.01" class="form-control" id="discount_up" name="discount">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Quantity</label>
                            <input type="number" class="form-control" id="quantity_up" name="quantity" required>
                        </div>
                        <div class="col-md-8 mb-3">
                            <label>Category</label>
                            <select class="form-control" name="categoryId" id="categorySelectUpdate" required></select>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Status</label>
                            <select class="form-control" id="status_up" name="status">
                                <option value="1">Active</option>
                                <option value="0">Inactive</option>
                            </select>
                        </div>
                        <div class="col-12 mb-3">
                            <label>Description</label>
                            <textarea class="form-control" id="description_up" name="description" rows="3"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- ===== SCRIPTS ĐẶT CUỐI BODY ===== -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
    var contextPath = "${pageContext.request.contextPath}";

    $(document).ready(function () {
        loadCategoryOptions(function() {
            loadProducts();
        });
    });

    window.addEventListener('pageshow', function (event) {
        if (event.persisted) {
            loadCategoryOptions(function() {
                loadProducts();
            });
        }
    });

    function loadCategoryOptions(callback) {
        $.ajax({
            url: contextPath + '/api/category',
            type: 'GET',
            dataType: 'json',
            cache: false,
            success: function (json) {
                var html = '';
                for (var i = 0; i < json.length; i++) {
                    html += '<option value="' + json[i].categoryId + '">' + json[i].categoryName + '</option>';
                }
                $('#categorySelectAdd').html(html);
                $('#categorySelectUpdate').html(html);
                if (callback) callback();
            },
            error: function (xhr, status, err) {
                console.error('Load categories failed:', status, err);
            }
        });
    }

    function loadProducts() {
        $.ajax({
            url: contextPath + '/api/product',
            type: 'GET',
            dataType: 'json',
            cache: false,
            success: function (res) {
                var json = res.data || [];
                var tr = [];
                for (var i = 0; i < json.length; i++) {
                    var p = json[i];
                    var catName = (p.category && p.category.categoryName) ? p.category.categoryName : '';
                    tr.push('<tr>');
                    tr.push('<td>' + p.productId + '</td>');
                    tr.push('<td><img src="' + contextPath + '/uploads/' + p.images +
                            '" style="width:60px" class="img-fluid"></td>');
                    tr.push('<td>' + p.productName + '</td>');
                    tr.push('<td>' + p.unitPrice + '</td>');
                    tr.push('<td>' + (p.discount || 0) + '</td>');
                    tr.push('<td>' + p.quantity + '</td>');
                    tr.push('<td>' + catName + '</td>');
                    tr.push('<td>' +
                        '<a href="#" data-id="' + p.productId + '" class="btn btn-outline-warning btn-edit-prod">' +
                        '<i class="fa fa-edit"></i></a> ' +
                        '<a href="#" data-id="' + p.productId + '" class="btn btn-outline-danger btn-del-prod">' +
                        '<i class="fa fa-trash"></i></a>' +
                        '</td>');
                    tr.push('</tr>');
                }
                $('#productTable tbody').html(tr.join(''));
            },
            error: function (xhr, status, err) {
                console.error('Load products failed:', status, err);
            }
        });
    }

    function showCreateNewProductModal() {
        $('#addProduct')[0].reset();
        loadCategoryOptions();
        $('#createProductModal').modal('show');
    }

    /* ADD */
    $("#addProduct").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: contextPath + '/api/product/addProduct',
            type: 'POST',
            data: formData,
            dataType: 'json',
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if (data.success) {
                    alert(data.message);
                    $('#createProductModal').modal('hide');
                    loadProducts();
                } else {
                    alert(data.message);
                }
            },
            error: function () {
                alert('Có lỗi khi thêm product');
            }
        });
    });

    /* SHOW UPDATE */
    $(document).on('click', '.btn-edit-prod', function (e) {
        e.preventDefault();
        var id = $(this).data('id');
        $.ajax({
            url: contextPath + '/api/product/getProduct',
            type: 'POST',
            data: { id: id },
            dataType: 'json',
            cache: false,
            success: function (res) {
                if (res.success) {
                    var p = res.data;
                    loadCategoryOptions(function () {
                        $('#productId_up').val(p.productId);
                        $('#productName_up').val(p.productName);
                        $('#unitPrice_up').val(p.unitPrice);
                        $('#discount_up').val(p.discount || 0);
                        $('#quantity_up').val(p.quantity);
                        $('#status_up').val(p.status);
                        $('#description_up').val(p.description);
                        if (p.category) {
                            $('#categorySelectUpdate').val(p.category.categoryId);
                        }
                        $('#updateProductModal').modal('show');
                    });
                } else {
                    alert(res.message);
                }
            }
        });
    });

    /* UPDATE */
    $("#updateProduct").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: contextPath + '/api/product/updateProduct',
            type: 'PUT',
            data: formData,
            dataType: 'json',
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if (data.success) {
                    alert(data.message);
                    $('#updateProductModal').modal('hide');
                    loadProducts();
                } else {
                    alert(data.message);
                }
            }
        });
    });

    /* DELETE */
    $(document).on('click', '.btn-del-prod', function (e) {
        e.preventDefault();
        var id = $(this).data('id');
        if (confirm('Bạn có chắc muốn xóa?')) {
            $.ajax({
                type: 'DELETE',
                url: contextPath + '/api/product/deleteProduct?productId=' + id,
                dataType: 'json',
                cache: false,
                success: function (data) {
                    alert(data.message);
                    loadProducts();
                },
                error: function () { alert('Xóa thất bại'); }
            });
        }
    });
</script>
</body>
</html>