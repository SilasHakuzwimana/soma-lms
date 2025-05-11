<%-- 
    Document   : student-dashboard
    Created on : May 10, 2025, 10:19:21 AM
    Author     : hakus
--%>

<!--/*
### ✅ **1. Student Dashboard Pages**

* `dashboard.jsp` – Overview for student
* `search-book.jsp` – Search available books
* `borrow-book.jsp` – Borrow a book
* `return-book.jsp` – Return a borrowed book
* `reserve-book.jsp` – Reserve a book
* `notifications.jsp` – View notifications
* `helpdesk.jsp` – Raise or view support tickets
* `logout.jsp` – End session
* `settings.jsp` – Update profile or password

*/-->

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
        <title>Student Dashboard | Library Management System</title>
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

            .greeting {
                font-size: 1.8rem;
                font-weight: 600;
                color: var(--dark-color);
            }

            .stats-row {
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                padding: 20px;
                height: 100%;
                transition: all 0.3s;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                color: white;
                font-size: 1.5rem;
                margin-bottom: 15px;
            }

            .stat-card h3 {
                font-size: 1.3rem;
                margin-bottom: 5px;
                font-weight: 600;
            }

            .stat-card p {
                color: #6c757d;
                margin-bottom: 0;
            }

            .feature-card {
                background: white;
                border-radius: 12px;
                border: none;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                overflow: hidden;
                transition: all 0.3s ease;
                height: 100%;
            }

            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }

            .feature-card .card-body {
                padding: 25px;
            }

            .feature-card .card-title {
                font-weight: 600;
                margin-bottom: 15px;
            }

            .feature-card .card-text {
                color: #6c757d;
                margin-bottom: 20px;
            }

            .feature-icon {
                font-size: 2.5rem;
                margin-bottom: 15px;
                background: rgba(67, 97, 238, 0.1);
                color: var(--primary-color);
                width: 70px;
                height: 70px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 12px;
            }

            .feature-cta {
                display: inline-flex;
                align-items: center;
                color: var(--primary-color);
                font-weight: 600;
                text-decoration: none;
            }

            .feature-cta:hover {
                color: var(--secondary-color);
            }

            .feature-cta i {
                margin-left: 8px;
                transition: all 0.3s;
            }

            .feature-cta:hover i {
                transform: translateX(5px);
            }

            .recent-activity {
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                padding: 25px;
                margin-top: 30px;
            }

            .activity-item {
                padding: 15px 0;
                border-bottom: 1px solid #f0f0f0;
            }

            .activity-item:last-child {
                border-bottom: none;
            }

            .activity-icon {
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                color: white;
                margin-right: 15px;
            }

            .activity-content h6 {
                margin-bottom: 5px;
                font-weight: 600;
            }

            .activity-time {
                font-size: 0.8rem;
                color: #6c757d;
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
                        <a href="student-dashboard.jsp" class="nav-link active">
                            <i class="fas fa-gauge-high"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="search-book.jsp" class="nav-link">
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
                                <input type="text" class="form-control" placeholder="Search for books...">
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
                                    <li><hr class="dropdown-divider"></li>
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
                    <h2 class="greeting">Welcome, <%= studentName%>!</h2>
                    <p class="stats-date" id="datetime"></p>

                    <script>
                        function updateDateTime() {
                            const options = {
                                weekday: 'long',
                                year: 'numeric',
                                month: 'long',
                                day: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit',
                                second: '2-digit',
                                hour12: true,
                                timeZone: 'Africa/Kigali'
                            };
                            const now = new Date();
                            const formatter = new Intl.DateTimeFormat('en-US', options);
                            document.getElementById('datetime').textContent = "Today is " + formatter.format(now);
                        }

                        updateDateTime(); // Run on page load
                        setInterval(updateDateTime, 1000); // Update every second
                    </script>

                    <p class="text-muted">Here's what's happening with your library activities</p>
                </div>

                <!-- Stats Section -->
                <div class="row stats-row g-4">
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-card">
                            <div class="stat-icon" style="background-color: var(--primary-color);">
                                <i class="fas fa-book"></i>
                            </div>
                            <h3>5</h3>
                            <p>Books Borrowed</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-card">
                            <div class="stat-icon" style="background-color: var(--warning-color);">
                                <i class="fas fa-clock"></i>
                            </div>
                            <h3>2</h3>
                            <p>Due Soon</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-card">
                            <div class="stat-icon" style="background-color: var(--success-color);">
                                <i class="fas fa-bookmark"></i>
                            </div>
                            <h3>3</h3>
                            <p>Reserved Books</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-card">
                            <div class="stat-icon" style="background-color: var(--info-color);">
                                <i class="fas fa-heart"></i>
                            </div>
                            <h3>12</h3>
                            <p>Favorite Books</p>
                        </div>
                    </div>
                </div>

                <!-- Features Section -->
                <div class="row g-4 mb-4">
                    <div class="col-lg-6">
                        <div class="feature-card">
                            <div class="card-body">
                                <div class="feature-icon">
                                    <i class="fas fa-search"></i>
                                </div>
                                <h3 class="card-title">Search Books</h3>
                                <p class="card-text">Explore our vast collection of books by title, author, genre, or ISBN.</p>
                                <a href="search-book.jsp" class="feature-cta">Find your next read <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="feature-card">
                            <div class="card-body">
                                <div class="feature-icon">
                                    <i class="fas fa-book-open"></i>
                                </div>
                                <h3 class="card-title">Borrow Books</h3>
                                <p class="card-text">Check out books for your research, studies, or leisure reading.</p>
                                <a href="borrow-book.jsp" class="feature-cta">Borrow now <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="feature-card">
                            <div class="card-body">
                                <div class="feature-icon">
                                    <i class="fas fa-undo-alt"></i>
                                </div>
                                <h3 class="card-title">Return Books</h3>
                                <p class="card-text">Return your borrowed books and avoid late fees with easy processing.</p>
                                <a href="return-book.jsp" class="feature-cta">Return books <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="feature-card">
                            <div class="card-body">
                                <div class="feature-icon">
                                    <i class="fas fa-bookmark"></i>
                                </div>
                                <h3 class="card-title">Reserve Books</h3>
                                <p class="card-text">Reserve books that are currently checked out by other students.</p>
                                <a href="reserve-book.jsp" class="feature-cta">Reserve now <i class="fas fa-arrow-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity Section -->
                <div class="recent-activity">
                    <h4 class="mb-4">Recent Activity</h4>
                    <div class="activity-item d-flex">
                        <div class="activity-icon bg-primary">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="activity-content">
                            <h6>Borrowed "The Alchemist"</h6>
                            <div class="activity-time">2 days ago</div>
                        </div>
                    </div>
                    <div class="activity-item d-flex">
                        <div class="activity-icon bg-warning">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                        <div class="activity-content">
                            <h6>Due reminder for "Data Structures and Algorithms"</h6>
                            <div class="activity-time">3 days ago</div>
                        </div>
                    </div>
                    <div class="activity-item d-flex">
                        <div class="activity-icon bg-success">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="activity-content">
                            <h6>Returned "Introduction to Machine Learning"</h6>
                            <div class="activity-time">1 week ago</div>
                        </div>
                    </div>
                    <div class="activity-item d-flex">
                        <div class="activity-icon bg-info">
                            <i class="fas fa-bookmark"></i>
                        </div>
                        <div class="activity-content">
                            <h6>Reserved "Clean Code: A Handbook of Agile Software"</h6>
                            <div class="activity-time">1 week ago</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            // Sidebar toggle for mobile
                            document.getElementById('sidebarCollapse').addEventListener('click', function () {
                                document.getElementById('sidebar').classList.toggle('active');
                            });

                            // Close sidebar when clicking outside on mobile
                            document.addEventListener('click', function (event) {
                                const sidebar = document.getElementById('sidebar');
                                const sidebarCollapse = document.getElementById('sidebarCollapse');

                                if (window.innerWidth <= 768) {
                                    if (!sidebar.contains(event.target) && !sidebarCollapse.contains(event.target)) {
                                        sidebar.classList.remove('active');
                                    }
                                }
                            });
                        });
        </script>
    </body>
</html>