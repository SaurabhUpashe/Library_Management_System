package com.library.controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.dao.TransactionDAO;

@WebServlet("/ApproveRejectServlet")
public class ApproveRejectServlet  extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		int transactionid = Integer.parseInt(request.getParameter("transactionId"));
		
		int bookid = TransactionDAO.getBookById(transactionid);
		
		String action = request.getParameter("action");
		boolean result = false;
		
		if("approve".equals(action))
		{
			result = TransactionDAO.updateStatus(transactionid,"approved");
			TransactionDAO.updateQuantity(bookid);
			
		}
		else if("reject".equals(action))
		{
			result = TransactionDAO.updateStatus(transactionid,"rejected");
		}
		
		if(result)
		{
			response.sendRedirect("approveandreject.jsp");
		}
		else
		{
			response.sendRedirect("approveandreject.jsp");
		}
	}
	
}
