<%@ page import="java.util.*, com.library.dao.BorrowDAO, com.library.model.Transaction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Transaction> requests = BorrowDAO.getPendingRequests();
%>
<html>
<head>
    <title>Pending Borrow Requests</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f2f5;
            padding: 20px;
        }
        .container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ccc;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .approve {
            background-color: #28a745;
        }
        .reject {
            background-color: #dc3545;
        }
        .btn:hover {
            opacity: 0.9;
        }
        .back-button-wrapper {
		    display: flex;
		    justify-content: center;
		    margin-top: 20px;
		}
		
		.back-btn {
		    background-color: #007bff;
		    padding: 10px 25px;
		    font-size: 15px;
		    border-radius: 8px;
		    transition: background-color 0.3s ease;
		}
		
		.back-btn:hover {
		    background-color: #3295ff;
		}
        
    </style>
</head>
<body>
<div class="container">
    <h2>Pending Borrow Requests</h2>
    <table>
        <tr>
            <th>Transaction ID</th>
            <th>User Name</th>
            <th>Book Title</th>
            <th>Borrow Date</th>
            <th>Due Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <%
            for (Transaction req : requests) {
        %>
        <tr>
            <td><%= req.getTransactionId() %></td>
            <td><%= req.getUserName()  %></td>
            <td><%= req.getBookName() %></td>
            <td><%= req.getBorrowDate() %></td>
            <td><%= req.getDueDate() %></td>
            <td><%= req.getStatus() %></td>
            <td>
                <form action="ApproveRejectServlet" method="post" style="display:inline;">
                    <input type="hidden" name="transactionId" value="<%= req.getTransactionId() %>">
                    <input type="hidden" name="action" value="approve">
                    <button class="btn approve" type="submit">Approve</button>
                </form>
                <form action="ApproveRejectServlet" method="post" style="display:inline;">
                    <input type="hidden" name="transactionId" value="<%= req.getTransactionId() %>">
                    <input type="hidden" name="action" value="reject">
                    <button class="btn reject" type="submit">Reject</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>
	<div class="back-button-wrapper">
    	<button onclick="history.back()" class="btn back-btn">GoTo Back</button>
	</div>
</body>
</html>
