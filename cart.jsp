<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Summary</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #4CAF50;
            margin-top: 20px;
        }

        p {
            text-align: center;
            font-size: 16px;
        }

        table {
            width: 70%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        .button-container {
            text-align: center;
            margin-top: 30px;
        }

        a {
            text-decoration: none;
            color: white;
            background-color: #007BFF;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
        }

        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Order Summary</h1>
    <%
        String[] items = request.getParameterValues("item");
        String customerName = request.getParameter("customer_name");

        if (items == null || items.length == 0) {
            out.println("<p>No items selected. <a href='menu.jsp' style='color: #007BFF;'>Go back to menu</a></p>");
        } else {
            String url = "jdbc:mysql://localhost:3306/rest";
            String user = "root";
            String password = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);

                // Fetch item details
                Statement stmt = conn.createStatement();
                String itemIds = String.join(",", items);
                ResultSet rs = stmt.executeQuery("SELECT * FROM Menu WHERE id IN (" + itemIds + ")");

                float totalPrice = 0;
                out.println("<table><tr><th>Name</th><th>Price</th></tr>");
                while (rs.next()) {
                    out.println("<tr><td>" + rs.getString("name") + "</td><td>&#8377;" + rs.getFloat("price") + "</td></tr>");
                    totalPrice += rs.getFloat("price");
                }
                out.println("</table>");
                out.println("<p><strong>Total Price: &#8377;" + totalPrice + "</strong></p>");

                // Save order to database and retrieve the generated order ID
                String insertOrderSQL = "INSERT INTO Orders (customer_name, item_ids, total_price) VALUES (?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, customerName);
                pstmt.setString(2, itemIds);
                pstmt.setFloat(3, totalPrice);
                pstmt.executeUpdate();

                // Retrieve the generated order ID
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                int orderId = -1; // Default value if no ID is returned
                if (generatedKeys.next()) {
                    orderId = generatedKeys.getInt(1); // Get the generated order ID
                }

                out.println("<p>Order placed successfully! Thank you, <strong>" + customerName + "</strong>.</p>");
                if (orderId != -1) {
                    out.println("<p>Your Order ID is: <strong>" + orderId + "</strong></p>");
                    out.println("<p>Your Order Status is: <strong>Pending</strong></p>");
                }

                // Close resources
                rs.close();
                stmt.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
    <div class="button-container">
        <a href="index.jsp">Go to Home</a>
    </div>
</body>
</html>
