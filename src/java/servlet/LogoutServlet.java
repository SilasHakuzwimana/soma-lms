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

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import utils.DBConnection;

/**
 * Servlet for handling user logout
 *
 * @author hakus
 */


@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    /**
     * Handles GET requests for user logout
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            // Get user ID before invalidating session
            Integer userId = (Integer) session.getAttribute("user_id");

            if (userId != null) {
                // Log the logout activity
                logUserActivity(userId, "logout", "User logged out", request);

                // Remove remember-me token if exists
                removeRememberMeToken(userId, request, response);
            }

            // Invalidate the session
            session.invalidate();
        }

        // Delete the remember-me cookie if exists
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_me".equals(cookie.getName())) {
                    cookie.setValue("");
                    cookie.setPath("/");
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
                }
            }
        }

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    /**
     * Logs a user activity
     */
    private void logUserActivity(int userId, String action, String description, HttpServletRequest request) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO activity_logs (user_id, action, description, ip_address, user_agent) "
                    + "VALUES (?, ?, ?, ?, ?)");

            ps.setInt(1, userId);
            ps.setString(2, action);
            ps.setString(3, description);
            ps.setString(4, getClientIpAddress(request));
            ps.setString(5, request.getHeader("User-Agent"));

            ps.executeUpdate();
        } catch (SQLException e) {
            log("Error logging user activity: " + e.getMessage(), e);
        }
    }

    /**
     * Removes remember-me token from database
     */
    private void removeRememberMeToken(int userId, HttpServletRequest request, HttpServletResponse response) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM user_sessions WHERE user_id = ? AND session_token LIKE 'remember_%'");
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            log("Error removing remember-me token: " + e.getMessage(), e);
        }
    }

    /**
     * Gets the client's IP address from request
     */
    private String getClientIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
