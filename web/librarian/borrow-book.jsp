<%-- 
    Document   : borrow-book.jsp
    Created on : May 10, 2025, 11:45:10 PM
    Author     : hakus
    Updated on : May 11, 2025
--%>
<%@page import="utils.DBConnection"%>
<%@ page import="java.sql.*, javax.sql.*, java.time.*, java.time.format.DateTimeFormatter, java.util.TimeZone" %>
<%@ page session="true" %>
<%
    // Set timezone to Africa/Kigali
    TimeZone.setDefault(TimeZone.getTimeZone("Africa/Kigali"));

    String bookId = request.getParameter("bookId");
    String userId = (String) session.getAttribute("studentId"); // Using userId instead of studentId to match schema
    String userName = (String) session.getAttribute("userName"); // For the created_by field
    String message = "";
    boolean success = false;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String borrowDate = request.getParameter("borrowDate");
        String dueDate = request.getParameter("returnDate");

        // Get current timestamp in Africa/Kigali timezone
        ZonedDateTime now = ZonedDateTime.now(ZoneId.of("Africa/Kigali"));
        String currentTimestamp = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO borrowings (user_id, book_id, borrow_date, due_date, created_by, updated_by, created_at, updated_at) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, userId);
            ps.setString(2, bookId);
            ps.setString(3, borrowDate + " " + now.format(DateTimeFormatter.ofPattern("HH:mm:ss"))); // Add time to date
            ps.setString(4, dueDate + " 23:59:59"); // Set due date to end of day
            ps.setString(5, userName != null ? userName : userId); // Created by
            ps.setString(6, userName != null ? userName : userId); // Updated by
            ps.setString(7, currentTimestamp); // Created at
            ps.setString(8, currentTimestamp); // Updated at

            int rows = ps.executeUpdate();
            if (rows > 0) {
                message = "Book borrowed successfully!";
                success = true;

                // Update book status to unavailable
                PreparedStatement updateBook = conn.prepareStatement(
                        "UPDATE books SET status = 'borrowed' WHERE id = ?"
                );
                updateBook.setString(1, bookId);
                updateBook.executeUpdate();
                updateBook.close();
            } else {
                message = "Failed to borrow book. Please try again.";
            }
            ps.close();
            conn.close();
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }

    String bookTitle = "";
    String bookAuthor = "";
    String bookCover = "";
    try {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT title, author, cover_image FROM books WHERE id = ?");
        ps.setString(1, bookId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            bookTitle = rs.getString("title");
            bookAuthor = rs.getString("author") != null ? rs.getString("author") : "Unknown Author";
            bookCover = rs.getString("cover_image") != null ? rs.getString("cover_image") : "img/default-book.png";
        }
    } catch (Exception e) {
        bookTitle = "Unknown";
        bookAuthor = "Unknown Author";
        bookCover = "img/default-book.png";
    }

    // Get today's date in Africa/Kigali timezone
    java.time.ZonedDateTime kigaliNow = java.time.ZonedDateTime.now(java.time.ZoneId.of("Africa/Kigali"));
    java.time.LocalDate today = kigaliNow.toLocalDate();
    String todayStr = today.toString(); // YYYY-MM-DD format

    // Calculate default return date (14 days from today)
    java.time.LocalDate defaultReturn = today.plusDays(14);
    String defaultReturnStr = defaultReturn.toString();

    // Format for displaying the current date and time in the UI
    String currentDateTimeFormatted = kigaliNow.format(java.time.format.DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy 'at' h:mm a"));
%>

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
        <title>Borrow a Book - Library Management System</title>
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

        <!-- Main Content -->
        <div class="content animate__animated animate__fadeIn">
            <!-- Mobile menu toggle button -->
            <button class="toggle-sidebar btn btn-sm d-md-none" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>

            <div class="page-container">
                <h2 class="page-title">Borrow a Book</h2>

                <% if (!message.isEmpty()) {%>
                <div class="alert alert-<%= success ? "success" : "danger"%> alert-dismissible fade show" role="alert">
                    <i class="fas fa-<%= success ? "check-circle" : "exclamation-triangle"%> me-2"></i>
                    <%= message%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% }%>


                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-book me-2"></i> Book Details
                    </div>
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-4 text-center mb-3 mb-md-0">
                                <img src="<%= bookCover%>" alt="<%= bookTitle%>" class="book-cover img-fluid" onerror="this.src='img/default-book.jpg'">
                            </div>
                            <div class="col-md-8">
                                <div class="book-info">
                                    <h4 class="mb-2"><%= bookTitle%></h4>
                                    <p class="text-muted mb-0">
                                        <i class="fas fa-user-edit me-2"></i> <%= bookAuthor%>
                                    </p>
                                    <div class="mt-3">
                                        <span class="badge bg-primary me-2">Available</span>
                                        <span class="badge bg-info">ID: <%= bookId%></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-calendar-alt me-2"></i> Borrowing Details (Africa/Kigali Timezone)
                    </div>
                    <div class="card-body">
                        <form method="POST" action="borrow-book.jsp?bookId=<%= bookId%>" id="borrowForm">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="borrowDate" class="form-label">Borrow Date</label>
                                    <div class="date-picker-container">
                                        <input type="date" class="form-control" name="borrowDate" id="borrowDate" 
                                               required min="<%= todayStr%>" value="<%= todayStr%>">
                                        <i class="fas fa-calendar"></i>
                                    </div>
                                    <div class="date-info">Today's date is set by default (Africa/Kigali timezone)</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="returnDate" class="form-label">Due Date</label>
                                    <div class="date-picker-container">
                                        <input type="date" class="form-control" name="returnDate" id="returnDate" 
                                               required min="<%= todayStr%>" value="<%= defaultReturnStr%>">
                                        <i class="fas fa-calendar-check"></i>
                                    </div>
                                    <div class="date-info">Standard loan period is 14 days</div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between mt-4">
                                <a href="manage-books.jsp" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-book-reader"></i> Confirm Borrow
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <p class="text-muted small">
                        <i class="fas fa-info-circle me-1"></i> By borrowing this book, you agree to return it by the specified due date.
                        Late returns may incur fines according to library policy.
                    </p>
                    <p class="text-muted small">
                        <i class="fas fa-clock me-1"></i> Current date and time (Africa/Kigali): <%= currentDateTimeFormatted%>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
