<%@ page import="com.library.dao.AdminDAO" %>
<%@ page import="com.library.model.Admin" %>
<%@ page import="java.util.List" %>
<%
    List<Admin> books = AdminDAO.getAllBooks();
    Admin selectedBook = (Admin) request.getAttribute("selectedBook");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Books</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: url('https://images.unsplash.com/photo-1573496529574-be85d6a60704?auto=format&fit=crop&w=1600&q=80') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            grid-template-rows: auto auto;
            gap: 30px;
            width: 100%;
            max-width: 1200px;
        }

        .form-card {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            color: #fff;
            animation: fadeInUp 1s ease;
            transition: transform 0.3s;
        }

        .form-card:hover {
            transform: scale(1.02);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: 600;
            font-size: 24px;
            color: #fff;
        }

        form input, form select {
            width: 100%;
            padding: 12px 16px;
            margin-bottom: 15px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            background: rgba(255,255,255,0.15);
            color: #fff;
            backdrop-filter: blur(10px);
        }

        form input::placeholder {
            color: #e0e0e0;
        }

        form select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=US-ASCII,%3Csvg width='10' height='6' viewBox='0 0 10 6' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1L5 5L9 1' stroke='white' stroke-width='1.5'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
            background-size: 12px;
            color: #fff;
        }

        form button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            font-size: 15px;
            color: #fff;
            cursor: pointer;
            transition: 0.3s;
        }

        .add-form {
            background-color: rgba(20, 162, 135, 0.6);
        }

        .update-form {
            background-color: rgba(47, 128, 237, 0.6);
        }

        .delete-form {
            grid-column: span 2;
            background-color: rgba(237, 66, 100, 0.6);
        }

        .add-form button { background-color: #14a287; }
        .update-form button { background-color: #2f80ed; }
        .delete-form button { background-color: #ed4264; }

        form button:hover {
            opacity: 0.9;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .container {
                grid-template-columns: 1fr;
                grid-template-rows: auto auto auto;
            }
            .delete-form {
                grid-column: span 1;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Add Form -->
        <div class="form-card add-form">
            <h2>Add Book</h2>
            <form action="AdminServlet" method="post">
                <input type="text" name="title" placeholder="Book Title" required>
                <input type="text" name="author" placeholder="Author" required>
                <input type="text" name="isbn" placeholder="ISBN Number" required>
                <input type="number" name="year" placeholder="Publication Year" required>
                <input type="number" name="quantity" placeholder="Quantity" required>
                <button type="submit" name="action" value="add">Add Book</button>
            </form>
        </div>

        <!-- Update Form -->
        <div class="form-card update-form">
            <h2>Update Book</h2>
            <form action="AdminServlet" method="post">
                <select name="title" required>
                    <option value="" disabled <%= selectedBook == null ? "selected" : "" %>>Select Book</option>
                    <% for (Admin b : books) { %>
                        <option value="<%= b.getTitle() %>" <%= (selectedBook != null && b.getTitle().equals(selectedBook.getTitle())) ? "selected" : "" %>>
                            <%= b.getTitle() %>
                        </option>
                    <% } %>
                </select>
                <input type="text" name="author" placeholder="Author" value="<%= selectedBook != null ? selectedBook.getAuthor() : "" %>" required>
                <input type="text" name="isbn" placeholder="ISBN Number" value="<%= selectedBook != null ? selectedBook.getIsbn() : "" %>" required>
                <input type="number" name="year" placeholder="Publication Year" value="<%= selectedBook != null ? selectedBook.getPublication_year() : "" %>" required>
                <input type="number" name="quantity" placeholder="Quantity" value="<%= selectedBook != null ? selectedBook.getQuantity() : "" %>" required>
                <button type="submit" name="action" value="update">Update Book</button>
            </form>
        </div>

        <!-- Delete Form -->
        <div class="form-card delete-form">
            <h2>Delete Book</h2>
            <form action="AdminServlet" method="post">
                <select name="title" required>
                    <option value="" disabled selected>Select Book</option>
                    <% for (Admin b : books) { %>
                        <option value="<%= b.getTitle() %>"><%= b.getTitle() %></option>
                    <% } %>
                </select>
                <button type="submit" name="action" value="delete">Delete Book</button>
            </form>
        </div>
    </div>
</body>
</html>
