package com.library.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.library.model.Admin;


public class AdminDAO {

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
	
    // Add a new book
    public static boolean addBook(String title, String author, String isbn, int year, int quantity) {
        String query = "INSERT INTO books (title, author, isbn, publication_year, quantity) VALUES (?, ?, ?, ?,?)";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) 
        {

            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, isbn);
            ps.setInt(4, year);
            ps.setInt(5, quantity);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update book details
    public static void updateBook(Admin book) {
        String query = "UPDATE books SET title = ?, author = ?, isbn = ?, publication_year = ?, quantity = ? WHERE book_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getIsbn());
            ps.setInt(4, book.getPublication_year());
            ps.setInt(5, book.getQuantity());
            ps.setInt(6, book.getBookId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete a book
    public static void deleteBook(String title)
    {

        String sql = "DELETE FROM books WHERE title = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) 
        {
            ps.setString(1, title);
            ps.executeUpdate();
           
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get list of all books
    public static List<Admin> getAllBooks() {
        List<Admin> books = new ArrayList<>();
        String query = "SELECT * FROM books";

        try (Connection conn = getConnection();PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) 
        {

            while (rs.next()) {
                Admin book = new Admin();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setIsbn(rs.getString("isbn"));
                book.setPublication_year(rs.getInt("publication_year"));
                book.setQuantity(rs.getInt("quantity"));
                
                books.add(book);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }
    
    
    public static Admin getBookTitle(String title) {
        Admin book = null;

        String sql = "SELECT * FROM books WHERE title = ?";

        try (
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, title);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    book = new Admin(); 
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setIsbn(rs.getString("isbn"));
                    book.setPublication_year(rs.getInt("publication_year"));
                    book.setQuantity(rs.getInt("quantity"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return book;
    }
    
    public static Admin getBookById(int bookId) 
    {
        Admin book = null;
        String query = "SELECT * FROM books WHERE book_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                book = new Admin();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title")); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return book;
    }



}
