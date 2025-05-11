<%-- 
    Document   : navbar.jsp
    Created on : May 11, 2025, 8:45:41 AM
    Author     : hakus
--%>

<%-- 
    Component   : librarian-navbar
    Created on : May 11, 2025
    Description : Reusable navbar component for librarian dashboard pages
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%
    String currentPage = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/") + 1);
    String studentName = (String) session.getAttribute("full_name");
    if (studentName == null) {
        response.sendRedirect("login.jsp");
    }
%>

<!-- CSS Styles for Navbar Component -->
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

    /* Sidebar Styles */
    .sidebar {
        width: 280px;
        background: linear-gradient(180deg, var(--primary-color), var(--secondary-color));
        color: white;
        transition: all 0.3s;
        position: fixed;
        height: 100vh;
        z-index: 1000;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
    }

    .sidebar-header {
        padding: 20px;
        background: rgba(0, 0, 0, 0.1);
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .sidebar-brand {
        font-size: 1.5rem;
        font-weight: 700;
        color: white;
        text-decoration: none;
        display: flex;
        align-items: center;
    }

    .sidebar-nav {
        flex-grow: 1;
        padding-top: 20px;
        overflow-y: auto;
    }

    .sidebar .nav-link {
        padding: 15px 20px;
        color: rgba(255, 255, 255, 0.85);
        border-radius: 5px;
        margin: 5px 15px;
        transition: all 0.3s;
        display: flex;
        align-items: center;
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
        padding: 15px;
        background: rgba(0, 0, 0, 0.1);
    }

    /* Main Content Styles */
    .content-wrapper {
        width: calc(100% - 280px);
        margin-left: 280px;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    .topbar {
        background-color: white;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 900;
    }

    .search-form {
        flex-grow: 1;
        max-width: 400px;
    }

    .search-form .input-group {
        border-radius: 50px;
        overflow: hidden;
    }

    .search-form .form-control {
        border-right: none;
        background: #f8f9fa;
        border-radius: 50px 0 0 50px;
        padding-left: 20px;
    }

    .search-form .btn-search {
        background: #f8f9fa;
        border-left: none;
        color: var(--primary-color);
        border-radius: 0 50px 50px 0;
    }

    .user-menu {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .notification-btn {
        position: relative;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f0f2f5;
        border: none;
        color: var(--primary-color);
        transition: all 0.3s;
    }

    .notification-btn:hover {
        background-color: #e4e6e9;
    }

    .notification-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        width: 20px;
        height: 20px;
        background-color: var(--warning-color);
        color: white;
        font-size: 0.7rem;
        font-weight: bold;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
    }

    .user-dropdown .dropdown-toggle {
        padding: 0;
        display: flex;
        align-items: center;
        gap: 10px;
        background: transparent;
        border: none;
        color: var(--dark-color);
    }

    .user-dropdown .dropdown-toggle::after {
        display: none;
    }

    .avatar {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        background-color: var(--primary-color);
        color: white;
        font-weight: bold;
        font-size: 1.2rem;
    }

    /* Mobile Responsiveness */
    @media (max-width: 992px) {
        .sidebar {
            width: 80px;
        }

        .sidebar .nav-link span {
            display: none;
        }

        .sidebar .nav-link i {
            margin-right: 0;
            font-size: 1.2rem;
        }

        .sidebar-brand .logo-text {
            display: none;
        }

        .content-wrapper {
            width: calc(100% - 80px);
            margin-left: 80px;
        }
    }

    @media (max-width: 768px) {
        .sidebar {
            margin-left: -80px;
        }

        .sidebar.active {
            margin-left: 0;
        }

        .content-wrapper {
            width: 100%;
            margin-left: 0;
        }

        .topbar {
            padding: 15px;
        }

        .search-form {
            display: none;
        }

        .mobile-toggle {
            display: block !important;
        }
    }

    .mobile-toggle {
        display: none;
        background: transparent;
        border: none;
        color: var(--primary-color);
        font-size: 1.5rem;
    }
</style>

<!-- Sidebar Component -->
<nav class="sidebar">
    <div class="sidebar-header">
        <a href="librarian-dashboard.jsp" class="sidebar-brand">
            <i class="fas fa-book-reader me-2"></i>
            <span class="logo-text">LibraryMS</span>
        </a>
        <button class="btn-close text-white d-lg-none" id="closeSidebar"></button>
    </div>

    <div class="sidebar-nav">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a href="librarian-dashboard.jsp" class="nav-link <%= currentPage.equals("librarian-dashboard.jsp") ? "active" : ""%>">
                    <i class="fas fa-gauge-high"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="manage-books.jsp" class="nav-link <%= currentPage.equals("manage-books.jsp") ? "active" : ""%>">
                    <i class="fas fa-book"></i>
                    <span>Manage Books</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="borrow-book.jsp" class="nav-link <%= currentPage.equals("borrow-book.jsp") ? "active" : ""%>">
                    <i class="fas fa-book-open"></i>
                    <span>Borrow Books</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="requests.jsp" class="nav-link <%= currentPage.equals("requests.jsp") ? "active" : ""%>">
                    <i class="fas fa-envelope"></i>
                    <span>Requests</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="notifications.jsp" class="nav-link <%= currentPage.equals("notifications.jsp") ? "active" : ""%>">
                    <i class="fas fa-bell"></i>
                    <span>Notifications</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="helpdesk.jsp" class="nav-link <%= currentPage.equals("helpdesk.jsp") ? "active" : ""%>">
                    <i class="fas fa-headset"></i>
                    <span>Helpdesk</span>
                </a>
            </li>
        </ul>
    </div>

    <div class="sidebar-footer">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a href="settings.jsp" class="nav-link <%= currentPage.equals("settings.jsp") ? "active" : ""%>">
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

<!-- Main Content Wrapper Start -->
<div class="content-wrapper">
    <!-- Top Navigation Bar -->
    <div class="topbar">
        <div class="d-flex align-items-center">
            <button class="mobile-toggle me-3" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>
            <form class="search-form">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search books, students...">
                    <button class="btn btn-search" type="button">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
        </div>

        <div class="user-menu">
            <button class="notification-btn">
                <i class="fas fa-bell"></i>
                <span class="notification-badge">3</span>
            </button>

            <div class="dropdown user-dropdown">
                <button class="dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    <div class="avatar">
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

    <!-- Main Content Area Starts Here -->
    <!-- This is where each page's specific content will go -->

    <!-- Note: Don't close the content-wrapper div here as it should be closed in the main JSP file -->

    <!-- JavaScript for Navbar Functionality -->
    <script>
        // Mobile sidebar toggle
        document.getElementById('sidebarToggle').addEventListener('click', function () {
            document.querySelector('.sidebar').classList.toggle('active');
        });

        document.getElementById('closeSidebar').addEventListener('click', function () {
            document.querySelector('.sidebar').classList.remove('active');
        });

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function (event) {
            const sidebar = document.querySelector('.sidebar');
            const sidebarToggle = document.getElementById('sidebarToggle');

            if (window.innerWidth <= 768) {
                if (!sidebar.contains(event.target) && !sidebarToggle.contains(event.target)) {
                    sidebar.classList.remove('active');
                }
            }
        });
    </script>