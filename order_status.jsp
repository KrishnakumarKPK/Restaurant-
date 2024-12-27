<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .status-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 60%;
            text-align: left;
        }

        h2 {
            text-align: center;
            color: #007BFF;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            line-height: 1.5;
            margin: 10px 0;
        }

        .error {
            color: #FF0000;
        }

        .success {
            color: #28A745;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: white;
            background-color: #007BFF;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
        }

        a:hover {
            background-color: #0056b3;
        }

        @media (max-width: 768px) {
            .status-container {
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <div class="status-container">
        <h2>Order Status</h2>
        <%
            String orderId = request.getParameter("order_id");
            if (orderId != null && !orderId.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rest", "root", "");

                    String sql = "SELECT order_id, customer_name, status, total_price FROM orders WHERE order_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(orderId));

                    ResultSet rs = pstmt.executeQuery();

                    if (rs.next()) {
        %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ page import="java.sql.ResultSet" %>
        <%
            // Ensure 'rs' is defined and populated properly in the server-side code
            // Example: ResultSet rs = statement.executeQuery("SELECT * FROM orders");
        %>
        
        <p><strong>Order ID:</strong> <%= rs.getInt("order_id") %></p>
        <p><strong>Customer Name:</strong> <%= rs.getString("customer_name") %></p>
        <p><strong>Status:</strong> 
            <span class="<%= "Completed".equalsIgnoreCase(rs.getString("status")) ? "success" : "error" %>">
                <%= rs.getString("status") %>
            </span>
        </p>
        <p><strong>Total Price:</strong> &#8377;<%= rs.getDouble("total_price") %></p>
        
        <%
                    } else {
        %>
                        <p class="error">No order found with ID: <%= orderId %></p>
        <%
                    }

                    conn.close();
                } catch (Exception e) {
        %>
                    <p class="error">Error: <%= e.getMessage() %></p>
        <%
                }
            } else {
        %>
                <p class="error">Please provide a valid Order ID.</p>
        <%
            }
        %>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>
