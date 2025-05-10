package com.library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.library.model.Transaction;

public class BorrowDAO {
	
	 private static final String URL = "jdbc:mysql://localhost:3306/library_management";
	 private static final String USER = "root";
	 private static final String PASSWORD = "Saurabh@123";
	 
	static
	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}
		catch(ClassNotFoundException e)
		{	
			e.printStackTrace();
		}
	}
	private static Connection getConnetion() throws SQLException
	{
		return DriverManager.getConnection(URL,USER,PASSWORD);
	}
	
	
	
	
	public static boolean borrowBook(int bookId, String userEmail) {
        String userQuery = "SELECT user_id FROM users WHERE email = ?";
        String insertQuery = "INSERT INTO transaction (user_id, book_id, borrow_date, due_date, status) " +
                             "VALUES (?, ?, NOW(), DATE_ADD(NOW(), INTERVAL 14 DAY), 'pending')";

        try (Connection conn = getConnetion();
             PreparedStatement ps = conn.prepareStatement(userQuery)) {

            ps.setString(1, userEmail);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    System.out.println("User not found for email: " + userEmail);
                    return false;
                }

                int userId = rs.getInt("user_id"); // FIXED column name

                try (PreparedStatement insert = conn.prepareStatement(insertQuery)) {
                    insert.setInt(1, userId);
                    insert.setInt(2, bookId);

                    int rows = insert.executeUpdate();
                    System.out.println("Rows inserted into transaction: " + rows);

                    return rows > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

	
	
	
	
	public static List<Transaction> getPendingRequests() {
	    List<Transaction> list = new ArrayList<>();

	    String query = "SELECT * FROM transaction WHERE status = 'pending'";
	    try (Connection conn = getConnetion();
	         PreparedStatement stmt = conn.prepareStatement(query);
	         ResultSet rs = stmt.executeQuery()) {

	    	while (rs.next()) {
				/*
				 * int transactionId = rs.getInt("transaction_id"); int userId =
				 * rs.getInt("user_id"); int bookId = rs.getInt("book_id"); Date borrowDate =
				 * rs.getDate("borrow_date"); Date dueDate = rs.getDate("due_date"); Date
				 * returnDate = rs.getDate("return_date"); String status =
				 * rs.getString("status");
				 */
	    		Transaction t = new Transaction();
	    		t.setTransactionId(rs.getInt("transaction_id"));
	            t.setUserId(rs.getInt("user_id"));
	            t.setBookId(rs.getInt("book_id"));
	            t.setBorrowDate(rs.getDate("borrow_date"));
	            t.setDueDate(rs.getDate("due_date"));
	            t.setStatus(rs.getString("status"));
	            
	            
	         // Get user name from users table
	            String userquery = "SELECT username FROM users WHERE user_id=?";
	            try(PreparedStatement ps = conn.prepareStatement(userquery))
	            {
	            	ps.setInt(1,t.getUserId());
	            	try(ResultSet userRs = ps.executeQuery())
	            	{
	            		if(userRs.next())
	            		{
	            			t.setUserName(userRs.getString("username"));
	            		}
	            	}
	            	
	            }
	            
	         // Get book title from books table
	            String bookquery  = "SELECT title FROM books WHERE book_id = ?";
	            try(PreparedStatement bookPs = conn.prepareStatement(bookquery))
	            {
	            	bookPs.setInt(1, t.getBookId());
	            	try(ResultSet bookRs = bookPs.executeQuery())
	            	{
	            		if(bookRs.next())
	            		{
	            			t.setBookName(bookRs.getString("title"));
	            		}
	            	}
	            }
	            list.add(t);
	            
	    	}

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

}
