package servlet;

import utils.DBConnection;
import utils.EmailSender;
import utils.OTPGenerator;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONException;
import org.json.JSONObject;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            try {
                json.put("status", "error");
            } catch (JSONException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                json.put("message", "Please fill in all fields.");
            } catch (JSONException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            out.print(json.toString());
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE email = ?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, email);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    int userId = rs.getInt("id");
                    String fullName = rs.getString("full_name");
                    String role = rs.getString("role");

                    HttpSession session = request.getSession();
                    session.setAttribute("user_id", userId);
                    session.setAttribute("email", email);
                    session.setAttribute("role", role);
                    session.setAttribute("full_name", fullName);

                    // Generate OTP and send email
                    String otp = OTPGenerator.generateOTP(6);
                    session.setAttribute("otp", otp);

                    // Store OTP in the database
                    Timestamp createdAt = utils.TimeUtils.getCurrentKigaliTimestamp();
                    Timestamp expiresAt = utils.TimeUtils.getExpiryKigaliTimestamp(10); // 10-minute expiry

                    String insertOtpSQL = "INSERT INTO user_otps (email, otp_code, created_at, expires_at) VALUES (?, ?, ?, ?)";
                    PreparedStatement otpStmt = conn.prepareStatement(insertOtpSQL);
                    otpStmt.setString(1, email);
                    otpStmt.setString(2, otp);
                    otpStmt.setTimestamp(3, createdAt);
                    otpStmt.setTimestamp(4, expiresAt);
                    otpStmt.executeUpdate();

                    String subject = "SOMA LMS OTP Verification";
                    String body = "<!DOCTYPE html>"
                            + "<html lang='en'>"
                            + "<head>"
                            + "  <meta charset='UTF-8'>"
                            + "  <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
                            + "  <style>"
                            + "    body { font-family: 'Segoe UI', sans-serif; background-color: #f9f9f9; padding: 20px; }"
                            + "    .container { max-width: 600px; margin: auto; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); padding: 30px; }"
                            + "    h2 { color: #2c3e50; }"
                            + "    p { font-size: 15px; color: #333333; line-height: 1.6; }"
                            + "    .otp-code { font-size: 24px; font-weight: bold; color: #1abc9c; letter-spacing: 2px; margin: 20px 0; }"
                            + "    .footer { font-size: 13px; color: #888888; margin-top: 30px; }"
                            + "  </style>"
                            + "</head>"
                            + "<body>"
                            + "  <div class='container'>"
                            + "    <h2>OTP Verification - SOMA LMS</h2>"
                            + "    <p>Dear " + fullName + ",</p>"
                            + "    <p>We received a request to log into your SOMA LMS account. To proceed, please use the One-Time Password (OTP) below:</p>"
                            + "    <div class='otp-code'>" + otp + "</div>"
                            + "    <p>This OTP is valid for one login session and will expire shortly for your security. Do not share this code with anyone.</p>"
                            + "    <p>If you did not request this, please ignore this message or contact support immediately.</p>"
                            + "    <p>Thank you,<br><strong>SOMA LMS Team</strong></p>"
                            + "    <div class='footer'>"
                            + "      <p>This is an automated message, please do not reply. For help, contact support@soma.lms</p>"
                            + "    </div>"
                            + "  </div>"
                            + "</body>"
                            + "</html>";

                    boolean emailSent = EmailSender.sendEmail(email, subject, body);

                    if (!emailSent) {
                        json.put("status", "error");
                        json.put("message", "Login successful but failed to send OTP email.");
                    } else {
                        json.put("status", "success");
                        json.put("message", "OTP sent to your email.");
                    }
                } else {
                    json.put("status", "error");
                    json.put("message", "Incorrect password.");
                }
            } else {
                json.put("status", "error");
                json.put("message", "User not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                json.put("status", "error");
            } catch (JSONException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                json.put("message", "Server error: " + e.getMessage());
            } catch (JSONException ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        out.print(json.toString());
    }
}
