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
import model.Book;

import java.sql.*;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    private Connection conn;

    public BookDAO(Connection conn) {
        this.conn = conn;
    }

    public int createBook(Book book) throws SQLException {
        String sql = "INSERT INTO books (title, subtitle, author, isbn, category_id, publisher, publication_year, edition, language, pages, description, cover_image, total_copies, available_copies, location, added_by, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getSubtitle());
            stmt.setString(3, book.getAuthor());
            stmt.setString(4, book.getIsbn());
            stmt.setInt(5, book.getCategoryId());
            stmt.setString(6, book.getPublisher());
            stmt.setInt(7, book.getPublicationYear());
            stmt.setString(8, book.getEdition());
            stmt.setString(9, book.getLanguage());
            stmt.setInt(10, book.getPages());
            stmt.setString(11, book.getDescription());
            stmt.setString(12, book.getCoverImage());
            stmt.setInt(13, book.getTotalCopies());
            stmt.setInt(14, book.getAvailableCopies());
            stmt.setString(15, book.getLocation());
            stmt.setInt(16, book.getAddedBy());
            stmt.setTimestamp(17, Timestamp.valueOf(book.getCreatedAt().toLocalDateTime()));
            stmt.setTimestamp(18, Timestamp.valueOf(book.getUpdatedAt().toLocalDateTime()));

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating book failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    book.setId(id); // set it in the model too if needed later
                    return id;
                } else {
                    throw new SQLException("Creating book failed, no ID obtained.");
                }
            }
        }
    }

    public Book getBookById(int id) throws SQLException {
        String sql = "SELECT * FROM books WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractBook(rs);
            }
        }
        return null;
    }

    public List<Book> getAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY created_at DESC";
        try (Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                books.add(extractBook(rs));
            }
        }
        return books;
    }

    public boolean updateBook(Book book) throws SQLException {
        String sql = "UPDATE books SET title=?, subtitle=?, author=?, isbn=?, category_id=?, publisher=?, publication_year=?, edition=?, language=?, pages=?, description=?, cover_image=?, total_copies=?, available_copies=?, location=?, added_by=?, updated_at=NOW() WHERE id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getSubtitle());
            stmt.setString(3, book.getAuthor());
            stmt.setString(4, book.getIsbn());
            stmt.setInt(5, book.getCategoryId());
            stmt.setString(6, book.getPublisher());
            stmt.setInt(7, book.getPublicationYear());
            stmt.setString(8, book.getEdition());
            stmt.setString(9, book.getLanguage());
            stmt.setInt(10, book.getPages());
            stmt.setString(11, book.getDescription());
            stmt.setString(12, book.getCoverImage());
            stmt.setInt(13, book.getTotalCopies());
            stmt.setInt(14, book.getAvailableCopies());
            stmt.setString(15, book.getLocation());
            stmt.setInt(16, book.getAddedBy());
            stmt.setInt(17, book.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteBook(int id) throws SQLException {
        String sql = "DELETE FROM books WHERE id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private Book extractBook(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("title"));
        book.setSubtitle(rs.getString("subtitle"));
        book.setAuthor(rs.getString("author"));
        book.setIsbn(rs.getString("isbn"));
        book.setCategoryId(rs.getInt("category_id"));
        book.setPublisher(rs.getString("publisher"));
        book.setPublicationYear(rs.getInt("publication_year"));
        book.setEdition(rs.getString("edition"));
        book.setLanguage(rs.getString("language"));
        book.setPages(rs.getInt("pages"));
        book.setDescription(rs.getString("description"));
        book.setCoverImage(rs.getString("cover_image"));
        book.setTotalCopies(rs.getInt("total_copies"));
        book.setAvailableCopies(rs.getInt("available_copies"));
        book.setLocation(rs.getString("location"));
        book.setAddedBy(rs.getInt("added_by"));

        ZoneId zoneId = ZoneId.of("Africa/Kigali");
        Timestamp createdAt = rs.getTimestamp("created_at");
        Timestamp updatedAt = rs.getTimestamp("updated_at");

        if (createdAt != null) {
            book.setCreatedAt(createdAt.toInstant().atZone(zoneId));
        }
        if (updatedAt != null) {
            book.setUpdatedAt(updatedAt.toInstant().atZone(zoneId));
        }
        return book;
    }
}
