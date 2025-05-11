/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filter;

/**
 *
 * @author hakus
 */

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Filter to protect pages that require authentication. This filter ensures
 * users are authenticated before accessing protected resources.
 */


@WebFilter(urlPatterns = {"/admin/*", "/lecturer/*", "/student/*", "/librarian/*"})
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Optional: Any initialization logic can be added here
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        boolean isAuthenticated = session != null && Boolean.TRUE.equals(session.getAttribute("authenticated"));

        boolean hasAccess = false;

        if (isAuthenticated) {
            String userRole = (String) session.getAttribute("role");
            // Role-based access control
            if (requestURI.contains("/admin/") && "admin".equals(userRole)) {
                hasAccess = true;
            } else if (requestURI.contains("/lecturer/") && "lecturer".equals(userRole)) {
                hasAccess = true;
            } else if (requestURI.contains("/student/") && "student".equals(userRole)) {
                hasAccess = true;
            } else if (requestURI.contains("/librarian/") && "librarian".equals(userRole)) {
                hasAccess = true;
            }
        }

        // If user is authenticated and has appropriate access, continue the request
        if (isAuthenticated && hasAccess) {
            chain.doFilter(request, response);
        } else {
            // If not authenticated or no access, invalidate the session and redirect to login page
            if (session != null) {
                session.invalidate();
            }
            // Optionally, you can add a message in the URL like `?error=sessionExpired`
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=accessDenied");
        }
    }

    @Override
    public void destroy() {
        // Optional: Cleanup logic if needed
    }
}
