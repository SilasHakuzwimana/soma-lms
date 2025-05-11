/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import dao.BookDAO;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;
import utils.DBConnection;

/**
 *
 * @author hakus
 */
@WebServlet("/books/update")
public class UpdateBookServlet extends HttpServlet {

    private BookDAO bookDAO;


    public void init() {
        Connection conn = DBConnection.getConnection();
        bookDAO = new BookDAO(conn);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Book book = new Book();
            book.setId(Integer.parseInt(request.getParameter("id"))); // required
            book.setTitle(request.getParameter("title"));
            book.setSubtitle(request.getParameter("subtitle"));
            book.setAuthor(request.getParameter("author"));
            book.setIsbn(request.getParameter("isbn"));
            book.setCategoryId(Integer.parseInt(request.getParameter("category_id")));
            book.setPublisher(request.getParameter("publisher"));
            book.setPublicationYear(Integer.parseInt(request.getParameter("publication_year")));
            book.setEdition(request.getParameter("edition"));
            book.setLanguage(request.getParameter("language"));
            book.setPages(Integer.parseInt(request.getParameter("pages")));
            book.setDescription(request.getParameter("description"));
            book.setCoverImage(request.getParameter("cover_image"));
            book.setTotalCopies(Integer.parseInt(request.getParameter("total_copies")));
            book.setAvailableCopies(Integer.parseInt(request.getParameter("available_copies")));
            book.setLocation(request.getParameter("location"));
            book.setAddedBy(Integer.parseInt(request.getParameter("added_by")));

            boolean success = bookDAO.updateBook(book);
            if (success) {
                response.sendRedirect("success.jsp?updated=true&id=" + book.getId());
            } else {
                response.sendRedirect("error.jsp?reason=not_found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error updating book.");
        }
    }
}
