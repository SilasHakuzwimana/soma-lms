<%-- 
    Document   : search-book.jsp
    Created on : May 10, 2025, 11:44:54 PM
    Author     : hakus
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <title>Search Books | Library Management System</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --accent-color: #4895ef;
                --success-color: #4cc9f0;
                --warning-color: #f72585;
                --info-color: #560bad;
                --light-color: #f8f9fa;
                --dark-color: #212529;
            }

            body {
                background-color: #f0f2f5;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .wrapper {
                display: flex;
                width: 100%;
                min-height: 100vh;
            }

            /* Sidebar Styles */
            .sidebar {
                width: 280px;
                background: linear-gradient(180deg, var(--primary-color), var(--secondary-color));
                color: white;
                transition: all 0.3s;
                position: fixed;
                height: 100%;
                z-index: 1000;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            }

            .sidebar-header {
                padding: 20px;
                background: rgba(0, 0, 0, 0.1);
            }

            .sidebar-brand {
                font-size: 1.5rem;
                font-weight: 700;
                color: white;
                text-decoration: none;
            }

            .sidebar .nav-link {
                padding: 15px 20px;
                color: rgba(255, 255, 255, 0.85);
                border-radius: 5px;
                margin: 5px 15px;
                transition: all 0.3s;
            }

            .sidebar .nav-link:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
                transform: translateX(5px);
            }

            .sidebar .nav-link.active {
                background-color: rgba(255, 255, 255, 0.2);
                color: white;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .sidebar .nav-link i {
                width: 24px;
                text-align: center;
                margin-right: 10px;
            }

            .sidebar-footer {
                position: absolute;
                bottom: 0;
                width: 100%;
                padding: 15px;
                background: rgba(0, 0, 0, 0.1);
            }

            /* Main Content Styles */
            .content {
                width: calc(100% - 280px);
                margin-left: 280px;
                padding: 30px;
                transition: all 0.3s;
            }

            .page-header {
                margin-bottom: 30px;
            }

            .navbar-top {
                background-color: white;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                padding: 15px 30px;
                margin-bottom: 30px;
                border-radius: 10px;
            }

            .navbar-top .search-form {
                max-width: 300px;
            }

            .navbar-top .input-group {
                border-radius: 20px;
                overflow: hidden;
            }

            .navbar-top .form-control {
                border-right: none;
                background: #f8f9fa;
            }

            .navbar-top .btn-search {
                background: #f8f9fa;
                border-left: none;
                color: #6c757d;
            }

            .user-dropdown .dropdown-toggle::after {
                display: none;
            }

            .notification-badge {
                position: absolute;
                top: 3px;
                right: 3px;
                width: 18px;
                height: 18px;
                background-color: var(--warning-color);
                color: white;
                font-size: 0.6rem;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
            }

            /* Search Book Specific Styles */
            .search-container {
                background-color: white;
                border-radius: 12px;
                padding: 30px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                margin-bottom: 30px;
            }

            .search-header {
                margin-bottom: 25px;
            }

            .advanced-search-toggle {
                color: var(--primary-color);
                cursor: pointer;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
            }

            .advanced-search-toggle i {
                transition: all 0.3s;
                margin-left: 5px;
            }

            .advanced-search-toggle.collapsed i {
                transform: rotate(-90deg);
            }

            .main-search-input {
                border-radius: 30px;
                padding: 12px 20px;
                font-size: 1.1rem;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
                border: 1px solid #dee2e6;
            }

            .search-btn {
                border-radius: 30px;
                padding: 12px 25px;
                font-weight: 600;
            }

            .filter-badge {
                background-color: var(--primary-color);
                color: white;
                border-radius: 30px;
                padding: 5px 15px;
                margin-right: 10px;
                margin-bottom: 10px;
                display: inline-flex;
                align-items: center;
                font-size: 0.9rem;
            }

            .filter-badge i {
                margin-left: 5px;
                cursor: pointer;
            }

            .book-card {
                background-color: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                transition: all 0.3s;
                height: 100%;
                border: none;
            }

            .book-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }

            .book-img-container {
                height: 200px;
                overflow: hidden;
                position: relative;
                background-color: #f8f9fa;
            }

            .book-img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .book-status {
                position: absolute;
                top: 10px;
                right: 10px;
                padding: 5px 10px;
                border-radius: 5px;
                font-size: 0.8rem;
                font-weight: 600;
            }

            .book-status.available {
                background-color: rgba(76, 201, 240, 0.9);
                color: white;
            }

            .book-status.borrowed {
                background-color: rgba(247, 37, 133, 0.9);
                color: white;
            }

            .book-info {
                padding: 20px;
            }

            .book-title {
                font-size: 1.1rem;
                font-weight: 600;
                margin-bottom: 5px;
                color: var(--dark-color);
            }

            .book-author {
                color: #6c757d;
                font-size: 0.9rem;
                margin-bottom: 10px;
            }

            .book-meta {
                display: flex;
                justify-content: space-between;
                color: #6c757d;
                font-size: 0.85rem;
                margin-bottom: 15px;
            }

            .book-actions {
                display: flex;
                justify-content: space-between;
            }

            .book-actions .btn {
                border-radius: 5px;
                font-size: 0.9rem;
                padding: 5px 10px;
            }

            .book-actions .btn i {
                margin-right: 5px;
            }

            .book-actions .btn-details {
                background-color: var(--light-color);
                color: var(--dark-color);
            }

            .book-actions .btn-borrow {
                background-color: var(--primary-color);
                color: white;
            }

            .book-actions .btn-reserve {
                background-color: var(--warning-color);
                color: white;
            }

            .filter-section {
                margin-bottom: 20px;
            }

            .filter-section label {
                font-weight: 600;
                margin-bottom: 10px;
                display: block;
            }

            .genre-filter {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }

            .genre-filter .genre-item {
                background-color: #f8f9fa;
                border-radius: 5px;
                padding: 5px 15px;
                font-size: 0.9rem;
                cursor: pointer;
                transition: all 0.2s;
            }

            .genre-filter .genre-item:hover,
            .genre-filter .genre-item.active {
                background-color: var(--primary-color);
                color: white;
            }

            .pagination-container {
                margin-top: 30px;
                display: flex;
                justify-content: center;
            }

            .pagination .page-item .page-link {
                color: var(--dark-color);
                border-radius: 5px;
                margin: 0 3px;
            }

            .pagination .page-item.active .page-link {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                color: white;
            }

            /* Mobile Responsiveness */
            @media (max-width: 992px) {
                .sidebar {
                    width: 80px;
                    text-align: center;
                }

                .sidebar .nav-link span {
                    display: none;
                }

                .sidebar .nav-link i {
                    margin-right: 0;
                    font-size: 1.2rem;
                }

                .sidebar-header h3 {
                    display: none;
                }

                .sidebar-brand .logo-text {
                    display: none;
                }

                .content {
                    width: calc(100% - 80px);
                    margin-left: 80px;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    margin-left: -80px;
                }

                .content {
                    width: 100%;
                    margin-left: 0;
                }

                .sidebar.active {
                    margin-left: 0;
                }

                .navbar-top {
                    position: relative;
                }

                .sidebarCollapse {
                    display: block;
                }

                .search-container {
                    padding: 20px;
                }

                .main-search-input {
                    padding: 10px 15px;
                }

                .search-btn {
                    padding: 10px 15px;
                }
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <!-- Sidebar -->
            <nav id="sidebar" class="sidebar">
                <div class="sidebar-header">
                    <a href="student-dashboard.jsp" class="sidebar-brand">
                        <i class="fas fa-book-reader me-2"></i>
                        <span class="logo-text">LibraryMS</span>
                    </a>
                </div>

                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a href="student-dashboard.jsp" class="nav-link">
                            <i class="fas fa-gauge-high"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="search-book.jsp" class="nav-link active">
                            <i class="fas fa-search"></i>
                            <span>Search Books</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="borrow-book.jsp" class="nav-link">
                            <i class="fas fa-book-open"></i>
                            <span>Borrow Books</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="return-book.jsp" class="nav-link">
                            <i class="fas fa-undo-alt"></i>
                            <span>Return Books</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="reserve-book.jsp" class="nav-link">
                            <i class="fas fa-bookmark"></i>
                            <span>Reserve Books</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="notifications.jsp" class="nav-link">
                            <i class="fas fa-bell"></i>
                            <span>Notifications</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="helpdesk.jsp" class="nav-link">
                            <i class="fas fa-headset"></i>
                            <span>Helpdesk</span>
                        </a>
                    </li>
                </ul>

                <div class="sidebar-footer">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a href="settings.jsp" class="nav-link">
                                <i class="fas fa-cog"></i>
                                <span>Settings</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="logout.jsp" class="nav-link">
                                <i class="fas fa-sign-out-alt"></i>
                                <span>Logout</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main Content -->
            <div class="content">
                <!-- Top Navigation Bar -->
                <nav class="navbar navbar-expand-lg navbar-light navbar-top">
                    <div class="container-fluid">
                        <button type="button" id="sidebarCollapse" class="btn btn-primary d-lg-none">
                            <i class="fas fa-bars"></i>
                        </button>

                        <form class="search-form me-auto d-none d-md-block">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Quick search...">
                                <button class="btn btn-search" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>

                        <div class="d-flex align-items-center">
                            <div class="position-relative me-4">
                                <a href="notifications.jsp" class="btn btn-light rounded-circle">
                                    <i class="fas fa-bell"></i>
                                    <span class="notification-badge">3</span>
                                </a>
                            </div>

                            <div class="dropdown user-dropdown">
                                <button class="btn dropdown-toggle d-flex align-items-center" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    <div class="avatar rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-2" style="width: 35px; height: 35px;">
                                        <%= studentName.substring(0, 1).toUpperCase()%>
                                    </div>
                                    <span class="d-none d-md-block"><%= studentName%></span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                    <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user me-2"></i>Profile</a></li>
                                    <li><a class="dropdown-item" href="settings.jsp"><i class="fas fa-cog me-2"></i>Settings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Header -->
                <div class="page-header">
                    <h2>Search Books</h2>
                    <p class="text-muted">Find books in our extensive library collection</p>
                </div>

                <!-- Search Container -->
                <div class="search-container">
                    <div class="search-header d-flex justify-content-between align-items-center">
                        <h4>Find Your Next Read</h4>
                        <a class="advanced-search-toggle" data-bs-toggle="collapse" href="#advancedSearch" role="button" aria-expanded="false" aria-controls="advancedSearch">
                            Advanced Search <i class="fas fa-chevron-down"></i>
                        </a>
                    </div>

                    <!-- Main Search Bar -->
                    <form action="" method="GET">
                        <div class="input-group mb-4">
                            <input type="text" class="form-control main-search-input" placeholder="Search by title, author, ISBN..." name="q">
                            <button class="btn btn-primary search-btn" type="submit">
                                <i class="fas fa-search me-2"></i> Search
                            </button>
                        </div>

                        <!-- Advanced Search Options -->
                        <div class="collapse" id="advancedSearch">
                            <div class="row g-3 mb-4">
                                <div class="col-md-4">
                                    <label class="form-label">Author</label>
                                    <input type="text" class="form-control" name="author" placeholder="Author name">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">ISBN</label>
                                    <input type="text" class="form-control" name="isbn" placeholder="ISBN number">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Publication Year</label>
                                    <select class="form-select" name="year">
                                        <option value="">Any Year</option>
                                        <option value="2025">2025</option>
                                        <option value="2024">2024</option>
                                        <option value="2023">2023</option>
                                        <option value="2022">2022</option>
                                        <option value="2021">2021</option>
                                        <option value="2020">2020</option>
                                        <option value="older">Before 2020</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Book Type</label>
                                    <select class="form-select" name="type">
                                        <option value="">All Types</option>
                                        <option value="textbook">Textbook</option>
                                        <option value="fiction">Fiction</option>
                                        <option value="non-fiction">Non-Fiction</option>
                                        <option value="reference">Reference</option>
                                        <option value="magazine">Magazine</option>
                                        <option value="journal">Journal</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Availability</label>
                                    <select class="form-select" name="availability">
                                        <option value="">Any</option>
                                        <option value="available">Available Now</option>
                                        <option value="reserved">Available for Reservation</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Language</label>
                                    <select class="form-select" name="language">
                                        <option value="">Any Language</option>
                                        <option value="en">English</option>
                                        <option value="es">Spanish</option>
                                        <option value="fr">French</option>
                                        <option value="de">German</option>
                                        <option value="zh">Chinese</option>
                                        <option value="ja">Japanese</option>
                                    </select>
                                </div>
                            </div>

                            <div class="filter-section">
                                <label>Genres</label>
                                <div class="genre-filter">
                                    <div class="genre-item">Fiction</div>
                                    <div class="genre-item">Fantasy</div>
                                    <div class="genre-item">Science Fiction</div>
                                    <div class="genre-item">Mystery</div>
                                    <div class="genre-item">Thriller</div>
                                    <div class="genre-item">Romance</div>
                                    <div class="genre-item">Biography</div>
                                    <div class="genre-item">History</div>
                                    <div class="genre-item">Computer Science</div>
                                    <div class="genre-item">Engineering</div>
                                    <div class="genre-item">Medicine</div>
                                    <div class="genre-item">Art</div>
                                </div>
                            </div>
                        </div>

                        <!-- Active Filters -->
                        <div class="active-filters mb-3">
                            <div class="filter-badge">
                                Available Now <i class="fas fa-times-circle"></i>
                            </div>
                            <div class="filter-badge">
                                Computer Science <i class="fas fa-times-circle"></i>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Search Results -->
                <h4 class="mb-4">Search Results <span class="text-muted">(12 books found)</span></h4>
                <div class="row g-4">
                    <!-- Book Item 1 -->
                    <div class="col-xl-3 col-lg-4 col-md-6">
                        <div class="book-card">
                            <div class="book-img-container">
                                <img src="https://via.placeholder.com/300x400/4361ee/ffffff?text=Clean+Code" class="book-img" alt="Clean Code">
                                <div class="book-status available">Available</div>
                            </div>
                            <div class="book-info">
                                <div class="col-md-4 text-center mb-3 mb-md-0">
                                    <img src="https://via.placeholder.com/300x400" class="img-fluid rounded" alt="Book Cover">
                                </div>
                                <h5 class="book-title">Clean Code: A Handbook of Agile Software</h5>
                                <div class="book-author">Robert C. Martin</div>
                                <div class="book-meta">
                                    <span><i class="fas fa-calendar-alt me-1"></i> 2008</span>
                                    <span><i class="fas fa-bookmark me-1"></i> Programming</span>
                                </div>
                                <div class="book-actions">
                                    <button class="btn btn-details" data-bs-toggle="modal" data-bs-target="#bookDetailsModal">
                                        <i class="fas fa-info-circle"></i> Details
                                    </button>
                                    <button class="btn btn-borrow">
                                        <i class="fas fa-book-open"></i> Borrow
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Book Item 2 -->
                    <div class="col-xl-3 col-lg-4 col-md-6">
                        <div class="book-card">
                            <div class="book-img-container">
                                <img src="https://via.placeholder.com/300x400/3f37c9/ffffff?text=Data+Structures" class="book-img" alt="Data Structures and Algorithms">
                                <div class="book-status borrowed">Borrowed</div>
                            </div>
                            <div class="book-info">
                                <h5 class="book-title">Data Structures and Algorithms in Java</h5>
                                <div class="book-author">Michael T. Goodrich</div>
                                <div class="book-meta">
                                    <span><i class="fas fa-calendar-alt me-1"></i> 2014</span>
                                    <span><i class="fas fa-bookmark me-1"></i> Computer Science</span>
                                </div>
                                <div class="book-actions">
                                    <button class="btn btn-details" data-bs-toggle="modal" data-bs-target="#bookDetailsModal">
                                        <i class="fas fa-info-circle"></i> Details
                                    </button>
                                    <button class="btn btn-reserve">
                                        <i class="fas fa-bookmark"></i> Reserve
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Book Item 3 -->
                    <div class="col-xl-3 col-lg-4 col-md-6">
                        <div class="book-card">
                            <div class="book-img-container">
                                <img src="https://via.placeholder.com/300x400/4895ef/ffffff?text=Machine+Learning" class="book-img" alt="Machine Learning">
                                <div class="book-status available">Available</div>
                            </div>
                            <div class="book-info">
                                <h5 class="book-title">Introduction to Machine Learning with Python</h5>
                                <div class="book-author">Andreas C. Müller & Sarah Guido</div>
                                <div class="book-meta">
                                    <span><i class="fas fa-calendar-alt me-1"></i> 2016</span>
                                    <span><i class="fas fa-bookmark me-1"></i> Data Science</span>
                                </div>
                                <div class="book-actions">
                                    <button class="btn btn-details" data-bs-toggle="modal" data-bs-target="#bookDetailsModal">
                                        <i class="fas fa-info-circle"></i> Details
                                    </button>
                                    <button class="btn btn-borrow">
                                        <i class="fas fa-book-open"></i> Borrow
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Book Item 4 -->
                    <div class="col-xl-3 col-lg-4 col-md-6">
                        <div class="book-card">
                            <div class="book-img-container">
                                <img src="https://via.placeholder.com/300x400/4cc9f0/ffffff?text=Design+Patterns" class="book-img" alt="Design Patterns">
                                <div class="book-status available">Available</div>
                            </div>
                            <div class="book-info">
                                <h5 class="book-title">Design Patterns: Elements of Reusable Object-Oriented Software</h5>
                                <div class="book-author">Erich Gamma et al.</div>
                                <div class="book-meta">
                                    <span><i class="fas fa-calendar-alt me-1"></i> 1994</span>
                                    <span><i class="fas fa-bookmark me-1"></i> Software Design</span>
                                </div>
                                <div class="book-actions">
                                    <button class="btn btn-details" data-bs-toggle="modal" data-bs-target="#bookDetailsModal">
                                        <i class="fas fa-info-circle"></i> Details
                                    </button>
                                    <button class="btn btn-borrow">
                                        <i class="fas fa-book-open"></i> Borrow
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- More books would go here -->
                </div>

                <!-- Pagination -->
                <div class="pagination-container">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                        </ul>  
                    </nav>
                </div>
            </div>
    </body>
</html>
