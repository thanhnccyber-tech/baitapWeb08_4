<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Category - AJAX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-3">Quản lý Category (AJAX + REST API)</h2>

    <p>
        <button class="btn btn-success" onclick="showCreateNewCategoryModal()">
            <i class="fas fa-plus"></i> Thêm Category Ajax
        </button>
        <a href="${pageContext.request.contextPath}/admin/product" class="btn btn-info">
            <i class="fas fa-box"></i> Quản lý Product
        </a>
    </p>

    <table class="table table-bordered table-hover" id="categoryTable">
        <thead class="table-dark">
            <tr>
                <th>Id</th>
                <th>Icon</th>
                <th>Name</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<!-- MODAL ADD -->
<div class="modal fade" id="createCategoryModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="addCategory" method="post" onsubmit="return false;" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title">Add Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="form-group mb-3">
                        <label>Category Name</label>
                        <input type="text" class="form-control" id="new_categoryname" name="categoryName" required>
                    </div>
                    <div class="form-group mb-3">
                        <label>Icon</label>
                        <input type="file" class="form-control" id="new_icon" name="icon" accept="image/*">
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
<div class="modal fade" id="updateCategoryInfoModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Update Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="updateCategoryInfoModalId"></p>
                <p id="updateCategoryInfoModalName"></p>
                <p id="updateCategoryInfoModalIcon"></p>

                <form id="updateCategory" method="post" onsubmit="return false;" enctype="multipart/form-data">
                    <div class="form-group mb-3">
                        <label>Category Name</label>
                        <input type="text" class="form-control" id="categoryName_up" name="categoryName" required>
                    </div>
                    <div class="form-group mb-3">
                        <label>Icon mới (để trống nếu không đổi)</label>
                        <input type="file" class="form-control" id="icon_up" name="icon" accept="image/*">
                    </div>
                    <input type="hidden" id="categoryId_up" name="categoryId">
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<!-- ===== SCRIPTS ĐẶT CUỐI BODY ===== -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
    var contextPath = "${pageContext.request.contextPath}";

    $(document).ready(function () {
        loadCategories();
    });

    // Xử lý back/forward
    window.addEventListener('pageshow', function (event) {
        if (event.persisted) {
            loadCategories();
        }
    });

    function loadCategories() {
        $.ajax({
            url: contextPath + '/api/category',
            type: 'GET',
            dataType: 'json',
            cache: false,
            success: function (json) {
                var tr = [];
                for (var i = 0; i < json.length; i++) {
                    tr.push('<tr>');
                    tr.push('<td>' + json[i].categoryId + '</td>');
                    tr.push('<td><img src="' + contextPath + '/uploads/' + json[i].icon +
                            '" style="width:70px" class="img-fluid" alt=""></td>');
                    tr.push('<td>' + json[i].categoryName + '</td>');
                    tr.push('<td>' +
                        '<a href="#" data-id="' + json[i].categoryId +
                        '" class="btn btn-outline-warning btn-edit-cat">' +
                        '<i class="fa fa-edit"></i></a> ' +
                        '<a href="#" data-id="' + json[i].categoryId +
                        '" class="btn btn-outline-danger btn-del-cat">' +
                        '<i class="fa fa-trash"></i></a>' +
                        '</td>');
                    tr.push('</tr>');
                }
                $('#categoryTable tbody').html(tr.join(''));
            },
            error: function (xhr, status, err) {
                console.error('Load categories failed:', status, err);
            }
        });
    }

    /* ADD */
    $("#addCategory").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: contextPath + '/api/category/addCategory',
            type: 'POST',
            dataType: 'json',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if (data.success) {
                    alert(data.message);
                    $('#createCategoryModal').modal('hide');
                    loadCategories();   // ← Load lại data KHÔNG cần reload trang
                } else {
                    alert(data.message);
                }
            },
            error: function () {
                alert('Có lỗi xảy ra khi thêm');
            }
        });
    });

    function showCreateNewCategoryModal() {
        $('#new_categoryname').val('');
        $('#new_icon').val('');
        $('#createCategoryModal').modal('show');
    }

    /* SHOW UPDATE */
    $(document).on('click', '.btn-edit-cat', function (e) {
        e.preventDefault();
        var id = $(this).data('id');
        $.ajax({
            url: contextPath + '/api/category/getCategory',
            type: 'POST',
            data: { id: id },
            dataType: 'json',
            cache: false,
            success: function (res) {
                if (res.success) {
                    var c = res.data;
                    $('#updateCategoryInfoModalId')[0].innerText = 'Category ID: ' + c.categoryId;
                    $('#updateCategoryInfoModalName')[0].innerText = 'Category Name: ' + c.categoryName;
                    $('#updateCategoryInfoModalIcon')[0].innerText = 'Icon: ' + (c.icon || '');
                    $('#categoryName_up').val(c.categoryName);
                    $('#categoryId_up').val(c.categoryId);
                    $('#updateCategoryInfoModal').modal('show');
                } else {
                    alert(res.message);
                }
            }
        });
    });

    /* UPDATE */
    $("#updateCategory").submit(function (e) {
        e.preventDefault();
        var formData = new FormData(this);
        $.ajax({
            url: contextPath + '/api/category/updateCategory',
            type: 'PUT',
            dataType: 'json',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                if (data.success) {
                    alert(data.message);
                    $('#updateCategoryInfoModal').modal('hide');
                    loadCategories();   // ← Load lại data KHÔNG cần reload trang
                } else {
                    alert(data.message);
                }
            }
        });
    });

    /* DELETE */
    $(document).on('click', '.btn-del-cat', function (e) {
        e.preventDefault();
        var id = $(this).data('id');
        if (confirm('Bạn có chắc muốn xóa?')) {
            $.ajax({
                type: 'DELETE',
                url: contextPath + '/api/category/deleteCategory?categoryId=' + id,
                dataType: 'json',
                cache: false,
                success: function (data) {
                    alert(data.message);
                    loadCategories();   // ← Load lại data KHÔNG cần reload trang
                },
                error: function () {
                    alert('Xóa thất bại');
                }
            });
        }
    });
</script>
</body>
</html>