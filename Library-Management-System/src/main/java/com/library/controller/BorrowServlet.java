package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.library.dao.BorrowDAO;

@WebServlet("/BorrowServlet")
public class BorrowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String userEmail = request.getParameter("userEmail");

        System.out.println("BorrowServlet called with bookId: " + bookId + ", userEmail: " + userEmail);

        boolean success = BorrowDAO.borrowBook(bookId, userEmail);

        if (success) {
            response.sendRedirect("borrowBook.jsp?msg=Borrowed+Successfully");
        } else {
            response.sendRedirect("borrowBook.jsp?msg=Failed+to+borrow");
        }
    }
}
