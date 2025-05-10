package com.library.controller;

import com.library.dao.TransactionDAO;
import com.library.model.Transaction;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ReturnBookServlet")
public class ReturnBookServlet extends HttpServlet {
    
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("userEmail");
        System.out.println("Session Email: " + userEmail);

        if (userEmail != null) {
            List<Transaction> approvedBooks = TransactionDAO.getApprovedTransactionsByEmail(userEmail);
            request.setAttribute("approvedBooks", approvedBooks);
            request.getRequestDispatcher("ReturnBook.jsp").forward(request, response);
        } else {
            response.sendRedirect("userLogin.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int transactionId = Integer.parseInt(request.getParameter("transactionId"));
        TransactionDAO.returnBook(transactionId);
        response.sendRedirect("ReturnBookServlet"); 
    }
}
