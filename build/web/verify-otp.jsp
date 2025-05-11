<%-- 
    Document   : verify-otp
    Created on : May 10, 2025, 12:33:30 PM
    Author     : hakus
    Updated on : May 11, 2025
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>OTP Verification - SOMA LMS</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4361ee;
                --primary-hover: #3a56d4;
                --secondary-color: #3f37c9;
                --accent-color: #4cc9f0;
                --text-primary: #333333;
                --text-secondary: #6c757d;
                --bg-light: #f8f9fa;
                --bg-card: #ffffff;
                --success-color: #38b000;
                --warning-color: #ff9e00;
                --danger-color: #e5383b;
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

            .otp-container {
                max-width: 480px;
                margin: 0 auto;
                padding: 35px;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                background-color: var(--bg-card);
                position: relative;
                overflow: hidden;
                animation: fadeIn 0.6s ease-out;
            }

            .otp-container::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            }

            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .brand-logo {
                text-align: center;
                margin-bottom: 25px;
            }

            .soma-logo-placeholder {
                width: 70px;
                height: 70px;
                border-radius: 50%;
                background: linear-gradient(135deg, #e9effd, #f3f6fd);
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
                box-shadow: 0 4px 15px rgba(67, 97, 238, 0.1);
                border: 1px solid rgba(67, 97, 238, 0.1);
            }

            .soma-logo-placeholder img {
                max-width: 55px;
                height: auto;
            }

            h2 {
                font-weight: 700;
                color: var(--text-primary);
                text-align: center;
                margin-bottom: 15px;
                font-size: 1.75rem;
            }

            .subtitle {
                text-align: center;
                color: var(--text-secondary);
                font-size: 0.95rem;
                margin-bottom: 30px;
            }

            .info-text {
                background-color: #f8fafd;
                padding: 15px;
                border-radius: 10px;
                text-align: center;
                margin-bottom: 25px;
                color: var(--text-secondary);
                border: 1px solid #e9effd;
                font-size: 0.95rem;
                line-height: 1.5;
            }

            .info-text strong {
                color: var(--text-primary);
                display: block;
                margin-top: 5px;
                font-weight: 600;
            }

            .info-text i {
                color: var(--primary-color);
                margin-right: 8px;
            }

            .otp-form {
                margin-bottom: 25px;
            }

            .otp-inputs {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 25px;
            }

            .otp-input {
                width: 50px;
                height: 55px;
                text-align: center;
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-primary);
                border: 2px solid #e1e5eb;
                border-radius: 8px;
                background-color: #fff;
                transition: var(--transition);
            }

            .otp-input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
                outline: none;
            }

            .otp-input::placeholder {
                color: #ccd0d9;
            }

            .btn-verify {
                display: block;
                width: 100%;
                padding: 14px 20px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                font-size: 1rem;
                cursor: pointer;
                transition: var(--transition);
                margin-top: 15px;
            }

            .btn-verify:hover {
                background-color: var(--primary-hover);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(67, 97, 238, 0.2);
            }

            .btn-verify:active {
                transform: translateY(0);
            }

            .timer {
                background-color: #fff8e6;
                border: 1px solid #ffefc8;
                color: #d19200;
                padding: 12px;
                border-radius: 8px;
                text-align: center;
                margin-bottom: 20px;
                font-size: 0.9rem;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .timer i {
                margin-right: 8px;
                font-size: 1rem;
            }

            #countdown {
                font-weight: 700;
                margin-left: 5px;
                color: var(--warning-color);
            }

            #expiredMessage {
                background-color: #ffebee;
                border: 1px solid #ffcdd2;
                color: #c62828;
                padding: 15px;
                border-radius: 8px;
                text-align: center;
                margin-top: 20px;
                font-size: 0.9rem;
            }

            #expiredMessage a {
                color: var(--primary-color);
                font-weight: 600;
                text-decoration: none;
            }

            #expiredMessage a:hover {
                text-decoration: underline;
            }

            .back-to-login {
                text-align: center;
                margin-top: 15px;
                font-size: 0.9rem;
            }

            .back-to-login a {
                color: var(--text-secondary);
                text-decoration: none;
                transition: var(--transition);
            }

            .back-to-login a:hover {
                color: var(--text-primary);
            }

            .back-to-login i {
                margin-right: 5px;
                font-size: 0.8rem;
            }

            .alert {
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 25px;
                font-size: 0.9rem;
                display: flex;
                align-items: center;
            }

            .alert i {
                margin-right: 10px;
                font-size: 1rem;
            }

            .alert-danger {
                background-color: #ffebee;
                border-left: 4px solid var(--danger-color);
                color: #c62828;
            }

            /* Responsive styles */
            @media (max-width: 576px) {
                .otp-container {
                    padding: 25px 20px;
                }

                .otp-inputs {
                    gap: 6px;
                }

                .otp-input {
                    width: 40px;
                    height: 50px;
                    font-size: 1.25rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="otp-container">
                <div class="brand-logo">
                    <div class="soma-logo-placeholder">
                        <img src="images/system-logo.jpg" alt="SOMA LMS" class="img-fluid">
                    </div>
                </div>

                <h2>Verify Your Identity</h2>
                <p class="subtitle">Please enter the verification code sent to your email</p>

                <% if (request.getAttribute("error") != null) {%>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("error")%>
                </div>
                <% } %>

                <div class="info-text">
                    <i class="fas fa-envelope"></i> A 6-digit verification code has been sent to:
                    <% if (session.getAttribute("email") != null) {%>
                    <strong><%= session.getAttribute("email")%></strong>
                    <% } else { %>
                    <strong>Unknown Email</strong>
                    <% }%>
                </div>

                <form class="otp-form" action="verify-otp" method="post" id="otpForm">
                    <div class="otp-inputs" id="otpInputsContainer">
                        <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric" required>
                        <input type="text" class="otp-input" maxlength="1" pattern="[0-9]" inputmode="numeric" required>
                    </div>
                    <input type="hidden" name="otp" id="otpValue">
                    <button type="submit" class="btn-verify" id="verifyButton">
                        <span>Verify Code</span>
                        <span class="spinner-border spinner-border-sm ms-2" role="status" id="loadingSpinner" style="display: none;"></span>
                    </button>
                </form>

                <div class="timer" id="timer">
                    <i class="fas fa-clock"></i> Code expires in <span id="countdown">10:00</span>
                </div>

                <div class="info-text" id="expiredMessage" style="display: none;">
                    <i class="fas fa-exclamation-triangle"></i> This verification code has expired. 
                    Please <a href="login.jsp">return to login</a> and try again.
                </div>

                <div class="back-to-login">
                    <a href="login.jsp"><i class="fas fa-arrow-left"></i> Back to login</a>
                </div>
            </div>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Focus on first OTP input when page loads
                const inputs = document.querySelectorAll('.otp-input');
                const otpForm = document.getElementById('otpForm');
                const otpValue = document.getElementById('otpValue');
                const verifyButton = document.getElementById('verifyButton');
                const loadingSpinner = document.getElementById('loadingSpinner');
                const expiredMessage = document.getElementById('expiredMessage');
                const timer = document.getElementById('timer');

                if (inputs.length > 0) {
                    inputs[0].focus();
                }

                // Handle OTP input navigation and auto-submit
                inputs.forEach((input, index) => {
                    // Handle input
                    input.addEventListener('input', function (e) {
                        // Allow only numbers
                        this.value = this.value.replace(/[^0-9]/g, '');

                        // Auto-focus to next input if value is entered
                        if (this.value && index < inputs.length - 1) {
                            inputs[index + 1].focus();
                        }

                        // Combine all inputs for the hidden field
                        updateOtpValue();
                    });

                    // Handle key navigation
                    input.addEventListener('keydown', function (e) {
                        // Move to previous input on backspace if current is empty
                        if (e.key === 'Backspace' && !this.value && index > 0) {
                            inputs[index - 1].focus();
                            inputs[index - 1].select();
                        }

                        // Arrow key navigation
                        if (e.key === 'ArrowLeft' && index > 0) {
                            inputs[index - 1].focus();
                        }
                        if (e.key === 'ArrowRight' && index < inputs.length - 1) {
                            inputs[index + 1].focus();
                        }
                    });

                    // Select all text on focus
                    input.addEventListener('focus', function () {
                        this.select();
                    });
                });

                // Handle paste event to distribute characters across inputs
                document.getElementById('otpInputsContainer').addEventListener('paste', function (e) {
                    e.preventDefault();
                    const pasteData = e.clipboardData.getData('text').trim();
                    const digits = pasteData.replace(/[^0-9]/g, '').substring(0, inputs.length).split('');

                    if (digits.length > 0) {
                        digits.forEach((digit, index) => {
                            if (index < inputs.length) {
                                inputs[index].value = digit;
                            }
                        });

                        // Focus on the next empty field or last field
                        const nextEmptyIndex = digits.length < inputs.length ? digits.length : inputs.length - 1;
                        inputs[nextEmptyIndex].focus();

                        updateOtpValue();
                    }
                });

                // Update hidden OTP value field
                function updateOtpValue() {
                    let otp = '';
                    inputs.forEach(input => {
                        otp += input.value;
                    });
                    otpValue.value = otp;
                }

                // Form submission with loading indicator
                otpForm.addEventListener('submit', function (e) {
                    // Check if all inputs have values
                    let isComplete = true;
                    inputs.forEach(input => {
                        if (!input.value) {
                            isComplete = false;
                        }
                    });

                    if (!isComplete) {
                        e.preventDefault();
                        alert('Please enter all digits of the verification code');
                        return;
                    }

                    // Show loading spinner
                    verifyButton.disabled = true;
                    loadingSpinner.style.display = 'inline-block';
                });

                // OTP Timer countdown
                let timeLeft = 600; // 10 minutes
                const countdownEl = document.getElementById('countdown');

                const countdownInterval = setInterval(function () {
                    const minutes = Math.floor(timeLeft / 60);
                    let seconds = timeLeft % 60;
                    seconds = seconds < 10 ? '0' + seconds : seconds;
                    countdownEl.innerHTML = minutes + ':' + seconds;

                    timeLeft--;

                    if (timeLeft < 0) {
                        clearInterval(countdownInterval);
                        timer.style.display = 'none';
                        expiredMessage.style.display = 'block';

                        // Disable inputs and button when expired
                        inputs.forEach(input => {
                            input.disabled = true;
                        });
                        verifyButton.disabled = true;
                    }
                }, 1000);
            });
        </script>
    </body>
</html>