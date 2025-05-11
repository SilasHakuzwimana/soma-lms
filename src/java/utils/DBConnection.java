/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author hakus
 */
public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/somalms";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            return DriverManager.getConnection(URL, USER, PASSWORD);
           // System.out.println("Database connected!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("DB Connection failed: " + e.getMessage());
            return null;
        }
    }
}
