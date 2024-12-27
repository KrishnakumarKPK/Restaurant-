<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Order</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        h3 {
            color: #4CAF50;
            text-align: center;
        }

        .error {
            color: #FF0000;
        }

        .message-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 50%;
            margin: auto;
        }

        a {
            text-decoration: none;
            color: white;
            background-color: #007BFF;
            padding: 10px 20px;
            border-radius: 5px;
            display: inline-block;
            margin-top: 20px;
            font-size: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
        }

        a:hover {
            background-color: #0056b3;
        }

        @media (max-width: 768px) {
            .message-box {
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <div class="message-box">
        <%
            String orderId = request.getParameter("order_id");
            if (orderId != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rest", "root", "");

                    String sql = "DELETE FROM orders WHERE order_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(orderId));

                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        out.println("<h3>Order deleted successfully!</h3>");
                    } else {
                        out.println("<h3 class='error'>Order not found!</h3>");
                    }

                    conn.close();
                } catch (Exception e) {
                    out.println("<h3 class='error'>Error: " + e.getMessage() + "</h3>");
                }
            } else {
                out.println("<h3 class='error'>No Order ID provided!</h3>");
            }
        %>
        <a href="admin.jsp">Back to Admin Panel</a>
    </div>
</body>
</html>
