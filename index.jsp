<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Our Restaurant</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-top: 20px;
        }

        p {
            font-size: 18px;
            margin: 10px 0;
        }

        a {
            color: #fff;
            background-color: #4CAF50;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
        }

        a:hover {
            background-color: #45a049;
        }

        form {
            margin: 20px auto;
            padding: 20px;
            width: 50%;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            font-size: 16px;
            margin-bottom: 5px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .container {
            width: 60%;
            margin: auto;
            text-align: center;
        }

        .link-container {
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Our Restaurant</h1>

        <div class="link-container">
            <p>Click Here to <a href="/restaurant/menu.jsp">View Menu</a></p>
        </div>

        <form action="/restaurant/order_status.jsp" method="get">
            <label for="orderId">Enter Order ID:</label>
            <input type="text" id="orderId" name="order_id" placeholder="Enter your Order ID" required>
            <input type="submit" value="Check Status">
        </form>

        <div class="link-container">
            <p>Click Here to <a href="/restaurant/admin_login.jsp">Manage Orders</a></p>
        </div>
    </div>
</body>
</html>
