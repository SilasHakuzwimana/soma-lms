<%-- 
    Document   : add-book.jsp
    Created on : May 11, 2025, 3:13:04 PM
    Author     : hakus
    Updated on : May 11, 2025
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="dao.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Book - SOMA LMS</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4361ee;
                --primary-hover: #3a56d4;
                --secondary-color: #3f37c9;
                --accent-color: #4cc9f0;
                --text-primary: #333333;
                --text-secondary: #6c757d;
                --bg-light: #f8f9fa;
                --bg-card: #ffffff;
                --success-color: #38b000;
                --warning-color: #ff9e00;
                --danger-color: #e5383b;
                --border-radius: 12px;
                --box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                --transition: all 0.3s ease;
            }

            body {
                background-color: #f5f7fa;
                font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
                color: var(--text-primary);
            }

            .content-wrapper {
                padding: 2rem 0;
            }

            .content-header {
                margin-bottom: 2rem;
                position: relative;
                padding-bottom: 0.75rem;
                border-bottom: 1px solid #e9ecef;
            }

            .content-header h1 {
                font-size: 1.75rem;
                font-weight: 700;
                color: var(--text-primary);
                margin-bottom: 0.5rem;
            }

            .content-header .breadcrumb {
                padding: 0;
                margin-bottom: 0;
                background-color: transparent;
                font-size: 0.85rem;
            }

            .breadcrumb-item a {
                color: var(--primary-color);
                text-decoration: none;
            }

            .breadcrumb-item.active {
                color: var(--text-secondary);
            }

            .card {
                border: none;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                margin-bottom: 2rem;
                overflow: hidden;
            }

            .card-header {
                background-color: #fff;
                border-bottom: 1px solid #e9ecef;
                padding: 1.25rem 1.5rem;
                font-weight: 600;
                display: flex;
                align-items: center;
            }

            .card-header i {
                color: var(--primary-color);
                margin-right: 0.75rem;
                font-size: 1.1rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .form-label {
                font-weight: 500;
                color: var(--text-primary);
                margin-bottom: 0.5rem;
                font-size: 0.9rem;
            }

            .form-control {
                border-radius: 8px;
                padding: 0.75rem 1rem;
                border: 1px solid #e1e5eb;
                font-size: 0.95rem;
                transition: var(--transition);
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.15);
            }

            .form-text {
                font-size: 0.8rem;
                color: var(--text-secondary);
            }

            .required-field::after {
                content: "*";
                color: var(--danger-color);
                margin-left: 3px;
            }

            .btn {
                padding: 0.65rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                transition: var(--transition);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-primary:hover {
                background-color: var(--primary-hover);
                border-color: var(--primary-hover);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(67, 97, 238, 0.15);
            }

            .btn-secondary {
                background-color: #eaecf4;
                border-color: #eaecf4;
                color: var(--text-secondary);
            }

            .btn-secondary:hover {
                background-color: #dee2e6;
                border-color: #dee2e6;
                color: var(--text-primary);
            }

            .btn-danger {
                background-color: transparent;
                border-color: #f9d7d7;
                color: var(--danger-color);
            }

            .btn-danger:hover {
                background-color: #fee2e2;
                border-color: #fee2e2;
                color: #cf1124;
            }

            .btn i {
                margin-right: 0.5rem;
            }

            .toast-container {
                position: fixed;
                top: 1rem;
                right: 1rem;
                z-index: 1055;
            }

            .toast {
                border-radius: 8px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            }

            .file-upload {
                position: relative;
                display: flex;
                align-items: center;
                border: 2px dashed #e1e5eb;
                border-radius: 8px;
                background-color: #f8fafd;
                padding: 1.5rem;
                cursor: pointer;
                transition: var(--transition);
                text-align: center;
                margin-bottom: 1rem;
            }

            .file-upload:hover {
                border-color: var(--primary-color);
                background-color: #f0f4ff;
            }

            .file-upload input[type="file"] {
                position: absolute;
                width: 100%;
                height: 100%;
                top: 0;
                left: 0;
                opacity: 0;
                cursor: pointer;
            }

            .file-upload-content {
                width: 100%;
            }

            .file-upload-icon {
                font-size: 2rem;
                color: var(--primary-color);
                margin-bottom: 0.75rem;
            }

            .file-upload-text {
                font-size: 0.95rem;
                color: var(--text-secondary);
            }

            .file-upload-text strong {
                color: var(--primary-color);
                text-decoration: underline;
            }

            .form-section-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: var(--text-primary);
                margin: 1.5rem 0 1rem;
                padding-bottom: 0.5rem;
                border-bottom: 1px solid #eaecf4;
            }

            .form-section-title:first-child {
                margin-top: 0;
            }

            .action-buttons {
                display: flex;
                gap: 1rem;
                margin-top: 1.5rem;
            }

            textarea.form-control {
                min-height: 100px;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .content-wrapper {
                    padding: 1rem 0;
                }

                .card-header, .card-body {
                    padding: 1rem;
                }

                .form-section-title {
                    font-size: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Include librarian navbar -->
        <jsp:include page="librarian-navbar.jsp" />

        <div class="content-wrapper">
            <div class="container">
                <div class="content-header">
                    <h1><i class="fas fa-book-medical"></i> Add New Book</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="librariandashboard.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item"><a href="manage-books.jsp">Books</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Add Book</li>
                        </ol>
                    </nav>
                </div>

                <!-- Toast Container -->
                <div class="toast-container">
                    <% if (request.getParameter("error") != null) {%>
                    <div class="toast align-items-center text-bg-danger border-0 show" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="d-flex">
                            <div class="toast-body">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%= request.getParameter("error")%>
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                    </div>
                    <% }%>
                    <% if (request.getParameter("success") != null) {%>
                    <div class="toast align-items-center text-bg-success border-0 show" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="d-flex">
                            <div class="toast-body">
                                <i class="fas fa-check-circle me-2"></i>
                                <%= request.getParameter("success")%>
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                    </div>
                    <% }%>
                </div>

                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-plus-circle"></i> Book Information
                    </div>
                    <div class="card-body">
                        <form action="/books/create" method="post" enctype="multipart/form-data">
                            <div class="form-section-title">Book Details</div>

                            <div class="file-upload mb-4">
                                <input type="file" name="cover_image" id="coverImageUpload" accept="image/*">
                                <div class="file-upload-content">
                                    <div class="file-upload-icon">
                                        <i class="fas fa-upload"></i>
                                    </div>
                                    <div class="file-upload-text">
                                        Drag & drop a cover image or <strong>Browse</strong>
                                        <p class="mt-1 mb-0">Supports: JPG, PNG, GIF (Max 5MB)</p>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label for="title" class="form-label required-field">Title</label>
                                    <input type="text" name="title" id="title" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="subtitle" class="form-label">Subtitle</label>
                                    <input type="text" name="subtitle" id="subtitle" class="form-control">
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label for="author" class="form-label required-field">Author</label>
                                    <input type="text" name="author" id="author" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="isbn" class="form-label required-field">ISBN</label>
                                    <input type="text" name="isbn" id="isbn" class="form-control" required>
                                    <div class="form-text">Enter ISBN-10 or ISBN-13 format</div>
                                </div>
                            </div>


                            <div class="row g-3 mb-3">
                                <div class="col-md-4">
                                    <label for="category_id" class="form-label required-field">Category</label>
                                    <select name="category_id" id="category_id" class="form-select" required>
                                        <option value="" disabled selected>Select a category</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.id}">${cat.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <label for="publisher" class="form-label required-field">Publisher</label>
                                <input type="text" name="publisher" id="publisher" class="form-control" required>
                            </div>
                            <div class="col-md-4">
                                <label for="publication_year" class="form-label required-field">Publication Year</label>
                                <input type="number" name="publication_year" id="publication_year" class="form-control" min="1800" max="2050" required>
                            </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-4">
                            <label for="edition" class="form-label">Edition</label>
                            <input type="text" name="edition" id="edition" class="form-control">
                        </div>
                        <div class="col-md-4">
                            <label for="language" class="form-label required-field">Language</label>
                            <input type="text" name="language" id="language" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label for="pages" class="form-label required-field">Pages</label>
                            <input type="number" name="pages" id="pages" class="form-control" min="1" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea name="description" id="description" class="form-control" rows="4"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="cover_image_url" class="form-label">Cover Image URL (Optional)</label>
                        <input type="text" name="cover_image_url" id="cover_image_url" class="form-control">
                        <div class="form-text">Alternative to file upload. Provide a direct URL to an image.</div>
                    </div>

                    <div class="form-section-title">Inventory Information</div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-4">
                            <label for="total_copies" class="form-label required-field">Total Copies</label>
                            <input type="number" name="total_copies" id="total_copies" class="form-control" min="1" required>
                        </div>
                        <div class="col-md-4">
                            <label for="available_copies" class="form-label required-field">Available Copies</label>
                            <input type="number" name="available_copies" id="available_copies" class="form-control" min="0" required>
                        </div>
                        <div class="col-md-4">
                            <label for="location" class="form-label required-field">Shelf Location</label>
                            <input type="text" name="location" id="location" class="form-control" required>
                            <div class="form-text">e.g., "Floor 2, Shelf B-12"</div>
                        </div>
                    </div>

                    <input type="hidden" name="added_by" value="${sessionScope.user_id}">

                    <div class="action-buttons">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Book
                        </button>
                        <button type="reset" class="btn btn-secondary">
                            <i class="fas fa-undo"></i> Reset Form
                        </button>
                        <a href="books.jsp" class="btn btn-danger">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Auto-hide toast after 5 seconds
            const toasts = document.querySelectorAll('.toast');
            toasts.forEach(toast => {
                setTimeout(() => {
                    const bsToast = bootstrap.Toast.getInstance(toast);
                    if (bsToast) {
                        bsToast.hide();
                    }
                }, 5000);
            });

            // Handle file upload preview
            const fileInput = document.getElementById('coverImageUpload');
            const fileUpload = document.querySelector('.file-upload');

            fileInput.addEventListener('change', function () {
                if (this.files && this.files[0]) {
                    const reader = new FileReader();

                    reader.onload = function (e) {
                        fileUpload.style.backgroundImage = `url('${e.target.result}')`;
                        fileUpload.style.backgroundSize = 'cover';
                        fileUpload.style.backgroundPosition = 'center';
                        fileUpload.querySelector('.file-upload-content').innerHTML = `
                            <div class="file-upload-text">
                                <strong>${fileInput.files[0].name}</strong>
                                <p class="mt-1 mb-0">Click to change</p>
                            </div>
                        `;
                    };

                    reader.readAsDataURL(this.files[0]);
                }
            });

            // Total copies and available copies validation
            const totalCopies = document.getElementById('total_copies');
            const availableCopies = document.getElementById('available_copies');

            totalCopies.addEventListener('change', function () {
                if (parseInt(availableCopies.value) > parseInt(this.value)) {
                    availableCopies.value = this.value;
                }
                availableCopies.max = this.value;
            });

            // Form validation
            const form = document.querySelector('form');
            form.addEventListener('submit', function (event) {
                if (parseInt(availableCopies.value) > parseInt(totalCopies.value)) {
                    event.preventDefault();
                    alert('Available copies cannot exceed total copies');
                }
            });

            // Auto-dismiss toast
            const toastElList = [].slice.call(document.querySelectorAll('.toast'));
            const toastList = toastElList.map(function (toastEl) {
                return new bootstrap.Toast(toastEl, {
                    autohide: true,
                    delay: 5000
                });
            });
        });
    </script>
</body>
</html>