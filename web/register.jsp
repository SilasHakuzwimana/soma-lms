<%-- 
    Document   : register
    Created on : May 10, 2025, 10:18:15 AM
    Author     : hakus
--%>

<!-- File: register.jsp -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - SOMA LMS</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/css/intlTelInput.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/register-custom.css">
</head>
<body>
    <div class="container mt-5 mb-5">
        <div class="registration-container">
            <div class="form-header">
                <h2>Student Registration</h2>
                <p>Create your account to access SOMA Learning Management System</p>
            </div>
            
            <form id="registrationForm" novalidate>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="regNumber" class="form-label">Registration Number</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                            <input type="text" class="form-control" id="regNumber" name="reg_number" required placeholder="e.g., REG2025001">
                            <div class="invalid-feedback">
                                Please provide a registration number.
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label for="fullName" class="form-label">Full Name</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="fullName" name="full_name" required placeholder="Enter your full name">
                            <div class="invalid-feedback">
                                Please provide your full name.
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control" id="email" name="email" required placeholder="your.email@example.com">
                        <div class="invalid-feedback">
                            Please provide a valid email address.
                        </div>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="tel" class="form-control" id="phone" name="phone" required>
                    <div class="invalid-feedback">
                        Please provide a valid phone number.
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group password-container">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="password" name="password" required placeholder="Create a strong password" 
                               pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$">
                        <span class="password-toggle" onclick="togglePassword('password')">
                            <i class="fas fa-eye" id="togglePasswordIcon"></i>
                        </span>
                        <div class="invalid-feedback">
                            Password must be at least 8 characters with uppercase, lowercase, number and special character.
                        </div>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <div class="input-group password-container">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="confirmPassword" required placeholder="Retype your password">
                        <span class="password-toggle" onclick="togglePassword('confirmPassword')">
                            <i class="fas fa-eye" id="toggleConfirmIcon"></i>
                        </span>
                        <div class="invalid-feedback" id="password-match-feedback">
                            Passwords do not match.
                        </div>
                    </div>
                </div>
                
                <!-- Hidden student role input -->
                <input type="hidden" name="role" value="student">
                
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="termsCheck" required>
                    <label class="form-check-label" for="termsCheck">I agree to the <a href="#">Terms and Conditions</a></label>
                    <div class="invalid-feedback">
                        You must agree to the terms and conditions.
                    </div>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-register" id="submitBtn">
                        Create Account
                        <span class="spinner-border spinner-border-sm loading-spinner" id="loadingSpinner" role="status" aria-hidden="true"></span>
                    </button>
                </div>
                
                <div class="alert" id="registration-feedback" role="alert"></div>
            </form>
            
            <div class="login-link">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
        </div>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/intlTelInput.min.js"></script>
    
    <script>
        // Initialize phone input with country codes
        var phoneInput = document.querySelector("#phone");
        var iti = window.intlTelInput(phoneInput, {
            utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/utils.js",
            separateDialCode: true,
            initialCountry: "auto",
            geoIpLookup: function(callback) {
                // In a real environment, you would use a service to get the user's location
                // For demo purposes, we'll default to US
                callback("US");
            }
        });
        
        // Toggle password visibility
        function togglePassword(fieldId) {
            const passwordField = document.getElementById(fieldId);
            const icon = fieldId === 'password' ? document.getElementById('togglePasswordIcon') : document.getElementById('toggleConfirmIcon');
            
            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                passwordField.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }
        
        // Form validation and submission
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('registrationForm');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const feedbackDiv = document.getElementById('registration-feedback');
            const submitBtn = document.getElementById('submitBtn');
            const loadingSpinner = document.getElementById('loadingSpinner');
            
            // Check if passwords match
            confirmPassword.addEventListener('input', function() {
                if (confirmPassword.value !== password.value) {
                    confirmPassword.setCustomValidity("Passwords don't match");
                } else {
                    confirmPassword.setCustomValidity('');
                }
            });
            
            // Handle form submission
            form.addEventListener('submit', function(event) {
                event.preventDefault();
                event.stopPropagation();
                
                // Add validation classes
                form.classList.add('was-validated');
                
                // Check if form is valid
                if (form.checkValidity() && password.value === confirmPassword.value) {
                    // Get full phone number with country code
                    const fullPhoneNumber = iti.getNumber();
                    
                    // Show loading spinner
                    loadingSpinner.style.display = 'inline-block';
                    submitBtn.disabled = true;
                    
                    // Prepare form data
                    const formData = {
                        reg_number: document.getElementById('regNumber').value,
                        full_name: document.getElementById('fullName').value,
                        email: document.getElementById('email').value,
                        phone: fullPhoneNumber,
                        password: password.value,
                        role: 'student'
                    };
                    
                    // Send AJAX request
                    $.ajax({
                        type: 'POST',
                        url: 'register',
                        data: formData,
                        success: function(response) {
                            // Hide loading spinner
                            loadingSpinner.style.display = 'none';
                            submitBtn.disabled = false;
                            
                            // Show success message
                            feedbackDiv.classList.remove('alert-danger');
                            feedbackDiv.classList.add('alert-success');
                            feedbackDiv.textContent = 'Registration successful! Redirecting to login page...';
                            feedbackDiv.style.display = 'block';
                            
                            // Redirect to login page after a short delay
                            setTimeout(function() {
                                window.location.href = 'login.jsp';
                            }, 2000);
                        },
                        error: function(xhr, status, error) {
                            // Hide loading spinner
                            loadingSpinner.style.display = 'none';
                            submitBtn.disabled = false;
                            
                            // Show error message
                            feedbackDiv.classList.remove('alert-success');
                            feedbackDiv.classList.add('alert-danger');
                            feedbackDiv.textContent = xhr.responseText || 'Registration failed. Please try again.';
                            feedbackDiv.style.display = 'block';
                        }
                    });
                } else {
                    // Handle invalid form
                    if (password.value !== confirmPassword.value) {
                        document.getElementById('password-match-feedback').style.display = 'block';
                    }
                }
            });
            
            // Reset form validation when inputs change
            const inputs = form.querySelectorAll('input');
            inputs.forEach(input => {
                input.addEventListener('input', function() {
                    if (form.classList.contains('was-validated')) {
                        if (this.checkValidity()) {
                            this.classList.remove('is-invalid');
                            this.classList.add('is-valid');
                        } else {
                            this.classList.remove('is-valid');
                            this.classList.add('is-invalid');
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>