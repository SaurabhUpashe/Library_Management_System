<jsp:useBean id="newUser" class="com.library.model.Users" scope="request" />
<jsp:setProperty name="newUser" property="*" />
<%@ page import="com.library.dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
  <title>User Registration</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Raleway:wght@400;700&family=Roboto&display=swap');

    :root {
      --default-font: "Roboto", sans-serif;
      --heading-font: "Raleway", sans-serif;
      --background-color: #f1f4fa;
      --default-color: #444;
      --heading-color: #273d4e;
      --accent-color: #ff4a17;
      --surface-color: rgba(255, 255, 255, 0.92);
      --contrast-color: #ffffff;
    }

    body, html {
      height: 100%;
      margin: 0;
      padding: 0;
      font-family: var(--default-font);
      overflow: hidden;
      background: url('https://wallpapers.com/images/hd/library-filled-with-books-vyy56lqa9wji657j.jpg') no-repeat center center/cover;
      backdrop-filter: blur(6px);
      -webkit-backdrop-filter: blur(6px);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .registration-page {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .registration-form {
      background-color: var(--surface-color);
      border-radius: 20px;
      padding: 50px 40px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
      width: 100%;
      max-width: 500px;
      animation: slideUp 0.8s ease forwards;
      opacity: 0;
      transform: translateY(30px);
      backdrop-filter: blur(4px);
    }

    @keyframes slideUp {
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .registration-form h2 {
      text-align: center;
      color: var(--heading-color);
      font-family: var(--heading-font);
      font-size: 32px;
      margin-bottom: 30px;
    }

    .registration-form input,
    .registration-form select {
      width: 100%;
      padding: 14px 16px;
      margin-bottom: 20px;
      border: 1px solid #ccc;
      border-radius: 10px;
      background: rgba(255, 255, 255, 0.95);
      font-size: 15px;
      transition: 0.3s ease;
      outline: none;
      box-sizing: border-box;
    }

    .registration-form input:focus,
    .registration-form select:focus {
      border-color: var(--accent-color);
      box-shadow: 0 0 6px rgba(255, 74, 23, 0.4);
    }

    .registration-form button {
      width: 100%;
      padding: 14px;
      font-size: 16px;
      background-color: var(--accent-color);
      color: var(--contrast-color);
      border: none;
      border-radius: 10px;
      cursor: pointer;
      font-weight: bold;
      transition: background-color 0.3s ease, transform 0.2s;
    }

    .registration-form button:hover {
      background-color: #e04314;
      transform: scale(1.02);
      box-shadow: 0 6px 12px rgba(255, 74, 23, 0.4);
    }

    .registration-form button:active {
      transform: scale(0.98);
    }

    /* Footer */
    footer {
      background-color: rgba(0, 0, 0, 0.6);
      color: white;
      text-align: center;
      padding: 16px;
      font-size: 14px;
    }

    footer a {
      color: #ff9a6b;
      text-decoration: none;
      margin: 0 10px;
      transition: color 0.3s ease;
    }

    footer a:hover {
      color: #ffffff;
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <section class="registration-page">
    <form class="registration-form" action="userregister.jsp" method="post">
      <h2>Create Your Account</h2>
      <input type="text" name="name" placeholder="Full Name" required />
      <input type="email" name="email" placeholder="Email" required />
      <input type="password" name="password" placeholder="Password" required />
      <select name="role" required>
        <option value="">Select Role</option>
        <option value="user">User</option>
        <option value="librarian">Librarian</option>
      </select>
      <button type="submit">Register</button>
    </form>
  </section>

  <footer>
    <p>Already have an account? <a href="userLogin.jsp">Login here</a> | <a href="index.html">Back to Home</a></p>
  </footer>

  <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
      boolean status = UserDAO.addUser(newUser);
      if (status) {
        out.print("<h2>User inserted Successfully</h2>");
        response.sendRedirect("index.html");
      } else {
        out.print("<h2>User registration failed</h2>");
      }
    }
  %>
</body>
</html>
