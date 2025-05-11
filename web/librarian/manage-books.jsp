<%-- 
    Document   : manage-books.jsp
    Created on : May 10, 2025, 11:47:58 PM
    Author     : hakus
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    String studentName = (String) session.getAttribute("full_name");
    if (studentName == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Books - Library Management System</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            body {
                background-color: #f0f2f5;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                display: flex;
            }

            /* Additional styles for Manage Books page */
            .page-header {
                margin-bottom: 25px;
            }

            .page-title {
                font-size: 1.8rem;
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 5px;
            }

            .page-subtitle {
                color: #6c757d;
                font-size: 0.9rem;
            }

            .actions-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 15px;
            }

            .filter-group {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .books-table-container {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                overflow: hidden;
                margin-bottom: 30px;
            }

            .table {
                margin-bottom: 0;
            }

            .table th {
                background-color: #f8f9fa;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.8rem;
                letter-spacing: 0.5px;
                color: #6c757d;
            }

            .table td {
                vertical-align: middle;
            }

            .status-pill {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 50px;
                font-size: 0.8rem;
                font-weight: 500;
                text-align: center;
                min-width: 80px;
            }

            .status-available {
                background-color: rgba(76, 201, 240, 0.15);
                color: var(--success-color);
            }

            .status-low {
                background-color: rgba(247, 37, 133, 0.15);
                color: var(--warning-color);
            }

            .action-btns {
                display: flex;
                gap: 5px;
            }

            .action-btn {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #f0f2f5;
                color: #6c757d;
                transition: all 0.3s;
                border: none;
            }

            .action-btn:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .pagination-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 20px;
                background-color: #f8f9fa;
                border-top: 1px solid #e9ecef;
            }

            .pagination-info {
                color: #6c757d;
                font-size: 0.9rem;
            }

            .pagination {
                margin-bottom: 0;
            }

            .page-link {
                color: var(--primary-color);
                border-radius: 5px;
                margin: 0 2px;
            }

            .page-link.active {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .book-cover {
                width: 40px;
                height: 55px;
                object-fit: cover;
                border-radius: 4px;
            }

            @media (max-width: 992px) {
                .actions-bar {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .filter-group {
                    width: 100%;
                }

                .table-responsive {
                    font-size: 0.85rem;
                }

                .action-btns {
                    flex-direction: column;
                    gap: 5px;
                }
            }
        </style>
    </head>
    <body>
        <%-- Include the navbar component --%>
        <jsp:include page="librarian-navbar.jsp" />

        <!-- Main Content Area -->
        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">Manage Books</h1>
                <p class="page-subtitle">View, add, edit, and manage all library books</p>
            </div>

            <div class="actions-bar">
                <div class="filter-group">
                    <select class="form-select" aria-label="Filter by category">
                        <option selected>All Categories</option>
                        <option value="1">Fiction</option>
                        <option value="2">Non-Fiction</option>
                        <option value="3">Science & Technology</option>
                        <option value="4">History</option>
                        <option value="5">Arts & Literature</option>
                    </select>
                    <select class="form-select" aria-label="Filter by availability">
                        <option selected>All Status</option>
                        <option value="1">Available</option>
                        <option value="2">Low Stock</option>
                        <option value="3">Out of Stock</option>
                    </select>
                    <button class="btn btn-outline-secondary">
                        <i class="fas fa-filter me-2"></i>Apply Filters
                    </button>
                </div>
                <div>
                    <a href="add-book.jsp" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Add New Book
                    </a>
                </div>
            </div>

            <div class="books-table-container">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th style="width: 50px;">#</th>
                                <th style="width: 60px;">Cover</th>
                                <th>Title</th>
                                <th>Author</th>
                                <th>ISBN</th>
                                <th>Category</th>
                                <th>Total Copies</th>
                                <th>Available</th>
                                <th>Status</th>
                                <th style="width: 120px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td><img src="img/default-book.png" alt="Book Cover" class="book-cover"></td>
                                <td>Data Structures and Algorithms</td>
                                <td>Robert C. Martin</td>
                                <td>9780132350884</td>
                                <td>Computer Science</td>
                                <td>25</td>
                                <td>18</td>
                                <td><span class="status-pill status-available">Available</span></td>
                                <td>
                                    <div class="action-btns">
                                        <button class="action-btn" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" title="Delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td><img src="img/default-book.png" alt="Book Cover" class="book-cover"></td>
                                <td>Machine Learning Basics</td>
                                <td>Andrew Ng</td>
                                <td>9780262035613</td>
                                <td>Computer Science</td>
                                <td>15</td>
                                <td>2</td>
                                <td><span class="status-pill status-low">Low Stock</span></td>
                                <td>
                                    <div class="action-btns">
                                        <button class="action-btn" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" title="Delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td><img src="img/default-book.png" alt="Book Cover" class="book-cover"></td>
                                <td>Introduction to Python</td>
                                <td>Mark Lutz</td>
                                <td>9781449355739</td>
                                <td>Programming</td>
                                <td>30</td>
                                <td>20</td>
                                <td><span class="status-pill status-available">Available</span></td>
                                <td>
                                    <div class="action-btns">
                                        <button class="action-btn" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" title="Delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td><img src="img/default-book.png" alt="Book Cover" class="book-cover"></td>
                                <td>Advanced Web Development</td>
                                <td>Sarah Johnson</td>
                                <td>9780136511753</td>
                                <td>Web Development</td>
                                <td>20</td>
                                <td>15</td>
                                <td><span class="status-pill status-available">Available</span></td>
                                <td>
                                    <div class="action-btns">
                                        <button class="action-btn" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" title="Delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td><img src="img/default-book.png" alt="Book Cover" class="book-cover"></td>
                                <td>Database Systems</td>
                                <td>Thomas Connolly</td>
                                <td>9781292061184</td>
                                <td>Database</td>
                                <td>12</td>
                                <td>3</td>
                                <td><span class="status-pill status-low">Low Stock</span></td>
                                <td>
                                    <div class="action-btns">
                                        <button class="action-btn" title="Edit">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="action-btn" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button class="action-btn" title="Delete">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="pagination-container">
                    <div class="pagination-info">
                        Showing <span class="fw-bold">1-5</span> of <span class="fw-bold">1,020</span> books
                    </div>
                    <nav aria-label="Books pagination">
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" aria-label="Previous">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Next">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>