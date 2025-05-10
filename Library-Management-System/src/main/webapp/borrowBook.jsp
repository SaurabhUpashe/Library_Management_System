<%@ page import="com.library.model.Admin" %>
<%@ page import="com.library.dao.AdminDAO" %>
<%@ page import="java.util.List" %>

<%
    List<Admin> books = AdminDAO.getAllBooks();
    String userEmail = (String) session.getAttribute("userEmail");
%>

<!DOCTYPE html>
<html>
<head>

    <title>Library Catalog</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Make sure to include Font Awesome in <head> -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
 /* Body and Background */
html, body {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    display: flex;
    flex-direction: column;
    background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                url('https://c1.wallpaperflare.com/preview/127/366/443/library-book-bookshelf-read.jpg') no-repeat center center fixed;
    background-size: cover;
}

/* Make sure content takes available height */
main {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 40px 20px 40px;
}

/* Heading */
h2 {
    text-align: center;
    color: #fff;
    margin-bottom: 20px;
    font-size: 32px;
    animation: fadeIn 1s ease-in-out;
}

/* Catalog Container */
.catalog-container {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 16px;
    padding: 20px;
    backdrop-filter: blur(10px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.3);
    max-width: 1000px;
    margin-bottom: 40px;
    animation: fadeIn 1.2s ease-in-out;
    width: 100%;
}

table {
    width: 100%;
    border-collapse: collapse;
}

thead {
    background-color: rgba(255, 107, 53, 0.95);
    color: #fff;
    font-size: 16px;
    text-transform: uppercase;
}

th, td {
    padding: 16px;
    text-align: center;
    color: #fff;
    font-size: 15px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
}

tbody tr {
    transition: background-color 0.3s ease, transform 0.3s ease;
}

tbody tr:hover {
    background-color: rgba(255, 107, 53, 0.25);
    transform: scale(1.01);
    cursor: pointer;
}

