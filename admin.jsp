<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        h1, h3 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        table {
            width: 90%;
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

        form {
            margin: 0;
        }

        input[type="submit"], button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #0056b3;
        }

        select {
            padding: 5px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .back-home {
            text-align: center;
            margin-top: 30px;
        }

        .back-home button {
            font-size: 16px;
            padding: 10px 20px;
        }
    </style>
</head>
<body>
    <h1>Admin Panel</h1>
    <h3>Manage Orders</h3>
    <table>
        <tr>
            <th>Order ID</th>
            <th>Customer Name</th>
            <th>Items</th>
            <th>Total Price</th>
            <th>Status</th>
        </tr>
        <%
            String url = "jdbc:mysql://localhost:3306/rest";
            String user = "root";
            String password = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, user, password);
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Orders");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("order_id") %></td>
            <td><%= rs.getString("customer_name") %></td>
            <td><%= rs.getString("item_ids") %></td>
            <td>&#8377;<%= rs.getFloat("total_price") %></td>
            <td>
                <%= rs.getString("status") %>
                <form method="post" action="update_status.jsp">
                    <input type="hidden" name="order_id" value="<%= rs.getInt("order_id") %>">
                    <select name="status">
                        <option value="Pending">Pending</option>
                        <option value="Completed">Completed</option>
                    </select>
                    <input type="submit" value="Update">
                </form>
            </td>
        </tr>
        <%
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>

    <h3>Delete Orders</h3>
    <table>
        <tr>
            <th>Order ID</th>
            <th>Customer Name</th>
            <th>Total Price</th>
            <th>Action</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rest", "root", "");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT order_id, customer_name, total_price FROM orders");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("order_id") %></td>
            <td><%= rs.getString("customer_name") %></td>
            <td>&#8377;<%= rs.getDouble("total_price") %></td>
            <td>
                <form action="/restaurant/deleteorder.jsp" method="post">
                    <input type="hidden" name="order_id" value="<%= rs.getInt("order_id") %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
        </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>

    <div class="back-home">
        <form action="/restaurant/index.jsp" method="post">
            <p>To go back to the home page:</p>
            <button>Click Here</button>
        </form>
    </div>
</body>
</html>
