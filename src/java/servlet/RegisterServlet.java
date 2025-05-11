/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

/**
 *
 * @author hakus
 */
// File:servlet/RegisterServlet.java

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import org.json.JSONException;
import org.mindrot.jbcrypt.BCrypt;
import utils.DBConnection;
import utils.TimeUtils;
import org.json.JSONObject;

/**
 * Servlet for handling user registration with enhanced validation and AJAX
 * support
 *
 * @author hakus
 */


@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    // Email validation pattern
    private static final Pattern EMAIL_PATTERN
            = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

    // Password validation pattern (min 8 chars, at least 1 uppercase, 1 lowercase, 1 number, 1 special char)
    private static final Pattern PASSWORD_PATTERN
            = Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$");

    // Registration number pattern (alphanumeric)
    private static final Pattern REG_NUMBER_PATTERN
            = Pattern.compile("^[A-Za-z0-9]{3,15}$");

    // Phone number pattern (flexible to allow international formats)
    private static final Pattern PHONE_PATTERN
            = Pattern.compile("^\\+?[0-9\\s\\-()]{6,20}$");

    /**
     * Handles POST requests for user registration
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type for AJAX
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Get form parameters
        String regNumber = request.getParameter("reg_number");
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Create JSON response object
        JSONObject jsonResponse = new JSONObject();

        try {
            // Validate input parameters
            String validationError = validateInputs(regNumber, fullName, email, phone, password);

            if (validationError != null) {
                // Return validation error
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("success", false);
                jsonResponse.put("message", validationError);
                out.print(jsonResponse.toString());
                return;
            }

            // Check if user already exists
            if (userExists(email, regNumber)) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "A user with this email or registration number already exists");
                out.print(jsonResponse.toString());
                return;
            }

            // Hash password
            String hashedPwd = BCrypt.hashpw(password, BCrypt.gensalt(12));

            // Insert user into database
            if (insertUser(regNumber, fullName, email, phone, hashedPwd, role)) {
                // Successful registration
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Registration successful");
                out.print(jsonResponse.toString());
            } else {
                // Failed to insert record
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Registration failed due to database error");
                out.print(jsonResponse.toString());
            }

        } catch (SQLException e) {
            // Handle database errors
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                jsonResponse.put("success", false);
            } catch (JSONException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                jsonResponse.put("message", "Database error: " + e.getMessage());
            } catch (JSONException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            out.print(jsonResponse.toString());
            log("Database error during registration: " + e.getMessage(), e);
        } catch (Exception e) {
            // Handle other errors
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try {
                jsonResponse.put("success", false);
            } catch (JSONException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                jsonResponse.put("message", "An unexpected error occurred: " + e.getMessage());
            } catch (JSONException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            out.print(jsonResponse.toString());
            log("Unexpected error during registration: " + e.getMessage(), e);
        }
    }

    /**
     * Validates user input
     *
     * @return null if valid, error message if invalid
     */
    private String validateInputs(String regNumber, String fullName, String email,
            String phone, String password) {

        // Check for empty fields
        if (regNumber == null || regNumber.trim().isEmpty()) {
            return "Registration number is required";
        }
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Full name is required";
        }
        if (email == null || email.trim().isEmpty()) {
            return "Email is required";
        }
        if (phone == null || phone.trim().isEmpty()) {
            return "Phone number is required";
        }
        if (password == null || password.trim().isEmpty()) {
            return "Password is required";
        }

        // Validate patterns
        if (!REG_NUMBER_PATTERN.matcher(regNumber).matches()) {
            return "Invalid registration number format";
        }
        if (fullName.length() < 2 || fullName.length() > 100) {
            return "Full name must be between 2 and 100 characters";
        }
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return "Invalid email format";
        }
        if (!PHONE_PATTERN.matcher(phone).matches()) {
            return "Invalid phone number format";
        }
        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            return "Password must be at least 8 characters with uppercase, lowercase, number and special character";
        }

        return null; // No validation errors
    }

    /**
     * Checks if a user with the given email or registration number already
     * exists
     */
    private boolean userExists(String email, String regNumber) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT COUNT(*) FROM users WHERE email = ? OR reg_number = ?");
            ps.setString(1, email);
            ps.setString(2, regNumber);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    /**
     * Inserts a new user into the database
     */
    private boolean insertUser(String regNumber, String fullName, String email,
            String phone, String hashedPwd, String role) throws SQLException {

        try (Connection conn = DBConnection.getConnection()) {
            // Begin transaction
            conn.setAutoCommit(false);

            try {
                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO users (reg_number, full_name, email, phone, password, role, created_at) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?)");

                ps.setString(1, regNumber);
                ps.setString(2, fullName);
                ps.setString(3, email);
                ps.setString(4, phone);
                ps.setString(5, hashedPwd);
                ps.setString(6, role != null && !role.isEmpty() ? role : "student");
                ps.setTimestamp(7, TimeUtils.getCurrentKigaliTimestamp());

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    // Commit transaction
                    conn.commit();
                    return true;
                } else {
                    // Rollback transaction
                    conn.rollback();
                    return false;
                }
            } catch (SQLException e) {
                // Rollback transaction on error
                conn.rollback();
                throw e;
            } finally {
                // Reset auto-commit
                conn.setAutoCommit(true);
            }
        }
    }
}
