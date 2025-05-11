<%-- 
    Document   : nav-bar.jsp
    Created on : May 11, 2025, 12:35:40 AM
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
</body>
</html>
