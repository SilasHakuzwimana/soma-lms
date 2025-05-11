package servlet;

import java.io.IOException;
import java.sql.*;
import java.time.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import utils.DBConnection;

@WebServlet("/verify-otp")
public class OTPVerificationServlet extends HttpServlet {

    private static final int MAX_ATTEMPTS = 3;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            request.setAttribute("error", "Session expired. Please login again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String userEmail = (String) session.getAttribute("email");
        String enteredOTP = request.getParameter("otp");

        if (enteredOTP == null || enteredOTP.trim().isEmpty()) {
            request.setAttribute("error", "Please enter the OTP.");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
            return;
        }

        // Timezone
        ZoneId kigaliZone = ZoneId.of("Africa/Kigali");
        Timestamp now = Timestamp.from(ZonedDateTime.now(kigaliZone).toInstant());

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT * FROM user_otps WHERE email = ? AND otp_code = ? AND expires_at > ? ORDER BY created_at DESC LIMIT 1"
            );
            ps.setString(1, userEmail);
            ps.setString(2, enteredOTP);
            ps.setTimestamp(3, now);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // OTP is valid
                PreparedStatement deleteOTPStmt = conn.prepareStatement(
                        "DELETE FROM user_otps WHERE email = ? AND otp_code = ?"
                );
                deleteOTPStmt.setString(1, userEmail);
                deleteOTPStmt.setString(2, enteredOTP);
                deleteOTPStmt.executeUpdate();

                PreparedStatement updateLogin = conn.prepareStatement(
                        "UPDATE users SET last_login = ? WHERE email = ?"
                );
                updateLogin.setTimestamp(1, now);
                updateLogin.setString(2, userEmail);
                updateLogin.executeUpdate();

                // Auth success
                session.setAttribute("authenticated", true);
                session.removeAttribute("otp_attempts");

                String userRole = (String) session.getAttribute("role");

                switch (userRole) {
                    case "admin":
                        response.sendRedirect("admin/admin-dashboard.jsp");
                        break;
                    case "lecturer":
                        response.sendRedirect("lecturer/lecturer-dashboard.jsp");
                        break;
                    case "librarian":
                        response.sendRedirect("librarian/librarian-dashboard.jsp");
                        break;
                    case "student":
                    default:
                        response.sendRedirect("student/student-dashboard.jsp");
                        break;
                }

            } else {
                // Count failed attempts
                Integer attempts = (Integer) session.getAttribute("otp_attempts");
                attempts = (attempts == null) ? 1 : attempts + 1;
                session.setAttribute("otp_attempts", attempts);

                if (attempts >= MAX_ATTEMPTS) {
                    session.invalidate();
                    request.setAttribute("error", "Too many failed attempts. Please login again.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Invalid or expired OTP. Try again.");
                    request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
    }
}
