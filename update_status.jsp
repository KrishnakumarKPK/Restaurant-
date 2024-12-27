<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Order Status</title>
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
            text-align: center;
            width: 60%;
        }

        h2 {
            color: #007BFF;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            line-height: 1.5;
            margin: 10px 0;
        }

        .success {
            color: #28A745;
            font-weight: bold;
        }

        .error {
            color: #FF0000;
            font-weight: bold;
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
        <h2>Update Order Status</h2>
        <%
            int orderId = Integer.parseInt(request.getParameter("order_id"));
            String status = request.getParameter("status");

            String url = "jdbc:mysql://localhost:3306/rest";
            String user = "root";
            String password = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);

                PreparedStatement pstmt = conn.prepareStatement("UPDATE Orders SET status = ? WHERE order_id = ?");
                pstmt.setString(1, status);
                pstmt.setInt(2, orderId);
                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<p class='success'>Status updated successfully!</p>");
                } else {
                    out.println("<p class='error'>Error: Order ID not found.</p>");
                }

                conn.close();
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            }
        %>
        <a href="admin.jsp">Back to Admin Panel</a>
    </div>
</body>
</html>
