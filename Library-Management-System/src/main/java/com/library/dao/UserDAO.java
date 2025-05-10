package com.library.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.library.model.Users;

public class UserDAO {

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
	
	/* This method is used for new register user add in database */
	public static boolean addUser(Users user)throws Exception
	{
		boolean status = false;
		String query = "INSERT INTO users(username,email,password) VALUES (?,?,?)";
		try(Connection conn = getConnetion();PreparedStatement ps = conn.prepareStatement(query))
		{
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			int row = ps.executeUpdate();
			if(row > 0)
			{
				status = true;
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public static  boolean isValidate(Users user)
	{
		boolean status = false; 
		String query = "SELECT * FROM users WHERE email=? AND password =?";
		try(Connection conn = getConnetion();PreparedStatement ps = conn.prepareStatement(query))
		{
			ps.setString(1, user.getEmail());
			ps.setString(2, user.getPassword());
		    ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				status = true;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	
	
	/* This method return the all the Users in the database */
	public static List<Users> getAllUser()
	{
		List<Users> userInfo = new ArrayList<>();
		String query = "SELECT * FROM users";
		try(Connection conn = getConnetion(); PreparedStatement ps = conn.prepareStatement(query))
		{
				ResultSet rs = ps.executeQuery();
				while(rs.next())
				{
					Users user = new Users();
					user.setName(rs.getString("username"));
					user.setEmail(rs.getString("email"));
					userInfo.add(user);
				}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return userInfo;
	}
	
	public static String getUserNameById(int userId) {
	    String name = "";
	    String query = "SELECT name FROM users WHERE id = ?";
	    try (Connection conn = getConnetion();
	         PreparedStatement stmt = conn.prepareStatement(query)) {
	        stmt.setInt(1, userId);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            name = rs.getString("name");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return name;
	}
	
	
	public static Users getUserByEmail(String email) {
	    Users user = null;
	    String sql = "SELECT * FROM users WHERE email = ?";
	    try (Connection conn = getConnetion();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, email);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            user = new Users();
	            user.setId(rs.getInt("user_id")); 
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	            // any other fields...
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}


	

}
