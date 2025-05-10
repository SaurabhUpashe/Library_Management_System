<%@ page import="java.util.List" %>
<%@ page import="com.library.model.Transaction" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    System.out.println("Session Email: " + userEmail);
    List<Transaction> approvedBooks = (List<Transaction>) request.getAttribute("approvedBooks");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Return Approved Books</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to bottom right, #eef2f3, #8e9eab);
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            padding: 20px;
            color: #2c3e50;
        }

        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 16px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:hover {
            background-color: #f2f2f2;
        }

        form {
            margin: 0;
        }

        button {
            padding: 10px 16px;
            background-color: #e67e22;
            border: none;
            color: white;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #d35400;
        }
    </style>
</head>
<body>

<h2>Your Approved Books for Return</h2>

<% if (approvedBooks != null && !approvedBooks.isEmpty()) { %>
    <table>
        <tr>
            <th>Transaction ID</th>
            <th>Book Title</th>
            <th>Borrow Date</th>
            <th>Due Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <% for (Transaction t : approvedBooks) { %>
            <tr>
                <td><%= t.getTransactionId() %></td>
                <td><%= t.getBookName() %></td>
                <td><%= t.getBorrowDate() %></td>
                <td><%= t.getDueDate() %></td>
                <td><%= t.getStatus() %></td>
                <td>
                    <form action="ReturnBookServlet" method="post">
                        <input type="hidden" name="transactionId" value="<%= t.getTransactionId() %>" />
                        <button type="submit">Return</button>
                    </form>
                </td>
            </tr>
        <% } %>
    </table>
<% } else { %>
    <p style="text-align:center; color:red; font-size:18px;">No approved books to return.</p>
<% } %>

</body>
</html>
