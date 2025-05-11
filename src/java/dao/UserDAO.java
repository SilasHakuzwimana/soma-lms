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
import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class UserDAO {

    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean createUser(User user) throws SQLException {
        String sql = "INSERT INTO users (reg_number, full_name, email, phone, password, role, status, profile_image, bio, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getRegNumber());
            stmt.setString(2, user.getFullName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getStatus());
            stmt.setString(8, user.getProfileImage());
            stmt.setString(9, user.getBio());
            return stmt.executeUpdate() > 0;
        }
    }

    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        }
        return null;
    }

    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
        }
        return null;
    }

    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        }
        return users;
    }

    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET reg_number=?, full_name=?, email=?, phone=?, password=?, role=?, status=?, profile_image=?, bio=?, updated_at=NOW() WHERE id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getRegNumber());
            stmt.setString(2, user.getFullName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getPassword());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getStatus());
            stmt.setString(8, user.getProfileImage());
            stmt.setString(9, user.getBio());
            stmt.setInt(10, user.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateLastLogin(int id) throws SQLException {
        String sql = "UPDATE users SET last_login = NOW() WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        ZoneId kigaliZone = ZoneId.of("Africa/Kigali");

        user.setId(rs.getInt("id"));
        user.setRegNumber(rs.getString("reg_number"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        user.setStatus(rs.getString("status"));
        user.setProfileImage(rs.getString("profile_image"));
        user.setBio(rs.getString("bio"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toInstant().atZone(kigaliZone));
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            user.setUpdatedAt(updatedAt.toInstant().atZone(kigaliZone));
        }

        Timestamp lastLogin = rs.getTimestamp("last_login");
        if (lastLogin != null) {
            user.setLastLogin(lastLogin.toInstant().atZone(kigaliZone));
        }

        return user;
    }
}
