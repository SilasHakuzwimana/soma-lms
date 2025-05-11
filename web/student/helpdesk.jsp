<%-- 
    Document   : helpdesk.jsp
    Created on : May 10, 2025, 11:46:22 PM
    Author     : hakus
--%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Helpdesk | Library Management System</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="nav-bar.jsp" %>
        <div class="content">
            <div class="container-fluid">
                <div class="page-header">
                    <h2 class="greeting">Helpdesk</h2>
                    <p class="text-muted">Need help? Submit a ticket and our support team will respond shortly.</p>
                </div>

                <form class="card p-4 shadow-sm bg-white rounded">
                    <div class="mb-3">
                        <label for="subject" class="form-label">Subject</label>
                        <input type="text" class="form-control" id="subject" placeholder="Enter the issue subject" required>
                    </div>
                    <div class="mb-3">
                        <label for="issue" class="form-label">Describe your issue</label>
                        <textarea class="form-control" id="issue" rows="5" placeholder="Provide as much detail as possible" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane me-1"></i> Submit Ticket</button>
                </form>
            </div>
        </div>
    </body>
</html>

