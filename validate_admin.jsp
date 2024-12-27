<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/rest";
    String dbUser = "root";
    String dbPassword = "";

    boolean isValid = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            isValid = true;
        }

        conn.close();
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }

    if (isValid) {
        session.setAttribute("isAdminLoggedIn", true);
        response.sendRedirect("admin.jsp");
    } else {
        response.sendRedirect("admin_login.jsp?error=true");
    }
%>
