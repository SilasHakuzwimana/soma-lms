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
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmailSenderTestWithAttachment {

    private static final String FROM_EMAIL = "info.vaultcloud@gmail.com";
    private static String EMAIL_PASSWORD = System.getenv("EMAIL_PASSWORD"); // ✅ Use env variable

    public static void sendHtmlEmailWithAttachment(String toEmail, String subject, String htmlContent, File attachment) {
        // SMTP server settings
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Debugging: Print the environment variable
        System.out.println("EMAIL_PASSWORD: " + System.getenv("EMAIL_PASSWORD"));

        if (EMAIL_PASSWORD == null) {
            EMAIL_PASSWORD = "cgrf qtes ldkg rtjb";
            //return;
            //throw new IllegalStateException("EMAIL_PASSWORD environment variable is not set.");
        }

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, EMAIL_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

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

    // 🔧 Test it
    public static void main(String[] args) {
        String recipient = "hakuzwisilas@gmail.com";
        String subject = "Welcome to SOMA LMS";
        String html = ""
                + "<div style='font-family: Arial, sans-serif; color: #333;'>"
                + "<h2 style='color: #2c3e50;'>Hello Student,</h2>"
                + "<p>We are pleased to inform you that your SOMA LMS account has been successfully created.</p>"
                + "<p>Below are your next steps to get started:</p>"
                + "<ol>"
                + "  <li><strong>Login:</strong> Access your account using your registered email and the password sent to you.</li>"
                + "  <li><strong>Explore:</strong> Navigate through courses, materials, and assignments available to you.</li>"
                + "  <li><strong>Engage:</strong> Stay connected with your instructors and fellow students through the platform.</li>"
                + "</ol>"
                + "<p style='margin-top: 20px;'>Click below to access SOMA LMS:</p>"
                + "<p><a href='https://soma-lms.example.com' "
                + "style='display: inline-block; padding: 10px 15px; background-color: #3498db; color: white; text-decoration: none; border-radius: 5px;'>Go to SOMA LMS</a></p>"
                + "<hr style='margin-top: 30px;'>"
                + "<p style='font-size: 12px; color: #777;'>"
                + "If you have any questions, feel free to contact our support team at <a href='mailto:support@soma-lms.example.com'>support@soma-lms.example.com</a>."
                + "</p>"
                + "</div>";
        File attachment = new File("welcome-guide.pdf");

        sendHtmlEmailWithAttachment(recipient, subject, html, attachment);
    }
}
