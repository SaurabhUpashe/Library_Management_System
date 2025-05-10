<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>

<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>
<style>
/* === REUSE YOUR EXISTING CSS === */
:root {
  --default-font: "Roboto", system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", "Liberation Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
  --heading-font: "Raleway", sans-serif;
  --nav-font: "Inter", sans-serif;

  --background-color: #ffffff;
  --default-color: #444444;
  --heading-color: #273d4e;
  --accent-color: #ff4a17;
  --surface-color: #ffffff;
  --contrast-color: #ffffff;

  --nav-color: #e5eaee;
  --nav-hover-color: #ff4a17;
  --nav-mobile-background-color: #ffffff;
  --nav-dropdown-background-color: #ffffff;
  --nav-dropdown-color: #444444;
  --nav-dropdown-hover-color: #ff4a17;

  scroll-behavior: smooth;
}

.light-background {
  --background-color: #f1f4fa;
  --surface-color: #ffffff;
}

.registration-page {
  background: var(--background-color) url('https://images.pexels.com/photos/877971/pexels-photo-877971.jpeg?cs=srgb&dl=pexels-juanpphotoandvideo-877971.jpg&fm=jpg') no-repeat center center / cover;
  backdrop-filter: blur(6px);
  -webkit-backdrop-filter: blur(6px);
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  position: relative;
  padding: 0;
  margin: 0;
}

.registration-form {
  background-color: var(--surface-color);
  border-radius: 16px;
  padding: 40px 30px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  width: 100%;
  max-width: 480px;
  z-index: 1;
}

.registration-form h2 {
  text-align: center;
  color: var(--heading-color);
  font-family: var(--heading-font);
  font-size: 26px;
  margin-bottom: 20px;
}

.registration-form input {
  width: 94%;
  padding: 12px 14px;
  margin-bottom: 18px;
  border: 1px solid #ccc;
  border-radius: 8px;
  background: #f9f9f9;
  font-size: 15px;
  outline: none;
  transition: border-color 0.3s;
}

.registration-form input:focus {
  border-color: var(--accent-color);
}

.registration-form button {
  width: 100%;
  padding: 12px;
  font-size: 15px;
  margin-bottom: 18px;
  background-color: var(--accent-color);
  color: var(--contrast-color);
  border: none;
  border-radius: 8px;
  cursor: pointer;
  font-weight: bold;
  transition: background-color 0.3s ease;
}

.registration-form button:hover {
  background-color: color-mix(in srgb, var(--accent-color), transparent 20%);
}

body,
html {
  height: 100%;
  margin: 0;
  padding: 0;
  overflow: hidden;
}
</style>
</head>
 <body class="light-background">

<%
    HttpSession s = request.getSession();

	if("POST".equalsIgnoreCase(request.getMethod()))
	{	
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		if("saurabhupashe@gmail.com".equals(email) && "1234".equals(password))
		{
			s.setAttribute("librarian",email);
			response.sendRedirect("adminlogin.jsp");
			return;
		}
		else
		{
			out.println("<script>alert('Invalid Librarian credentials');</scripts>");
		}
	}
	
	String librarianEmail = (String) session.getAttribute("librarian");
%>

<% if (librarianEmail == null) { %>
    <!-- Show Login Form -->
    <section class="registration-page">
        <form class="registration-form" method="post" action="adminlogin.jsp">
            <h2>Admin Login</h2>
            <input type="text" name="email" placeholder="Admin Email" required />
            <input type="password" name="password" placeholder="Password" required />
            <button type="submit">Login</button>
        </form>
    </section>
<% } else { %>
    <!-- Admin Dashboard -->
    <section class="registration-page">
        <div class="registration-form">
            <h2>Welcome, Admin</h2>
            <form action="Managebook.jsp" method="get">
                <button type="submit">📚 Manage Book Inventory</button>
            </form>
            <form action="ViewUsers.jsp" method="get">
                <button type="submit">👥 View Registered Users</button>
            </form>
            <form action="approveandreject.jsp" method="get">
                <button type="submit">✅ Approve / Reject Requests</button>
            </form>
            <form action="TransactionHistory.jsp" method="get">
                <button type="submit">📖 Transaction History</button>
            </form>
            <form action="AdminLogout.jsp" method="post">
                <button type="submit">🚪 Logout</button>
            </form>
        </div>
    </section>
<% } %>

</body>
</html>
