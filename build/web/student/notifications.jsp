<%-- 
    Document   : notifications.jsp
    Created on : May 10, 2025, 11:46:05 PM
    Author     : hakus
--%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Notifications | Library Management System</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

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
        </style>
    </head>
    <body>
        <div class="wrapper">
            <%@ include file="nav-bar.jsp" %>
            <!-- Header -->
            <div class="page-header">
                <h2 class="greeting">Welcome, <%= studentName%>!</h2>
                <p class="text-muted">Here's what's happening with your library activities</p>
            </div>
            <div class="content">
                <div class="container-fluid">
                    <div class="page-header">
                        <h2 class="greeting">Notifications</h2>
                        <p class="text-muted">Here are your recent updates and alerts.</p>
                    </div>

                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action">
                            <i class="fas fa-envelope me-2"></i>
                            You have successfully reserved "Java Programming Basics"
                            <span class="badge bg-success float-end">New</span>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <i class="fas fa-clock me-2"></i>
                            Return "Web Dev 101" before May 14th
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <i class="fas fa-bell me-2"></i>
                            Your request for "Artificial Intelligence" is being processed
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