/* Button Styling */
button {
    background: linear-gradient(to right, #ff6b35, #ff8e53);
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 30px;
    cursor: pointer;
    font-weight: bold;
    transition: background 0.3s ease, transform 0.2s;
}

button:hover {
    background: linear-gradient(to right, #ff8e53, #ff6b35);
    transform: scale(1.05);
}

/* Animation */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

//* Icon Color Style */
.icon-colored {
  color: #ff6b35;
  margin-right: 8px;
}

.footer-col a .icon-colored {
  color: #ffb347;
  transition: color 0.3s ease;
}

.footer-col a:hover .icon-colored {
  color: #ffffff;
}

/* Footer Styling */
.library-footer {
  width: 100%;
  background-color: rgba(0, 0, 0, 0.85);
  color: #fff;
  padding: 40px 20px 20px;
  margin-top: 40px;
  backdrop-filter: blur(8px);
}

.footer-container {
  max-width: 1200px;
  margin: auto;
}

.footer-row {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

.footer-col {
  flex: 1 1 220px;
  margin: 15px;
}

.footer-col h3 {
  font-size: 18px;
  margin-bottom: 16px;
  color: #ff6b35;
}

.footer-col p, .footer-col li, .footer-col a {
  font-size: 14px;
  line-height: 1.6;
  color: #e0e0e0;
  text-decoration: none;
}

.footer-col ul {
  list-style: none;
  padding: 0;
}

.footer-col li {
  margin-bottom: 8px;
}

.footer-col a:hover {
  color: #ffffff;
  text-decoration: underline;
}

.footer-col form {
  display: flex;
  flex-direction: column;
}

.footer-col input[type="email"] {
  padding: 10px;
  border: none;
  border-radius: 6px;
  margin-bottom: 10px;
  font-size: 14px;
}

.footer-col button {
  padding: 10px;
  border: none;
  background-color: #ff6b35;
  color: white;
  font-weight: bold;
  border-radius: 6px;
  cursor: pointer;
  transition: background 0.3s ease;
}

.footer-col button:hover {
  background-color: #e4572e;
}

.footer-bottom {
  text-align: center;
  margin-top: 30px;
  font-size: 13px;
  border-top: 1px solid rgba(255,255,255,0.1);
  padding-top: 15px;
}

/* Responsive Footer */
@media (max-width: 768px) {
  .footer-row {
    flex-direction: column;
    align-items: center;
  }

  .footer-col {
    flex: 1 1 100%;
    margin: 10px 0;
  }
}

.back-button {
    position: fixed;
    top: 20px;
    left: 20px;
    background-color: #ff6b35;
    color: white;
    padding: 10px 18px;
    border-radius: 8px;
    border: none;
    font-weight: bold;
    font-size: 14px;
    cursor: pointer;
    transition: background 0.3s ease;
    z-index: 9999;
}

.back-button:hover {
    background-color: #e4572e;
    transform: scale(1.05);
}

</style>
</head>
<body>
<button class="back-button" onclick="history.back()">
    <i class="fas fa-arrow-left"></i> Go Back
</button>
<main>
    <h2>Library Catalog</h2>

    <% String msg = request.getParameter("msg"); %>
    <% if (msg != null) { %>
        <p style="text-align:center; color: lightgreen;"><%= msg %></p>
    <% } %>

    <div class="catalog-container">
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Year</th>
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Admin book : books) { %>
                <tr>
                    <td><%= book.getTitle() %></td>
                    <td><%= book.getAuthor() %></td>
                    <td><%= book.getPublication_year() %></td>
                    <td><%= book.getQuantity() %></td>
                    <td>
                        <form action="BorrowServlet" method="post">
                            <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                            <input type="hidden" name="userEmail" value="<%= userEmail %>">
                            <button type="submit">Borrow</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</main>

<footer class="library-footer">
  <div class="footer-container">
    <div class="footer-row">

      <!-- About Library -->
      <div class="footer-col">
        <h3><i class="fas fa-info-circle icon-colored"></i> About Library</h3>
        <p>Archer Infotech</p>
        <p>Pune, Kothrud 4011038</p>
        <p><i class="fas fa-phone icon-colored"></i> +91 8483919279</p>
        <p><i class="fas fa-envelope icon-colored"></i> Archer@library.com</p>
      </div>

      <!-- Quick Links -->
      <div class="footer-col">
        <h3><i class="fas fa-link icon-colored"></i> Quick Links</h3>
        <ul>
          <li><a href="index.html"><i class="fas fa-home icon-colored"></i> Home</a></li>
          <li><a href="adminlogin.jsp"><i class="fas fa-book icon-colored"></i> Book Catalogue</a></li>
          <li><a href="#"><i class="fas fa-users icon-colored"></i> About Us</a></li>
          <li><a href="#"><i class="fas fa-file-alt icon-colored"></i> Terms of Service</a></li>
          <li><a href="#"><i class="fas fa-user-shield icon-colored"></i> Privacy Policy</a></li>
        </ul>
      </div>

      <!-- Services -->
      <div class="footer-col">
        <h3><i class="fas fa-concierge-bell icon-colored"></i> Library Services</h3>
        <ul>
          <li><a href="#"><i class="fas fa-book-reader icon-colored"></i> Book Borrowing</a></li>
          <li><a href="#"><i class="fas fa-comments icon-colored"></i> Ask a Librarian</a></li>
          <li><a href="#"><i class="fas fa-print icon-colored"></i> Printing & Scanning</a></li>
          <li><a href="#"><i class="fas fa-graduation-cap icon-colored"></i> Research Help</a></li>
          <li><a href="#"><i class="fas fa-clock icon-colored"></i> Opening Hours</a></li>
        </ul>
      </div>

      <!-- Newsletter -->
      <div class="footer-col">
        <h3><i class="fas fa-paper-plane icon-colored"></i> Newsletter</h3>
        <p>Subscribe to get the latest book arrivals & updates.</p>
        <form>
          <input type="email" placeholder="Your Email" required>
          <button type="submit"><i class="fas fa-envelope-open-text"></i> Subscribe</button>
        </form>
      </div>

    </div>

    <div class="footer-bottom">
      <p>&copy; 2025 Library Management System. All Rights Reserved.</p>
    </div>
  </div>
</footer>


</body>
</html>
