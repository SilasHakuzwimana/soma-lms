/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.CategoryDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hakus
 */
@WebServlet("/show-add-book")
public class ShowAddBookFormServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<model.Category> categories = CategoryDAO.getAllCategories();
        request.setAttribute("categories", categories);

        // Forward to correct JSP location
        request.getRequestDispatcher("/librarian/add-book.jsp").forward(request, response);
    }
}
