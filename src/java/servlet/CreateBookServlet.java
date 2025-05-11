package servlet;

import dao.BookDAO;
import model.Book;
import utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import java.io.*;
import java.sql.Connection;
import java.util.List;
import dao.Category;
import dao.CategoryDAO;

@WebServlet("/books/create")
@MultipartConfig
public class CreateBookServlet extends HttpServlet {

    private BookDAO bookDAO;

    public void init() {
        Connection conn = DBConnection.getConnection();
        bookDAO = new BookDAO(conn);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!ServletFileUpload.isMultipartContent(request)) {
            response.sendRedirect(request.getContextPath() + "/add-book.jsp?error=Invalid request type.");
            return;
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            List<FileItem> items = upload.parseRequest(request);
            Book book = new Book();

            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String value = item.getString("UTF-8");

                    switch (fieldName) {
                        case "title":
                            book.setTitle(value);
                            break;
                        case "subtitle":
                            book.setSubtitle(value);
                            break;
                        case "author":
                            book.setAuthor(value);
                            break;
                        case "isbn":
                            book.setIsbn(value);
                            break;
                        case "category_id":
                            book.setCategoryId(Integer.parseInt(value));
                            break;
                        case "publisher":
                            book.setPublisher(value);
                            break;
                        case "publication_year":
                            book.setPublicationYear(Integer.parseInt(value));
                            break;
                        case "edition":
                            book.setEdition(value);
                            break;
                        case "language":
                            book.setLanguage(value);
                            break;
                        case "pages":
                            book.setPages(Integer.parseInt(value));
                            break;
                        case "description":
                            book.setDescription(value);
                            break;
                        case "total_copies":
                            book.setTotalCopies(Integer.parseInt(value));
                            break;
                        case "available_copies":
                            book.setAvailableCopies(Integer.parseInt(value));
                            break;
                        case "location":
                            book.setLocation(value);
                            break;
                        case "added_by":
                            book.setAddedBy(Integer.parseInt(value));
                            break;
                    }
                } else {
                    // Process uploaded file
                    if (item.getFieldName().equals("cover_image") && !item.getName().isEmpty()) {
                        String fileName = new File(item.getName()).getName();
                        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                        String uploadPath = getServletContext().getRealPath("/") + "uploads";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        File storeFile = new File(uploadPath + File.separator + uniqueFileName);
                        item.write(storeFile);

                        // Save the relative path
                        book.setCoverImage("uploads/" + uniqueFileName);
                    }
                }
            }

            int newBookId = bookDAO.createBook(book);
            response.sendRedirect("success.jsp?book_id=" + newBookId);

        } catch (Exception e) {
            e.printStackTrace();
            String error = java.net.URLEncoder.encode("Failed to add book: " + e.getMessage(), "UTF-8");
            response.sendRedirect(request.getContextPath() + "/librarian/add-book.jsp?error=" + error);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get categories from the database
//        dao.Category categoryDAO = new dao.Category(); // or import properly if not ambiguous
//        List<dao.Category> categories = categoryDAO.getCategories();
//        request.setAttribute("categories", categories);
        List<model.Category> categoryList = CategoryDAO.getAllCategories();
        request.setAttribute("categories", categoryList);
        request.getRequestDispatcher("/librarian/add-book.jsp").forward(request, response);

        // Forward to the add book page
       // request.getRequestDispatcher("/add-book.jsp").forward(request, response);
    }

}
