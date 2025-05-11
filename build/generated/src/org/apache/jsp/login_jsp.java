package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_if_test;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_c_if_test = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_c_if_test.release();
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
      response.setContentType("text/html;charset=UTF-8");
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
      out.write("\n");
      out.write(" \n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <title>Login - SOMA LMS</title>\n");
      out.write("        <link href=\"https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <link href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css\" rel=\"stylesheet\">\n");
      out.write("        <style>\n");
      out.write("            body {\n");
      out.write("                background-color: #f8f9fa;\n");
      out.write("                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;\n");
      out.write("            }\n");
      out.write("            .login-container {\n");
      out.write("                max-width: 450px;\n");
      out.write("                margin: 80px auto;\n");
      out.write("                padding: 30px;\n");
      out.write("                border-radius: 10px;\n");
      out.write("                box-shadow: 0 0 20px rgba(0,0,0,0.1);\n");
      out.write("                background-color: #fff;\n");
      out.write("            }\n");
      out.write("            .login-header {\n");
      out.write("                text-align: center;\n");
      out.write("                margin-bottom: 30px;\n");
      out.write("            }\n");
      out.write("            .login-header h2 {\n");
      out.write("                font-weight: 600;\n");
      out.write("                color: #3a3a3a;\n");
      out.write("            }\n");
      out.write("            .login-header p {\n");
      out.write("                color: #6c757d;\n");
      out.write("            }\n");
      out.write("            .form-label {\n");
      out.write("                font-weight: 500;\n");
      out.write("                color: #495057;\n");
      out.write("            }\n");
      out.write("            .input-group-text {\n");
      out.write("                background-color: #f8f9fa;\n");
      out.write("            }\n");
      out.write("            .password-container {\n");
      out.write("                position: relative;\n");
      out.write("            }\n");
      out.write("            .password-toggle {\n");
      out.write("                position: absolute;\n");
      out.write("                right: 10px;\n");
      out.write("                top: 50%;\n");
      out.write("                transform: translateY(-50%);\n");
      out.write("                cursor: pointer;\n");
      out.write("                color: #6c757d;\n");
      out.write("                z-index: 10;\n");
      out.write("            }\n");
      out.write("            .btn-login {\n");
      out.write("                background-color: #4267B2;\n");
      out.write("                border-color: #4267B2;\n");
      out.write("                font-weight: 500;\n");
      out.write("                padding: 10px 20px;\n");
      out.write("            }\n");
      out.write("            .btn-login:hover {\n");
      out.write("                background-color: #365899;\n");
      out.write("                border-color: #365899;\n");
      out.write("            }\n");
      out.write("            .divider {\n");
      out.write("                display: flex;\n");
      out.write("                align-items: center;\n");
      out.write("                margin: 25px 0;\n");
      out.write("                color: #6c757d;\n");
      out.write("            }\n");
      out.write("            .divider::before, .divider::after {\n");
      out.write("                content: \"\";\n");
      out.write("                flex: 1;\n");
      out.write("                border-bottom: 1px solid #ced4da;\n");
      out.write("            }\n");
      out.write("            .divider::before {\n");
      out.write("                margin-right: 10px;\n");
      out.write("            }\n");
      out.write("            .divider::after {\n");
      out.write("                margin-left: 10px;\n");
      out.write("            }\n");
      out.write("            .btn-outline-secondary {\n");
      out.write("                border-color: #ced4da;\n");
      out.write("            }\n");
      out.write("            .register-link, .forgot-link {\n");
      out.write("                text-align: center;\n");
      out.write("                margin-top: 15px;\n");
      out.write("            }\n");
      out.write("            .forgot-link {\n");
      out.write("                margin-bottom: 20px;\n");
      out.write("            }\n");
      out.write("            .login-footer {\n");
      out.write("                text-align: center;\n");
      out.write("                margin-top: 25px;\n");
      out.write("                font-size: 0.9rem;\n");
      out.write("                color: #6c757d;\n");
      out.write("            }\n");
      out.write("            .alert {\n");
      out.write("                display: none;\n");
      out.write("                margin-bottom: 20px;\n");
      out.write("            }\n");
      out.write("            .loading-spinner {\n");
      out.write("                display: none;\n");
      out.write("                margin-left: 10px;\n");
      out.write("            }\n");
      out.write("            .brand-logo {\n");
      out.write("                text-align: center;\n");
      out.write("                margin-bottom: 20px;\n");
      out.write("            }\n");
      out.write("            .brand-logo img {\n");
      out.write("                height: 60px;\n");
      out.write("            }\n");
      out.write("            .soma-logo-placeholder {\n");
      out.write("                font-size: 28px;\n");
      out.write("                font-weight: bold;\n");
      out.write("                color: #4267B2;\n");
      out.write("                background: #f0f2f5;\n");
      out.write("                width: 70px;\n");
      out.write("                height: 70px;\n");
      out.write("                line-height: 70px;\n");
      out.write("                text-align: center;\n");
      out.write("                border-radius: 50%;\n");
      out.write("                margin: 0 auto 15px;\n");
      out.write("            }\n");
      out.write("        </style>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <div class=\"login-container\">\n");
      out.write("                <div class=\"brand-logo\">\n");
      out.write("                    <img src=\"images/system-logo.jpg\" alt=\"SOMA logo\" class=\"image-fluid\" width=\"50\">\n");
      out.write("                    <div class=\"soma-logo-placeholder\">SOMA</div>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"login-header\">\n");
      out.write("                    <h2>Welcome Back</h2>\n");
      out.write("                    <p>Sign in to continue to SOMA Learning Management System</p>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <!-- Conditional Message -->\n");
      out.write("                ");
      if (_jspx_meth_c_if_0(_jspx_page_context))
        return;
      out.write("\n");
      out.write("\n");
      out.write("                <form id=\"loginForm\" action=\"login\" method=\"post\" novalidate>\n");
      out.write("                    <div class=\"mb-3\">\n");
      out.write("                        <label for=\"email\" class=\"form-label\">Email Address</label>\n");
      out.write("                        <div class=\"input-group\">\n");
      out.write("                            <span class=\"input-group-text\"><i class=\"fas fa-envelope\"></i></span>\n");
      out.write("                            <input type=\"email\" class=\"form-control\" id=\"email\" name=\"email\" required \n");
      out.write("                                   placeholder=\"your.email@example.com\">\n");
      out.write("                            <div class=\"invalid-feedback\">\n");
      out.write("                                Please enter a valid email address.\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"mb-3\">\n");
      out.write("                        <label for=\"password\" class=\"form-label\">Password</label>\n");
      out.write("                        <div class=\"input-group password-container\">\n");
      out.write("                            <span class=\"input-group-text\"><i class=\"fas fa-lock\"></i></span>\n");
      out.write("                            <input type=\"password\" class=\"form-control\" id=\"password\" name=\"password\" required \n");
      out.write("                                   placeholder=\"Enter your password\">\n");
      out.write("                            <span class=\"password-toggle\" id=\"togglePassword\">\n");
      out.write("                                <i class=\"fas fa-eye\" id=\"togglePasswordIcon\"></i>\n");
      out.write("                            </span>\n");
      out.write("\n");
      out.write("                            <div class=\"invalid-feedback\">\n");
      out.write("                                Please enter your password.\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"mb-3 form-check\">\n");
      out.write("                        <input type=\"checkbox\" class=\"form-check-input\" id=\"rememberMe\" name=\"remember_me\">\n");
      out.write("                        <label class=\"form-check-label\" for=\"rememberMe\">Remember me</label>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"forgot-link\">\n");
      out.write("                        <a href=\"forgot-password.jsp\">Forgot your password?</a>\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                    <div class=\"d-grid gap-2\">\n");
      out.write("                        <button type=\"submit\" class=\"btn btn-primary btn-login\" id=\"loginBtn\">\n");
      out.write("                            Sign In\n");
      out.write("                            <span class=\"spinner-border spinner-border-sm loading-spinner\" id=\"loadingSpinner\" role=\"status\" aria-hidden=\"true\"></span>\n");
      out.write("                        </button>\n");
      out.write("                    </div>\n");
      out.write("                </form>\n");
      out.write("\n");
      out.write("                <div class=\"divider\">OR</div>\n");
      out.write("\n");
      out.write("                <div class=\"d-grid gap-2\">\n");
      out.write("                    <button type=\"button\" class=\"btn btn-outline-secondary\">\n");
      out.write("                        <i class=\"fab fa-google me-2\"></i> Sign in with Google\n");
      out.write("                    </button>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"register-link\">\n");
      out.write("                    Don't have an account? <a href=\"register.jsp\">Register now</a>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <div class=\"login-footer\">\n");
      out.write("                    SOMA LMS &copy; <span id=\"footerYear\"></span> All reserved! \n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <script>\n");
      out.write("            document.getElementById('footerYear').innerHTML = new Date().getFullYear();\n");
      out.write("\n");
      out.write("            // Show/hide password\n");
      out.write("            document.getElementById(\"togglePassword\").addEventListener(\"click\", function () {\n");
      out.write("                const passwordField = document.getElementById(\"password\");\n");
      out.write("                const icon = document.getElementById(\"togglePasswordIcon\");\n");
      out.write("                if (passwordField.type === \"password\") {\n");
      out.write("                    passwordField.type = \"text\";\n");
      out.write("                    icon.classList.remove(\"fa-eye\");\n");
      out.write("                    icon.classList.add(\"fa-eye-slash\");\n");
      out.write("                } else {\n");
      out.write("                    passwordField.type = \"password\";\n");
      out.write("                    icon.classList.remove(\"fa-eye-slash\");\n");
      out.write("                    icon.classList.add(\"fa-eye\");\n");
      out.write("                }\n");
      out.write("            });\n");
      out.write("\n");
      out.write("            // AJAX Login form submit\n");
      out.write("            document.getElementById(\"loginForm\").addEventListener(\"submit\", function (e) {\n");
      out.write("                e.preventDefault();\n");
      out.write("\n");
      out.write("                const formData = new FormData(this);\n");
      out.write("\n");
      out.write("                fetch(\"LoginServlet\", {\n");
      out.write("                    method: \"POST\",\n");
      out.write("                    body: formData\n");
      out.write("                })\n");
      out.write("                        .then(response => response.json())\n");
      out.write("                        .then(data => {\n");
      out.write("                            // Check if status and message are available\n");
      out.write("                            const status = data.status || 'error'; // Default to 'error' if not found\n");
      out.write("                            const message = data.message || 'An unexpected error occurred.';\n");
      out.write("\n");
      out.write("                            const alertBox = document.getElementById(\"login-alert\");\n");
      out.write("                            alertBox.innerHTML = '<div class=\"alert alert-' + (status === 'success' ? 'success' : 'danger') + '\" role=\"alert\">' + message + '</div>';\n");
      out.write("\n");
      out.write("                            if (status === \"success\") {\n");
      out.write("                                setTimeout(() => {\n");
      out.write("                                    window.location.href = \"verify_otp.jsp\";\n");
      out.write("                                }, 2000);\n");
      out.write("                            }\n");
      out.write("                        })\n");
      out.write("                        .catch(error => {\n");
      out.write("                            const alertBox = document.getElementById(\"login-alert\");\n");
      out.write("                            alertBox.innerHTML = '<div class=\"alert alert-danger\" role=\"alert\">Error: ' + error + '</div>';\n");
      out.write("                        });\n");
      out.write("            });\n");
      out.write("        </script>\n");
      out.write("\n");
      out.write("        <!-- JavaScript Libraries -->\n");
      out.write("        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js\"></script>\n");
      out.write("        <script src=\"https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("    </body>\n");
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

  private boolean _jspx_meth_c_if_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_0.setPageContext(_jspx_page_context);
    _jspx_th_c_if_0.setParent(null);
    _jspx_th_c_if_0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${not empty errorMessage}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_if_0 = _jspx_th_c_if_0.doStartTag();
    if (_jspx_eval_c_if_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\n");
        out.write("                    <div class=\"alert alert-danger\" role=\"alert\">\n");
        out.write("                        ");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${errorMessage}", java.lang.String.class, (PageContext)_jspx_page_context, null));
        out.write("\n");
        out.write("                    </div>\n");
        out.write("                ");
        int evalDoAfterBody = _jspx_th_c_if_0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_if_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      _jspx_tagPool_c_if_test.reuse(_jspx_th_c_if_0);
      return true;
    }
    _jspx_tagPool_c_if_test.reuse(_jspx_th_c_if_0);
    return false;
  }
}
