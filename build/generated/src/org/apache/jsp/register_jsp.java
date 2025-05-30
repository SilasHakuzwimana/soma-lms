package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class register_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("<!-- File: register.jsp -->\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Register - SOMA LMS</title>\n");
      out.write("    <link href=\"https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("    <link href=\"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/css/intlTelInput.css\" rel=\"stylesheet\">\n");
      out.write("    <link href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css\" rel=\"stylesheet\">\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/register-custom.css\">\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <div class=\"container mt-5 mb-5\">\n");
      out.write("        <div class=\"registration-container\">\n");
      out.write("            <div class=\"form-header\">\n");
      out.write("                <h2>Student Registration</h2>\n");
      out.write("                <p>Create your account to access SOMA Learning Management System</p>\n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <form id=\"registrationForm\" novalidate>\n");
      out.write("                <div class=\"row mb-3\">\n");
      out.write("                    <div class=\"col-md-6\">\n");
      out.write("                        <label for=\"regNumber\" class=\"form-label\">Registration Number</label>\n");
      out.write("                        <div class=\"input-group\">\n");
      out.write("                            <span class=\"input-group-text\"><i class=\"fas fa-id-card\"></i></span>\n");
      out.write("                            <input type=\"text\" class=\"form-control\" id=\"regNumber\" name=\"reg_number\" required placeholder=\"e.g., REG2025001\">\n");
      out.write("                            <div class=\"invalid-feedback\">\n");
      out.write("                                Please provide a registration number.\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"col-md-6\">\n");
      out.write("                        <label for=\"fullName\" class=\"form-label\">Full Name</label>\n");
      out.write("                        <div class=\"input-group\">\n");
      out.write("                            <span class=\"input-group-text\"><i class=\"fas fa-user\"></i></span>\n");
      out.write("                            <input type=\"text\" class=\"form-control\" id=\"fullName\" name=\"full_name\" required placeholder=\"Enter your full name\">\n");
      out.write("                            <div class=\"invalid-feedback\">\n");
      out.write("                                Please provide your full name.\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"mb-3\">\n");
      out.write("                    <label for=\"email\" class=\"form-label\">Email Address</label>\n");
      out.write("                    <div class=\"input-group\">\n");
      out.write("                        <span class=\"input-group-text\"><i class=\"fas fa-envelope\"></i></span>\n");
      out.write("                        <input type=\"email\" class=\"form-control\" id=\"email\" name=\"email\" required placeholder=\"your.email@example.com\">\n");
      out.write("                        <div class=\"invalid-feedback\">\n");
      out.write("                            Please provide a valid email address.\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"mb-3\">\n");
      out.write("                    <label for=\"phone\" class=\"form-label\">Phone Number</label>\n");
      out.write("                    <input type=\"tel\" class=\"form-control\" id=\"phone\" name=\"phone\" required>\n");
      out.write("                    <div class=\"invalid-feedback\">\n");
      out.write("                        Please provide a valid phone number.\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"mb-3\">\n");
      out.write("                    <label for=\"password\" class=\"form-label\">Password</label>\n");
      out.write("                    <div class=\"input-group password-container\">\n");
      out.write("                        <span class=\"input-group-text\"><i class=\"fas fa-lock\"></i></span>\n");
      out.write("                        <input type=\"password\" class=\"form-control\" id=\"password\" name=\"password\" required placeholder=\"Create a strong password\" \n");
      out.write("                               pattern=\"^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$\">\n");
      out.write("                        <span class=\"password-toggle\" onclick=\"togglePassword('password')\">\n");
      out.write("                            <i class=\"fas fa-eye\" id=\"togglePasswordIcon\"></i>\n");
      out.write("                        </span>\n");
      out.write("                        <div class=\"invalid-feedback\">\n");
      out.write("                            Password must be at least 8 characters with uppercase, lowercase, number and special character.\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"mb-3\">\n");
      out.write("                    <label for=\"confirmPassword\" class=\"form-label\">Confirm Password</label>\n");
      out.write("                    <div class=\"input-group password-container\">\n");
      out.write("                        <span class=\"input-group-text\"><i class=\"fas fa-lock\"></i></span>\n");
      out.write("                        <input type=\"password\" class=\"form-control\" id=\"confirmPassword\" required placeholder=\"Retype your password\">\n");
      out.write("                        <span class=\"password-toggle\" onclick=\"togglePassword('confirmPassword')\">\n");
      out.write("                            <i class=\"fas fa-eye\" id=\"toggleConfirmIcon\"></i>\n");
      out.write("                        </span>\n");
      out.write("                        <div class=\"invalid-feedback\" id=\"password-match-feedback\">\n");
      out.write("                            Passwords do not match.\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <!-- Hidden student role input -->\n");
      out.write("                <input type=\"hidden\" name=\"role\" value=\"student\">\n");
      out.write("                \n");
      out.write("                <div class=\"mb-3 form-check\">\n");
      out.write("                    <input type=\"checkbox\" class=\"form-check-input\" id=\"termsCheck\" required>\n");
      out.write("                    <label class=\"form-check-label\" for=\"termsCheck\">I agree to the <a href=\"#\">Terms and Conditions</a></label>\n");
      out.write("                    <div class=\"invalid-feedback\">\n");
      out.write("                        You must agree to the terms and conditions.\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"d-grid gap-2\">\n");
      out.write("                    <button type=\"submit\" class=\"btn btn-primary btn-register\" id=\"submitBtn\">\n");
      out.write("                        Create Account\n");
      out.write("                        <span class=\"spinner-border spinner-border-sm loading-spinner\" id=\"loadingSpinner\" role=\"status\" aria-hidden=\"true\"></span>\n");
      out.write("                    </button>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <div class=\"alert\" id=\"registration-feedback\" role=\"alert\"></div>\n");
      out.write("            </form>\n");
      out.write("            \n");
      out.write("            <div class=\"login-link\">\n");
      out.write("                Already have an account? <a href=\"login.jsp\">Login here</a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <!-- JavaScript Libraries -->\n");
      out.write("    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js\"></script>\n");
      out.write("    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/intlTelInput.min.js\"></script>\n");
      out.write("    \n");
      out.write("    <script>\n");
      out.write("        // Initialize phone input with country codes\n");
      out.write("        var phoneInput = document.querySelector(\"#phone\");\n");
      out.write("        var iti = window.intlTelInput(phoneInput, {\n");
      out.write("            utilsScript: \"https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/utils.js\",\n");
      out.write("            separateDialCode: true,\n");
      out.write("            initialCountry: \"auto\",\n");
      out.write("            geoIpLookup: function(callback) {\n");
      out.write("                // In a real environment, you would use a service to get the user's location\n");
      out.write("                // For demo purposes, we'll default to US\n");
      out.write("                callback(\"US\");\n");
      out.write("            }\n");
      out.write("        });\n");
      out.write("        \n");
      out.write("        // Toggle password visibility\n");
      out.write("        function togglePassword(fieldId) {\n");
      out.write("            const passwordField = document.getElementById(fieldId);\n");
      out.write("            const icon = fieldId === 'password' ? document.getElementById('togglePasswordIcon') : document.getElementById('toggleConfirmIcon');\n");
      out.write("            \n");
      out.write("            if (passwordField.type === \"password\") {\n");
      out.write("                passwordField.type = \"text\";\n");
      out.write("                icon.classList.remove(\"fa-eye\");\n");
      out.write("                icon.classList.add(\"fa-eye-slash\");\n");
      out.write("            } else {\n");
      out.write("                passwordField.type = \"password\";\n");
      out.write("                icon.classList.remove(\"fa-eye-slash\");\n");
      out.write("                icon.classList.add(\"fa-eye\");\n");
      out.write("            }\n");
      out.write("        }\n");
      out.write("        \n");
      out.write("        // Form validation and submission\n");
      out.write("        document.addEventListener('DOMContentLoaded', function() {\n");
      out.write("            const form = document.getElementById('registrationForm');\n");
      out.write("            const password = document.getElementById('password');\n");
      out.write("            const confirmPassword = document.getElementById('confirmPassword');\n");
      out.write("            const feedbackDiv = document.getElementById('registration-feedback');\n");
      out.write("            const submitBtn = document.getElementById('submitBtn');\n");
      out.write("            const loadingSpinner = document.getElementById('loadingSpinner');\n");
      out.write("            \n");
      out.write("            // Check if passwords match\n");
      out.write("            confirmPassword.addEventListener('input', function() {\n");
      out.write("                if (confirmPassword.value !== password.value) {\n");
      out.write("                    confirmPassword.setCustomValidity(\"Passwords don't match\");\n");
      out.write("                } else {\n");
      out.write("                    confirmPassword.setCustomValidity('');\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("            \n");
      out.write("            // Handle form submission\n");
      out.write("            form.addEventListener('submit', function(event) {\n");
      out.write("                event.preventDefault();\n");
      out.write("                event.stopPropagation();\n");
      out.write("                \n");
      out.write("                // Add validation classes\n");
      out.write("                form.classList.add('was-validated');\n");
      out.write("                \n");
      out.write("                // Check if form is valid\n");
      out.write("                if (form.checkValidity() && password.value === confirmPassword.value) {\n");
      out.write("                    // Get full phone number with country code\n");
      out.write("                    const fullPhoneNumber = iti.getNumber();\n");
      out.write("                    \n");
      out.write("                    // Show loading spinner\n");
      out.write("                    loadingSpinner.style.display = 'inline-block';\n");
      out.write("                    submitBtn.disabled = true;\n");
      out.write("                    \n");
      out.write("                    // Prepare form data\n");
      out.write("                    const formData = {\n");
      out.write("                        reg_number: document.getElementById('regNumber').value,\n");
      out.write("                        full_name: document.getElementById('fullName').value,\n");
      out.write("                        email: document.getElementById('email').value,\n");
      out.write("                        phone: fullPhoneNumber,\n");
      out.write("                        password: password.value,\n");
      out.write("                        role: 'student'\n");
      out.write("                    };\n");
      out.write("                    \n");
      out.write("                    // Send AJAX request\n");
      out.write("                    $.ajax({\n");
      out.write("                        type: 'POST',\n");
      out.write("                        url: 'register',\n");
      out.write("                        data: formData,\n");
      out.write("                        success: function(response) {\n");
      out.write("                            // Hide loading spinner\n");
      out.write("                            loadingSpinner.style.display = 'none';\n");
      out.write("                            submitBtn.disabled = false;\n");
      out.write("                            \n");
      out.write("                            // Show success message\n");
      out.write("                            feedbackDiv.classList.remove('alert-danger');\n");
      out.write("                            feedbackDiv.classList.add('alert-success');\n");
      out.write("                            feedbackDiv.textContent = 'Registration successful! Redirecting to login page...';\n");
      out.write("                            feedbackDiv.style.display = 'block';\n");
      out.write("                            \n");
      out.write("                            // Redirect to login page after a short delay\n");
      out.write("                            setTimeout(function() {\n");
      out.write("                                window.location.href = 'login.jsp';\n");
      out.write("                            }, 2000);\n");
      out.write("                        },\n");
      out.write("                        error: function(xhr, status, error) {\n");
      out.write("                            // Hide loading spinner\n");
      out.write("                            loadingSpinner.style.display = 'none';\n");
      out.write("                            submitBtn.disabled = false;\n");
      out.write("                            \n");
      out.write("                            // Show error message\n");
      out.write("                            feedbackDiv.classList.remove('alert-success');\n");
      out.write("                            feedbackDiv.classList.add('alert-danger');\n");
      out.write("                            feedbackDiv.textContent = xhr.responseText || 'Registration failed. Please try again.';\n");
      out.write("                            feedbackDiv.style.display = 'block';\n");
      out.write("                        }\n");
      out.write("                    });\n");
      out.write("                } else {\n");
      out.write("                    // Handle invalid form\n");
      out.write("                    if (password.value !== confirmPassword.value) {\n");
      out.write("                        document.getElementById('password-match-feedback').style.display = 'block';\n");
      out.write("                    }\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("            \n");
      out.write("            // Reset form validation when inputs change\n");
      out.write("            const inputs = form.querySelectorAll('input');\n");
      out.write("            inputs.forEach(input => {\n");
      out.write("                input.addEventListener('input', function() {\n");
      out.write("                    if (form.classList.contains('was-validated')) {\n");
      out.write("                        if (this.checkValidity()) {\n");
      out.write("                            this.classList.remove('is-invalid');\n");
      out.write("                            this.classList.add('is-valid');\n");
      out.write("                        } else {\n");
      out.write("                            this.classList.remove('is-valid');\n");
      out.write("                            this.classList.add('is-invalid');\n");
      out.write("                        }\n");
      out.write("                    }\n");
      out.write("                });\n");
      out.write("            });\n");
      out.write("        });\n");
      out.write("    </script>\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
