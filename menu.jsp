<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        h3 {
            text-align: center;
            color: #666;
        }

        form {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 10px;
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

        input[type="checkbox"] {
            cursor: pointer;
        }

        input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 20px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            display: block;
            margin: auto;
        }

        button:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body style="background-image: url('https://imgs.search.brave.com/rpc5cGWXCBqp25Xt7E_J7hxwtJemHEwcCwKq7Z0qMZ4/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jbXMt/YXNzZXRzLnR1dHNw/bHVzLmNvbS9jZG4t/Y2dpL2ltYWdlL3dp/ZHRoPTg1MC91cGxv/YWRzL3VzZXJzLzI2/NTkvcG9zdHMvMjYx/NTcvaW1hZ2UtdXBs/b2FkL0Zvb2QlMjBU/cnVjayUyME1lbnUl/MjBUZW1wbGF0ZS5q/cGc'); background-size: cover; background-repeat: no-repeat;">

    <h1>Menu</h1>
    <h3>Select from the Menu:</h3>
    <form method="post" action="cart.jsp">
        <table>
            <tr>
                <th>Select</th>
                <th>Name</th>
                <th>Price</th>
                <th>Description</th>
            </tr>
            <%
                String url = "jdbc:mysql://localhost:3306/rest";
                String user = "root";
                String password = "";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(url, user, password);
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM Menu");

                    while (rs.next()) {
            %>
            <tr>
                <td><input type="checkbox" name="item" value="<%= rs.getInt("id") %>"></td>
                <td><%= rs.getString("name") %></td>
                <td>&#8377;<%= rs.getFloat("price") %></td>
                <td><%= rs.getString("description") %></td>
            </tr>
            <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<div class='error'>Error: " + e.getMessage() + "</div>");
                }
            %>
        </table>
        <input type="text" name="customer_name" placeholder="Your Name" required>
        <button type="submit">Place Order</button>
    </form>
</body>
</html>
