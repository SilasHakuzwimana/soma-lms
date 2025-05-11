/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author hakus
 */
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.File;
import java.util.Properties;

import utils.OTPGenerator;

public class EmailSenderWithOtpAttachment {

    private static final String FROM_EMAIL = "info.vaultcloud@gmail.com";
    private static final String APP_PASSWORD = "cgrf qtes ldkg rtjb"; // Google App Password

    public static void sendHtmlEmailWithAttachment(String toEmail, String subject, String htmlContent, File attachment) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            // HTML part
            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(htmlContent, "text/html");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(htmlPart);

            // Add attachment if present
            if (attachment != null && attachment.exists()) {
                MimeBodyPart attachmentPart = new MimeBodyPart();
                attachmentPart.attachFile(attachment);
                multipart.addBodyPart(attachmentPart);
            }

            message.setContent(multipart);
            Transport.send(message);
            System.out.println("✅ Email sent to " + toEmail);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String generateOtpHtml(String recipientName, String otpCode) {
        return ""
                + "<div style='font-family: Arial, sans-serif; color: #333; max-width: 600px;'>"
                + "<h2 style='color: #2c3e50;'>Your One-Time Password (OTP)</h2>"
                + "<p>Dear " + recipientName + ",</p>"
                + "<p>To complete your login or verification process on <strong>SOMA LMS</strong>, please use the following OTP:</p>"
                + "<div style='margin: 20px 0; padding: 15px; background-color: #f4f6f9; border-left: 5px solid #3498db; text-align:center;'>"
                + "  <p id='otp' style='font-size: 24px; font-weight: bold; letter-spacing: 2px; display: inline-block; color: #2c3e50;'>" + otpCode + "</p>"
                + "  <br><br>"
                + "  <a href='#' style='display:inline-block; padding:8px 16px; background:#3498db; color:#fff; text-decoration:none; border-radius:5px; font-size:14px;'"
                + "     onclick=\"navigator.clipboard.writeText('" + otpCode + "'); alert('OTP copied!'); return false;\">Copy OTP</a>"
                + "</div>"
                + "<p>This code will expire in <strong>10 minutes</strong>. If you didn’t request this, please ignore this email.</p>"
                + "<p>Thanks,<br>The SOMA LMS Team</p>"
                + "<hr style='margin-top: 30px;'>"
                + "<p style='font-size: 12px; color: #777;'>"
                + "Need help? Contact support at <a href='mailto:support@soma-lms.example.com'>support@soma-lms.example.com</a>."
                + "</p>"
                + "</div>";
    }
    
    // Example usage
    public static void main(String[] args) {
        String to = "hakuzwisilas@gmail.com";
        String subject = "SOMA LMS OTP Verification";
        String OTPCODE = OTPGenerator.generateOTP(6);
        String html = generateOtpHtml("Silas", OTPCODE);
        File attachment = new File("welcome-guide.pdf");

        sendHtmlEmailWithAttachment(to, subject, html, attachment);
    }
}
