<%-- 
    Document   : librarian-dashboard
    Created on : May 10, 2025, 10:19:45 AM
    Author     : hakus
    Updated on : May 11, 2025
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
        <title>Librarian Dashboard</title>
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
                min-height: 100vh;
                display: flex;
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

            .main-content {
                padding: 30px;
                flex-grow: 1;
            }

            .dashboard-header {
                margin-bottom: 30px;
            }

            .greeting {
                font-size: 1.8rem;
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 10px;
            }

            .stats-date {
                color: #6c757d;
                font-size: 0.9rem;
            }

            .stat-card {
                height: 100%;
                border-radius: 15px;
                border: none;
                overflow: hidden;
                transition: all 0.3s;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }

            .stat-card .card-body {
                padding: 25px;
            }

            .stat-icon {
                font-size: 2.5rem;
                margin-bottom: 15px;
                opacity: 0.8;
            }

            .stat-number {
                font-size: 2.5rem;
                font-weight: 600;
                margin-bottom: 5px;
            }

            .stat-label {
                color: rgba(255, 255, 255, 0.8);
                font-size: 1rem;
                font-weight: 500;
            }

            .recent-section {
                margin-top: 40px;
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .section-title {
                font-size: 1.4rem;
                font-weight: 600;
                color: var(--dark-color);
            }

            .view-all {
                color: var(--primary-color);
                font-weight: 500;
                text-decoration: none;
            }

            .view-all:hover {
                text-decoration: underline;
            }

            .activity-card {
                background-color: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                margin-bottom: 20px;
            }

            .activity-item {
                padding: 15px 0;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                align-items: center;
            }

            .activity-item:last-child {
                border-bottom: none;
                padding-bottom: 0;
            }

            .activity-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 15px;
                color: white;
            }

            .activity-content {
                flex-grow: 1;
            }

            .activity-title {
                font-weight: 500;
                margin-bottom: 5px;
            }

            .activity-time {
                font-size: 0.8rem;
                color: #6c757d;
            }

            /* Quick Actions */
            .quick-actions {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 15px;
                margin-top: 20px;
            }

            .quick-action-btn {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                background-color: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                text-decoration: none;
                color: var(--dark-color);
                transition: all 0.3s;
                height: 100%;
                text-align: center;
            }

            .quick-action-btn:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                color: var(--primary-color);
            }

            .quick-action-icon {
                font-size: 2rem;
                color: var(--primary-color);
                margin-bottom: 10px;
            }

            .quick-action-text {
                font-weight: 500;
                font-size: 0.9rem;
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

                .quick-actions {
                    grid-template-columns: repeat(2, 1fr);
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
    </head>
    <body>
        <!-- Sidebar -->
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
                        <a href="librarian-dashboard.jsp" class="nav-link active">
                            <i class="fas fa-gauge-high"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="manage-books.jsp" class="nav-link">
                            <i class="fas fa-book"></i>
                            <span>Manage Books</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="borrow-book.jsp" class="nav-link">
                            <i class="fas fa-book-open"></i>
                            <span>Borrow Books</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="requests.jsp" class="nav-link">
                            <i class="fas fa-envelope"></i>
                            <span>Requests</span>
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
            </div>

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

        <!-- Main Content Wrapper -->
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
                            <li><a class="dropdown-item" href="settings.jsp"><i class="fas fa-cog me-2"></i>Settings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Main Content Area -->
            <div class="main-content">
                <div class="dashboard-header">
                    <p class="header">Librarian Dashboard</p>
                    <h1 class="greeting">Welcome back, <%= studentName.split(" ")[0]%>!</h1>
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
                </div>

                <!-- Stats Cards -->
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card stat-card" style="background-color: var(--primary-color); color: white;">
                            <div class="card-body">
                                <div class="stat-icon">
                                    <i class="fas fa-book"></i>
                                </div>
                                <div class="stat-number">1,020</div>
                                <div class="stat-label">Total Books</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card" style="background-color: var(--accent-color); color: white;">
                            <div class="card-body">
                                <div class="stat-icon">
                                    <i class="fas fa-envelope-open-text"></i>
                                </div>
                                <div class="stat-number">45</div>
                                <div class="stat-label">Pending Requests</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card" style="background-color: var(--success-color); color: white;">
                            <div class="card-body">
                                <div class="stat-icon">
                                    <i class="fas fa-bell"></i>
                                </div>
                                <div class="stat-number">12</div>
                                <div class="stat-label">New Notifications</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="recent-section">
                    <div class="section-header">
                        <h2 class="section-title">Quick Actions</h2>
                    </div>
                    <div class="quick-actions">
                        <a href="add-book.jsp" class="quick-action-btn">
                            <div class="quick-action-icon">
                                <i class="fas fa-plus-circle"></i>
                            </div>
                            <div class="quick-action-text">Add New Book</div>
                        </a>
                        <a href="issue-book.jsp" class="quick-action-btn">
                            <div class="quick-action-icon">
                                <i class="fas fa-hand-holding-heart"></i>
                            </div>
                            <div class="quick-action-text">Issue Book</div>
                        </a>
                        <a href="return-book.jsp" class="quick-action-btn">
                            <div class="quick-action-icon">
                                <i class="fas fa-undo"></i>
                            </div>
                            <div class="quick-action-text">Return Book</div>
                        </a>
                        <a href="manage-students.jsp" class="quick-action-btn">
                            <div class="quick-action-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="quick-action-text">Manage Students</div>
                        </a>
                    </div>
                </div>

                <!-- Recent Activities -->
                <div class="recent-section">
                    <div class="section-header">
                        <h2 class="section-title">Recent Activities</h2>
                        <a href="activities.jsp" class="view-all">View All</a>
                    </div>
                    <div class="activity-card">
                        <div class="activity-item">
                            <div class="activity-icon" style="background-color: var(--primary-color);">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">New book added: "Data Structures and Algorithms"</div>
                                <div class="activity-time">Today, 10:45 AM</div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-icon" style="background-color: var(--accent-color);">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">Sarah Johnson borrowed "Machine Learning Basics"</div>
                                <div class="activity-time">Yesterday, 3:30 PM</div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-icon" style="background-color: var(--success-color);">
                                <i class="fas fa-undo"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">Michael Brown returned "Introduction to Python"</div>
                                <div class="activity-time">Yesterday, 1:15 PM</div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-icon" style="background-color: var(--warning-color);">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">Overdue notice sent to James Wilson</div>
                                <div class="activity-time">May 10, 2025, 9:00 AM</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Requests -->
                <div class="recent-section">
                    <div class="section-header">
                        <h2 class="section-title">Recent Requests</h2>
                        <a href="requests.jsp" class="view-all">View All</a>
                    </div>
                    <div class="activity-card">
                        <div class="activity-item">
                            <div class="activity-icon" style="background-color: var(--info-color);">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">Emma Davis requested "Advanced Web Development"</div>
                                <div class="activity-time">Today, 11:20 AM</div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-icon" style="background-color: var(--info-color);">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">Robert Martinez requested extension for "Database Systems"</div>
                                <div class="activity-time">Today, 9:45 AM</div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-icon" style="background-color: var(--info-color);">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">Lisa Anderson requested "Cloud Computing Fundamentals"</div>
                                <div class="activity-time">Yesterday, 4:30 PM</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
    </body>
</html>