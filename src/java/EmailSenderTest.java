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
import java.util.Properties;

public class EmailSenderTest {

    public static void sendEmail(String to, String subject, String body) {
        // SMTP server configuration (Gmail in this case)
        String host = "smtp.gmail.com";
        String port = "587";
        
        //Email: hakuzwisilas@gmail.com
        //App Password: jpcq ybbn vmoh rbxg
        
        String username = "info.vaultcloud@gmail.com";
        String password = "cgrf qtes ldkg rtjb"; // Use an App Password, not your main password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true"); // TLS
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        // Create session
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Create message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(
                    Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);

            // Send email
            Transport.send(message);
            System.out.println("Email sent successfully to " + to);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    // For testing
    public static void main(String[] args) {
        sendEmail("hakuzwisilas@gmail.com", "Test Subject", "Hello from Java!");
    }
}
