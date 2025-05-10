<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.library.model.Users" %>
<%@ page import="com.library.dao.UserDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Table</title>
<style>
	html, body {
	  height: 100%;
	  margin: 0;
	  padding: 0;
	  display: flex;
	  flex-direction: column;
	}
	
	main {
	  flex: 1;
	  display: flex;
	  justify-content: center;
	  align-items: flex-start;
	  width: 100%;
	  padding: 60px 0 40px; /* Match your previous padding */
	}

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 60px 0 100px; /* extra bottom padding for footer */
        background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
                    url('https://c1.wallpaperflare.com/preview/127/366/443/library-book-bookshelf-read.jpg') no-repeat center center fixed;
        background-size: cover;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        min-height: 100vh;
    }

    table {
        border-collapse: collapse;
        width: 85%;
        max-width: 850px;
        background-color: rgba(255, 255, 255, 0.15);
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(12px);
        animation: fadeIn 1.2s ease-in-out;
    }

    thead {
        background-color: rgba(255, 107, 53, 0.95);
        color: #ffffff;
        text-transform: uppercase;
        font-size: 17px;
        letter-spacing: 1px;
    }

    th, td {
        padding: 16px 22px;
        text-align: left;
    }

    td {
        color: #ffffff;
        font-size: 15px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.15);
    }

    tbody tr {
        transition: background-color 0.3s ease, transform 0.3s ease;
    }

    tbody tr:hover {
        background-color: rgba(255, 107, 53, 0.3);
        transform: scale(1.01);
        cursor: pointer;
    }

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

	  /* Foooter css */
    footer {
        width: 100%;
        background-color: rgba(0, 0, 0, 0.7);
        color: #fff;
        text-align: center;
        padding: 20px 10px;
       /*  position: fixed;
        bottom: 0; */
        left: 0;
        font-size: 14px;
    }

    footer a {
        color: #ff9269;
        text-decoration: none;
        margin: 0 14px;
        transition: color 0.3s ease;
    }

    footer a:hover {
        color: #ffffff;
        text-decoration: underline;
    }

    @media (max-width: 600px) {
        table {
            width: 95%;
        }

        th, td {
            padding: 12px 14px;
        }

        footer {
            font-size: 12px;
        }

        footer a {
            display: block;
            margin: 8px 0;
        }
    }
    
	  
	  .library-footer {
	  width: 100%;
	  background-color: rgba(0, 0, 0, 0.65);
	  backdrop-filter: blur(10px);
	  color: #fff;
	  padding: 40px 20px 20px;
	  margin-top: 40px;
	  animation: fadeIn 1s ease-in-out;
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
	  color: #fff;
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
	
	/* Responsive */
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

</style>
</head>
<body>

<%
    List<Users> users = UserDAO.getAllUser();
%>
<main>
<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Email</th>
    </tr>
  </thead>
  <tbody>
    <%
      for(Users person : users){
    %>
      <tr>
        <td><%= person.getName() %></td>
        <td><%= person.getEmail() %></td>
      </tr>
    <%
      }
    %>
  </tbody>
</table>
</main>

<footer class="library-footer">
  <div class="footer-container">
    <div class="footer-row">
      <!-- About Library -->
      <div class="footer-col">
        <h3>About Library</h3>
        <p>Archer Infotech</p>
        <p>Pune, Kothrud 4011038</p>
        <p><strong>Phone:</strong> +91 8483919279</p>
        <p><strong>Email:</strong> Archer@library.com</p>
      </div>

      <!-- Quick Links -->
      <div class="footer-col">
        <h3>Quick Links</h3>
        <ul>
          <li><a href="index.html">🏠 Home</a></li>
          <li><a href="adminlogin.jsp">📖 Book Catalogue</a></li>
          <li><a href="#">🧑‍💼 About Us</a></li>
          <li><a href="#">📄 Terms of Service</a></li>
          <li><a href="#">🔐 Privacy Policy</a></li>
        </ul>
      </div>

      <!-- Services -->
      <div class="footer-col">
        <h3>Library Services</h3>
        <ul>
          <li><a href="#">📚 Book Borrowing</a></li>
          <li><a href="#">💬 Ask a Librarian</a></li>
          <li><a href="#">🖨️ Printing & Scanning</a></li>
          <li><a href="#">🎓 Research Help</a></li>
          <li><a href="#">🕓 Opening Hours</a></li>
        </ul>
      </div>

      <!-- Newsletter -->
      <div class="footer-col">
        <h3>Newsletter</h3>
        <p>Subscribe to get the latest book arrivals & updates.</p>
        <form>
          <input type="email" placeholder="Your Email" required>
          <button type="submit">Subscribe</button>
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
