package com.library.model;

public class Admin {
	
	private int bookid;
	private String title;
	private String author;
	private String isbn;
	private int publication_year;
	private int quantity;
	
	public Admin() {}
	public Admin(int bookid, String title, String author, String isbn, int publication_year, int quantity) {
		super();
		this.bookid = bookid;
		this.title = title;
		this.author = author;
		this.isbn = isbn;
		this.publication_year = publication_year;
		this.quantity = quantity;
	}

	public Admin(String title2, String author2, String isbn2, int year, int quantity2){
		
	}

	public int getBookId() {
		return bookid;
	}

	public void setBookId(int bookid) {
		this.bookid = bookid;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public int getPublication_year() {
		return publication_year;
	}
	public void setPublication_year(int publication_year) {
		this.publication_year = publication_year;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
