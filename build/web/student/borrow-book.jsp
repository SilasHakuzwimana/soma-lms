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
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Borrow Book - SOMA LMS</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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
                padding-top: 0;
                margin: 0;
            }

            .wrapper {
                display: flex;
                width: 100%;
                min-height: 100vh;
            }

            .content {
                width: calc(100% - 280px);
                margin-left: 280px;
                padding: 30px;
                transition: all 0.3s;
            }

            .card {
                border-radius: 15px;
                border: none;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .card-header {
                background-color: var(--primary-color);
                color: white;
                border-bottom: none;
                padding: 1.5rem;
                font-weight: 600;
                border-radius: 15px 15px 0 0 !important;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-primary:hover, .btn-primary:focus {
                background-color: var(--secondary-color);
                border-color: var(--secondary-color);
            }

            .btn-secondary {
                background-color: var(--accent-color);
                border-color: var(--accent-color);
            }

            .btn-secondary:hover, .btn-secondary:focus {
                background-color: var(--info-color);
                border-color: var(--info-color);
            }

            .form-control:focus {
                border-color: var(--accent-color);
                box-shadow: 0 0 0 0.25rem rgba(72, 149, 239, 0.25);
            }

            .book-cover {
                height: 200px;
                object-fit: cover;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .book-info {
                background-color: rgba(67, 97, 238, 0.05);
                border-left: 4px solid var(--primary-color);
                border-radius: 0 10px 10px 0;
                padding: 20px;
                margin-bottom: 25px;
            }

            .alert {
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
                animation: fadeIn 0.5s;
            }

            .alert-success {
                background-color: rgba(76, 201, 240, 0.2);
                border-left: 4px solid var(--success-color);
                color: #055160;
            }

            .alert-danger {
                background-color: rgba(247, 37, 133, 0.2);
                border-left: 4px solid var(--warning-color);
                color: #58151c;
            }

            .form-label {
                font-weight: 500;
                margin-bottom: 0.5rem;
                color: var(--dark-color);
            }

            .date-picker-container {
                position: relative;
            }

            .date-picker-container i {
                position: absolute;
                right: 10px;
                top: 12px;
                color: var(--primary-color);
                pointer-events: none;
            }

            .btn {
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                transition: all 0.3s;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .btn i {
                margin-right: 8px;
            }

            .page-title {
                color: var(--primary-color);
                font-weight: 700;
                margin-bottom: 1.5rem;
                border-bottom: 3px solid var(--accent-color);
                display: inline-block;
                padding-bottom: 8px;
            }

            .date-info {
                color: var(--info-color);
                font-size: 0.9rem;
                margin-top: 5px;
            }

            /* Mobile Responsiveness */
            @media (max-width: 992px) {
                .content {
                    width: calc(100% - 80px);
                    margin-left: 80px;
                }
            }

            @media (max-width: 768px) {
                .content {
                    width: 100%;
                    margin-left: 0;
                    padding: 20px;
                }

                .card-header {
                    padding: 1rem;
                }

                .book-info {
                    padding: 15px;
                }

                .card {
                    margin-bottom: 20px;
                }
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(-10px); }
                to { opacity: 1; transform: translateY(0); }
            }

            /* Additional fixes for navbar integration */
            .page-container {
                padding-top: 20px;
            }

            .toggle-sidebar {
                display: none;
            }

            @media (max-width: 768px) {
                .toggle-sidebar {
                    display: block;
                    position: fixed;
                    top: 10px;
                    left: 10px;
                    z-index: 1050;
                    background-color: var(--primary-color);
                    color: white;
                    border: none;
                    border-radius: 5px;
                    padding: 8px 12px;
                    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                }
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <!-- Include the sidebar navigation -->
            <%@ include file="nav-bar.jsp" %>

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
                                    <a href="search-books.jsp" class="btn btn-secondary">
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a2d0d6fe67.js" crossorigin="anonymous"></script>
        <script>
            // Toggle sidebar on mobile
            document.getElementById('sidebarToggle').addEventListener('click', function () {
                document.getElementById('sidebar').classList.toggle('active');
            });

            // Ensure the due date is after the borrow date
            document.getElementById('borrowDate').addEventListener('change', function () {
                const borrowDate = new Date(this.value);
                const returnDateInput = document.getElementById('returnDate');
                const returnDate = new Date(returnDateInput.value);

                if (returnDate <= borrowDate) {
                    // Set due date to 14 days after borrow date
                    borrowDate.setDate(borrowDate.getDate() + 14);
                    returnDateInput.value = borrowDate.toISOString().split('T')[0];
                }
            });

            // Add form validation
            document.getElementById('borrowForm').addEventListener('submit', function (event) {
                const borrowDate = new Date(document.getElementById('borrowDate').value);
                const returnDate = new Date(document.getElementById('returnDate').value);

                if (returnDate <= borrowDate) {
                    event.preventDefault();
                    alert('Due date must be after borrow date');
                    return;
                }

                // Calculate days between dates to check if it's within policy
                const diffTime = Math.abs(returnDate - borrowDate);
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

                if (diffDays > 30) {
                    if (!confirm('The borrowing period exceeds 30 days. Extended borrowing requires approval. Do you want to proceed?')) {
                        event.preventDefault();
                    }
                }
            });

            // Initialize dates with timezone-aware defaults
            window.addEventListener('DOMContentLoaded', function () {
                // This ensures the date inputs show correct dates according to the Africa/Kigali timezone
                // The server-side values are already set correctly, this is just an additional check
                const now = new Date();
                // Calculate timezone offset for Kigali (GMT+2)
                const kigaliOffset = 2 * 60; // 2 hours in minutes
                const localOffset = now.getTimezoneOffset(); // Local offset in minutes
                const offsetDiff = localOffset + kigaliOffset; // Difference to add in minutes

                // Apply offset if user is not in Kigali timezone
                if (offsetDiff !== 0) {
                    now.setMinutes(now.getMinutes() + offsetDiff);

                    // Only set if not already modified by user
                    const borrowDateInput = document.getElementById('borrowDate');
                    if (borrowDateInput.value === borrowDateInput.defaultValue) {
                        borrowDateInput.value = now.toISOString().split('T')[0];
                    }

                    // Calculate return date (14 days from now)
                    const returnDate = new Date(now);
                    returnDate.setDate(returnDate.getDate() + 14);

                    const returnDateInput = document.getElementById('returnDate');
                    if (returnDateInput.value === returnDateInput.defaultValue) {
                        returnDateInput.value = returnDate.toISOString().split('T')[0];
                    }
                }

                // Set active link in sidebar
                document.querySelectorAll('.nav-link').forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href').includes('borrow-book')) {
                        link.classList.add('active');
                    }
                });
            });
        </script>
    </body>
</html>