package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.dao.AdminDAO;
import com.library.model.Admin;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	Admin admin = new Admin();
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		response.getContentType();
		String action = request.getParameter("action");
		
		if("add".equals(action))
		{
			String title = request.getParameter("title");
			String author = request.getParameter("author");
			String isbn = request.getParameter("isbn");
			int year = Integer.parseInt(request.getParameter("year"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			
			try {
				AdminDAO.addBook(title,author,isbn,year,quantity);
				response.sendRedirect("Managebook.jsp");
			} catch (Exception e) {
				
				e.printStackTrace();
			}
		}
		else if("update".equals(action))
		{
			
			String title = request.getParameter("title");

		    // First time - just loading info to update
		    Admin selectedBook = AdminDAO.getBookTitle(title);

		    // If other fields are empty, just show the form pre-filled
		    if (request.getParameter("author") == null || request.getParameter("isbn") == null) {
		        request.setAttribute("selectedBook", selectedBook);
		        request.setAttribute("books", AdminDAO.getAllBooks());
		        try {
					request.getRequestDispatcher("Managebook.jsp").forward(request, response);
				} catch (ServletException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
		        return;
		    }

		    // Second time - user edited and submitted the updated form
		    String author = request.getParameter("author");
		    String isbn = request.getParameter("isbn");
		    int year = Integer.parseInt(request.getParameter("year"));
		    int quantity = Integer.parseInt(request.getParameter("quantity"));

		    Admin updatedBook = new Admin(title, author, isbn, year, quantity);
		    AdminDAO.updateBook(updatedBook);

		    // Redirect or reload with success
		    request.setAttribute("books", AdminDAO.getAllBooks());
		    request.setAttribute("message", "Book updated successfully.");
		    try {
				request.getRequestDispatcher("Managebook.jsp").forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if("delete".equals(action))
		{
			String title = request.getParameter("title");
			AdminDAO.deleteBook(title);
			response.sendRedirect("Managebook.jsp");
		}
	}

}
