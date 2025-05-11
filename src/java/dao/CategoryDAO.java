/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author hakus
 */

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import utils.DBConnection;
import model.Category;

public class CategoryDAO {

    public static List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM book_categories");
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Category cat = new Category();
                cat.setId(rs.getInt("id"));
                cat.setName(rs.getString("name"));
                categories.add(cat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }
}
