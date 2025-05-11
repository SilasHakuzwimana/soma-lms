/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

/**
 *
 * @author hakus
 */
// File: utils/EmailSender.java
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class EmailSender {

    private static String FROM_EMAIL;
    private static String EMAIL_PASSWORD;
    private static String SMTP_HOST;
    private static String SMTP_PORT;

    // Static block to load properties
    static {
        try {
            Properties properties = new Properties();
            // Load properties from the config.properties file
            InputStream inputStream = EmailSender.class.getClassLoader().getResourceAsStream("config.properties");// Adjust path if needed
            if (inputStream == null) {
                throw new FileNotFoundException("config.properties not found in classpath");
            }
            properties.load(inputStream);

            // Set properties from the file
            FROM_EMAIL = properties.getProperty("email.address");
            EMAIL_PASSWORD = properties.getProperty("email.password");
            SMTP_HOST = properties.getProperty("smtp.host");
            SMTP_PORT = properties.getProperty("smtp.port");

            if (FROM_EMAIL == null || EMAIL_PASSWORD == null || SMTP_HOST == null || SMTP_PORT == null) {
                throw new IllegalStateException("Missing configuration properties.");
            }

        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Error loading properties file.");
        }
    }

    public static boolean sendEmail(String to, String subject, String content) {
        if (FROM_EMAIL == null || EMAIL_PASSWORD == null) {
            System.out.println("Error: Email credentials are missing.");
            return false;
        }

        // Set email properties for SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.debug", "true");  // Enable debug mode for SMTP communication

        // Get session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, EMAIL_PASSWORD);
            }
        });

        try {
            // Create a MimeMessage for sending email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "SOMA LMS"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=utf-8");  // For HTML content

            // Send email
            Transport.send(message);
            System.out.println("Email sent successfully to " + to);
            return true;
        } catch (Exception e) {
            System.err.println("[EmailSender] Failed to send email to " + to + ": " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Email sending failed: " + e.getMessage(), e);
        }
    }
}
