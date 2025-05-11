<%-- 
    Document   : login.jsp
    Created on : May 10, 2025, 10:18:28 AM
    Author     : hakus
    Updated on : May 11, 2025
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - SOMA LMS</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4361ee;
                --primary-hover: #3a56d4;
                --secondary-color: #3f37c9;
                --text-primary: #333333;
                --text-secondary: #6c757d;
                --bg-light: #f8f9fa;
                --bg-card: #ffffff;
                --border-radius: 12px;
                --box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
                --transition: all 0.3s ease;
            }

            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #e4e9f2 100%);
                font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
                min-height: 100vh;
                display: flex;
                align-items: center;
                padding: 20px 0;
            }

            .login-container {
                max-width: 480px;
                margin: 0 auto;
                padding: 35px;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                background-color: var(--bg-card);
                position: relative;
                overflow: hidden;
            }

            .login-container::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            }

            .brand-logo {
                text-align: center;
                margin-bottom: 25px;
            }

            .soma-logo-placeholder {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: linear-gradient(135deg, #e9effd, #f3f6fd);
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
                box-shadow: 0 4px 15px rgba(67, 97, 238, 0.1);
                border: 1px solid rgba(67, 97, 238, 0.1);
                transition: var(--transition);
            }

            .soma-logo-placeholder img {
                max-width: 65px;
                height: auto;
            }

            .login-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .login-header h2 {
                font-weight: 700;
                color: var(--text-primary);
                margin-bottom: 10px;
                font-size: 1.75rem;
            }

            .login-header p {
                color: var(--text-secondary);
                font-size: 0.95rem;
                max-width: 320px;
                margin: 0 auto;
            }

            .form-label {
                font-weight: 600;
                color: var(--text-primary);
                font-size: 0.9rem;
                margin-bottom: 8px;
            }

            .form-control {
                padding: 12px 15px;
                border: 1px solid #e1e5eb;
                border-radius: 8px;
                transition: var(--transition);
                font-size: 0.95rem;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            }

            .input-group {
                border-radius: 8px;
                overflow: hidden;
            }

            .input-group-text {
                background-color: #f8fafd;
                border: 1px solid #e1e5eb;
                border-right: none;
                color: var(--text-secondary);
                padding-left: 15px;
                padding-right: 15px;
            }

            .input-group .form-control {
                border-left: none;
            }

            .password-container {
                position: relative;
            }

            .password-toggle {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: var(--text-secondary);
                z-index: 10;
                background: transparent;
                border: none;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .form-check-label {
                color: var(--text-secondary);
                font-size: 0.9rem;
            }

            .form-check-input:checked {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-login {
                background-color: var(--primary-color);
                border: none;
                font-weight: 600;
                padding: 12px 20px;
                border-radius: 8px;
                transition: var(--transition);
                font-size: 1rem;
            }

            .btn-login:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(67, 97, 238, 0.2);
            }

            .btn-login:active {
                transform: translateY(0);
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 25px 0;
                color: var(--text-secondary);
                font-size: 0.9rem;
            }

            .divider::before, .divider::after {
                content: "";
                flex: 1;
                border-bottom: 1px solid #e9ecef;
            }

            .divider::before {
                margin-right: 15px;
            }

            .divider::after {
                margin-left: 15px;
            }

            .btn-google {
                background-color: #ffffff;
                border: 1px solid #e1e5eb;
                color: var(--text-primary);
                font-weight: 500;
                padding: 12px 20px;
                border-radius: 8px;
                transition: var(--transition);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            .btn-google:hover {
                background-color: #f8fafd;
                border-color: #d8dee9;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            }

            .btn-google i {
                color: #4285F4;
                font-size: 1.1rem;
            }

            .forgot-link, .register-link {
                text-align: center;
                margin-top: 20px;
                font-size: 0.9rem;
            }

            .forgot-link a, .register-link a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 600;
                transition: var(--transition);
            }

            .forgot-link a:hover, .register-link a:hover {
                color: var(--primary-hover);
                text-decoration: underline;
            }

            .login-footer {
                text-align: center;
                margin-top: 30px;
                font-size: 0.85rem;
                color: var(--text-secondary);
                padding-top: 20px;
                border-top: 1px solid #f1f3f5;
            }

            .alert {
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 25px;
                font-size: 0.9rem;
            }

            .loading-spinner {
                margin-left: 10px;
                display: none;
            }

            /* Animation for the form */
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .form-animated {
                animation: fadeIn 0.6s ease-out;
            }

            /* Responsive adjustments */
            @media (max-width: 576px) {
                .login-container {
                    padding: 25px 20px;
                }

                .login-header h2 {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="login-container form-animated">
                <div class="brand-logo">
                    <div class="soma-logo-placeholder">
                        <img src="images/system-logo.jpg" alt="SOMA LMS" class="img-fluid">
                    </div>
                </div>

                <div class="login-header">
                    <h2>Welcome Back</h2>
                    <p>Sign in to continue to SOMA Learning Management System</p>
                </div>

                <!-- Alert Messages -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                    </div>
                </c:if>
                <div id="login-alert" class="my-2"></div>

                <form id="loginForm" action="login" method="post" novalidate class="needs-validation">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" required 
                                   placeholder="your.email@example.com">
                        </div>
                        <div class="invalid-feedback">
                            Please enter a valid email address.
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label for="password" class="form-label mb-0">Password</label>
                            <a href="forgot-password.jsp" class="text-decoration-none" style="font-size: 0.85rem; font-weight: 500; color: var(--primary-color);">Forgot password?</a>
                        </div>
                        <div class="input-group password-container">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" required 
                                   placeholder="Enter your password">
                            <button type="button" class="password-toggle" id="togglePassword">
                                <i class="fas fa-eye" id="togglePasswordIcon"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback">
                            Please enter your password.
                        </div>
                    </div>

                    <div class="mb-4 form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe" name="remember_me">
                        <label class="form-check-label" for="rememberMe">Remember me for 30 days</label>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-login" id="loginBtn">
                            Sign In
                            <span class="spinner-border spinner-border-sm loading-spinner" id="loadingSpinner" role="status" aria-hidden="true"></span>
                        </button>
                    </div>
                </form>

                <div class="divider">or continue with</div>

                <div class="d-grid">
                    <button type="button" class="btn btn-google">
                        <i class="fab fa-google"></i> Sign in with Google
                    </button>
                </div>

                <div class="register-link">
                    Don't have an account? <a href="register.jsp">Create an account</a>
                </div>

                <div class="login-footer">
                    &copy; <span id="footerYear"></span> SOMA Learning Management System. All rights reserved.
                </div>
            </div>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>

        <script>
            // Set current year in footer
            document.getElementById('footerYear').innerHTML = new Date().getFullYear();

            // Form validation
            (function () {
                'use strict';

                const forms = document.querySelectorAll('.needs-validation');

                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }

                        form.classList.add('was-validated');
                    }, false);
                });
            })();

            // Show/hide password
            document.getElementById("togglePassword").addEventListener("click", function () {
                const passwordField = document.getElementById("password");
                const icon = document.getElementById("togglePasswordIcon");
                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    passwordField.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            });

            // AJAX form submission
            $(document).ready(function () {
                $('#loginForm').submit(function (e) {
                    if (!this.checkValidity()) {
                        return;
                    }

                    e.preventDefault(); // prevent form from submitting normally

                    // Show loading spinner
                    $('#loadingSpinner').show();
                    $('#loginBtn').prop('disabled', true);

                    // Collect form data
                    var formData = {
                        email: $('#email').val(),
                        password: $('#password').val(),
                        remember_me: $('#rememberMe').is(':checked')
                    };

                    // Send AJAX POST to LoginServlet
                    $.ajax({
                        type: 'POST',
                        url: 'LoginServlet',
                        data: formData,
                        dataType: 'json',
                        success: function (response) {
                            $('#loadingSpinner').hide();
                            $('#loginBtn').prop('disabled', false);

                            if (response.status === 'success') {
                                // Show success message
                                $('#login-alert').html(`
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle me-2"></i> OTP sent to your email!
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                `);

                                // Redirect with slight delay for better UX
                                setTimeout(function () {
                                    window.location.href = 'verify-otp.jsp';
                                }, 1000);
                            } else {
                                $('#login-alert').html(`
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-circle me-2"></i> ${response.message}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                `);
                            }
                        },
                        error: function (xhr, status, error) {
                            $('#loadingSpinner').hide();
                            $('#loginBtn').prop('disabled', false);

                            $('#login-alert').html(`
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-triangle me-2"></i> Connection error. Please try again.
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            `);
                        }
                    });
                });

                // Auto-hide alerts after 5 seconds
                $(document).on('shown.bs.alert', '.alert', function () {
                    const alert = $(this);
                    setTimeout(function () {
                        alert.alert('close');
                    }, 5000);
                });
            });
        </script>
    </body>
</html>