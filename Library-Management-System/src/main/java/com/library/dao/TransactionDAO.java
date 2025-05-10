package com.library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.library.model.Admin;
import com.library.model.Transaction;

public class TransactionDAO {
	
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
	private static Connection getConnection() throws SQLException
	{
		return DriverManager.getConnection(URL,USER,PASSWORD);
	}
	
	
	
	public static boolean updateStatus(int transactionId, String updatestatus)
	{
		boolean status = false;
		String query = "UPDATE transaction SET status = ? WHERE transaction_id = ?";
		try(Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query))
		{
			ps.setString(1, updatestatus);
			ps.setInt(2, transactionId);
			int row = ps.executeUpdate();
			return row > 0;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return status;
		}
		
	}
	
	public static void updateQuantity(int bookid)
	{
		
		String query = "UPDATE books SET quantity = quantity - 1 WHERE book_id = ? AND quantity > 0";
		try(Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query))
		{
			ps.setInt(1, bookid);
			ps.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public static void incrementQuantity(int bookId)
	{
		String query = "UPDATE books SET quantity = quantity + 1 WHERE book_id = ?";
		try(Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query))
		{
			ps.setInt(1, bookId);
			ps.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public static void updateTransaction(Transaction transaction)
	{
	    String query = "UPDATE transaction SET return_date = ?, status = ? WHERE transaction_id = ?";
	    try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) 
	    {
	    	ps.setDate(1, new java.sql.Date(transaction.getReturnDate().getTime()));
	        ps.setString(2, transaction.getStatus());
	        ps.setInt(3, transaction.getTransactionId());
	        ps.executeUpdate();
	    } 
	    catch (Exception e) 
	    {
	        e.printStackTrace();
	    }
	}



	
	public static Transaction getTransactionById(int transactionId)
	{
		Transaction transaction = null;
		String query = "SELECT * FROM transaction WHERE transaction_id = ?";
		try(Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query))
		{
			ps.setInt(1, transactionId);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				transaction = new Transaction();
				transaction.setTransactionId(rs.getInt("transaction_id"));
				transaction.setUserId(rs.getInt("user_id"));
				transaction.setBookId(rs.getInt("book_id"));
				transaction.setBorrowDate(rs.getDate("borrow_date"));
				transaction.setDueDate(rs.getDate("due_date"));
				transaction.setReturnDate(rs.getDate("return_date"));
				
				transaction.setStatus(rs.getString("status"));
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return transaction;
	}
	
	
	public static int getBookById(int transcationid)
	{
		int bookid = -1 ;
		String query = "SELECT book_id from transaction WHERE transaction_id = ? AND status = 'approved'";
		try(Connection conn = getConnection() ;PreparedStatement ps = conn.prepareStatement(query))
		{
			ps.setInt(1, transcationid);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				bookid = rs.getInt("book_id"); 
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return bookid;
	}
	
	
	public static List<Transaction> getApprovedBooksByUserId(int userId)
	{
		List<Transaction> list = new ArrayList<>();
		String query = "SELECT * FROM transactions WHERE user_id = ? AND status = 'approved'";
		
		try(Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query))
		{
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				  Transaction t = new Transaction();
		            t.setTransactionId(rs.getInt("transaction_id"));
		            t.setUserId(rs.getInt("user_id"));
		            t.setBookId(rs.getInt("book_id"));
		            t.setBorrowDate(rs.getDate("borrow_date"));
		            t.setDueDate(rs.getDate("due_date"));
		            t.setStatus(rs.getString("status"));
		            
		            Admin book = AdminDAO.getBookById(t.getBookId());
		            if(book != null)
		            {
		            	t.setBookName(book.getTitle());
		            }
		            else
		            {
		            	t.setBookName("Unknown");
		            }
		            list.add(t);  
		    }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
		
	}
	
	public static List<Transaction> getApprovedTransactionsByEmail(String userEmail) {
	    List<Transaction> list = new ArrayList<>();
	    String sql = "SELECT t.*, b.title FROM transaction t " +
	                 "JOIN books b ON t.book_id = b.book_id " +
	                 "JOIN users u ON t.user_id = u.user_id " +
	                 "WHERE u.email = ? AND t.status = 'approved' AND t.return_date IS NULL";

	    try (Connection conn = getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        System.out.println("Fetching approved transactions for: " + userEmail);

	        stmt.setString(1, userEmail);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            Transaction t = new Transaction();
	            t.setTransactionId(rs.getInt("transaction_id"));
	            t.setUserId(rs.getInt("user_id"));
	            t.setBookId(rs.getInt("book_id"));
	            t.setBorrowDate(rs.getDate("borrow_date"));
	            t.setDueDate(rs.getDate("due_date"));
	            t.setStatus(rs.getString("status"));
	            t.setBookName(rs.getString("title"));
	            list.add(t);

	            System.out.println("Found: " + t.getTransactionId() + " - " + t.getBookName());
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}


	// Get book ID for a transaction
	public static int getBookIdByTransactionId(int transactionId) {
	    String sql = "SELECT book_id FROM transaction WHERE transaction_id = ?";
	    try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) 
	    {

	        ps.setInt(1, transactionId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            return rs.getInt("book_id");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // error case
	}

	// Update transaction status and return date
	public static void returnBook(int transactionId) {
	    String sql = "UPDATE transaction SET status = 'returned', return_date = CURRENT_DATE WHERE transaction_id = ?";
	    try (Connection conn = getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, transactionId);
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

}
