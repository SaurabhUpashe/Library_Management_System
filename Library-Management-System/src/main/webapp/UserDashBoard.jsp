<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<title>User Dashboard</title>
<style>
	   html, body {
		  height: 100%;
		  margin: 0;
		  padding: 0;
		  font-family: 'Segoe UI', sans-serif;
		  background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
		  display: flex;
		  flex-direction: column;
		}
		
		main {
		  flex: 1;
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  padding: 40px 20px;
		}
		
		.dashboard {
		  background: rgba(255, 255, 255, 0.2);
		  padding: 50px;
		  border-radius: 20px;
		  backdrop-filter: blur(12px);
		  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
		  text-align: center;
		  max-width: 500px;
		  width: 100%;
		  animation: fadeIn 0.8s ease;
		  transition: transform 0.3s ease;
		}
		
		.dashboard:hover {
		  transform: translateY(-5px);
		}
		
		.dashboard h1 {
		  margin-bottom: 35px;
		  color: #fff;
		  font-size: 30px;
		}
		
		/* Buttons */
		.button {
		  display: block;
		  width: 100%;
		  max-width: 300px;
		  margin: 18px auto;
		  padding: 15px;
		  border-radius: 12px;
		  font-size: 16px;
		  font-weight: bold;
		  text-align: center;
		  text-decoration: none;
		  position: relative;
		  z-index: 1;
		  overflow: hidden;
		  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
		  transition: all 0.3s ease;
		}
		
		.button::before {
		  content: '';
		  position: absolute;
		  top: 0;
		  left: -100%;
		  width: 100%;
		  height: 100%;
		  background: rgba(255, 255, 255, 0.2);
		  z-index: 0;
		  transition: left 0.4s ease;
		}
		
		.button:hover::before {
		  left: 0;
		}
		
		.button:hover {
		  transform: scale(1.05);
		}
		
		.catalog-btn {
		  background-color: #4CAF50;
		  color: white;
		}
		
		.history-btn {
		  background-color: #2196F3;
		  color: white;
		}
		
		.logout-btn {
		  background-color: #f44336;
		  color: white;
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
		
		/* Footer */
		footer {
		  background: rgba(0, 0, 0, 0.65);
		  color: #f1f1f1;
		  padding: 50px 20px 30px;
		  font-size: 15px;
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
		  gap: 30px;
		}
		
		.footer-col {
		  flex: 1 1 200px;
		  min-width: 220px;
		}
		
		.footer-col h3 {
		  margin-bottom: 20px;
		  color: #ffb347;
		  font-size: 18px;
		  font-weight: 600;
		}
		
		.footer-col p, .footer-col li {
		  margin-bottom: 10px;
		  color: #ddd;
		}
		
		.footer-col ul {
		  list-style: none;
		  padding: 0;
		}
		
		.footer-col ul li a {
		  text-decoration: none;
		  color: #ffc78e;
		  transition: color 0.3s ease;
		}
		
		.footer-col ul li a:hover {
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
		  border-radius: 8px;
		  margin-bottom: 10px;
		  outline: none;
		}
		
		.footer-col button {
		  background-color: #4CAF50;
		  color: white;
		  padding: 10px;
		  border: none;
		  border-radius: 8px;
		  cursor: pointer;
		  transition: background 0.3s ease;
		}
		
		.footer-col button:hover {
		  background-color: #45a049;
		}
		
		.footer-bottom {
		  text-align: center;
		  padding-top: 20px;
		  margin-top: 30px;
		  border-top: 1px solid rgba(255, 255, 255, 0.1);
		  color: #bbb;
		  font-size: 13px;
		}


</style>
</head>
<body>
		<main>
			<div class="dashboard">
				<h1>📚 Welcome to Your Library Dashboard</h1>
				<a href="borrowBook.jsp" class="button catalog-btn">Browse Book
					Catalog</a> <a href="ReturnBook.jsp" class="button history-btn">View
					Borrow History</a> <a href="logout" class="button logout-btn">Logout</a>
			</div>
		</main>

		<footer class="library-footer">
			<div class="footer-container">
				<div class="footer-row">
					<!-- About Library -->
					<div class="footer-col">
						<h3>About Library</h3>
						<p>Archer Infotech</p>
						<p>Pune, Kothrud 4011038</p>
						<p>
							<strong>Phone:</strong> +91 8483919279
						</p>
						<p>
							<strong>Email:</strong> Archer@library.com
						</p>
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
