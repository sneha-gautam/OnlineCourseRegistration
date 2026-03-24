<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.ResultSet, model.Student, model.RegistrationDAO" %>
<html>
<head>
    <title>My Dashboard</title>
    <style>
        body { font-family: Arial; margin: 0; background: #f0f2f5; }
        .navbar { background: #333; color: white; padding: 1rem 2rem; display: flex; justify-content: space-between; }
        .navbar a { color: white; text-decoration: none; }
        .container { max-width: 900px; margin: 2rem auto; padding: 0 1rem; }
        h2 { color: #333; }
        .card { background: white; border-radius: 10px; padding: 1.5rem; margin-bottom: 1rem; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        th { background: #333; color: white; padding: 10px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #ddd; }
        tr:hover { background: #f5f5f5; }
        .btn { padding: 8px 20px; background: #2196F3; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }
    </style>
</head>
<body>
<%
    Student student = (Student) session.getAttribute("student");
    if(student == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<div class="navbar">
    <span>Welcome, <%= student.getName() %>!</span>
    <a href="courses">Browse Courses</a>
    <a href="logout">Logout</a>
</div>
<div class="container">
    <h2>My Registered Courses</h2>
    <div class="card">
        <table>
            <tr><th>Course Name</th><th>Duration</th></tr>
            <%
                RegistrationDAO dao = new RegistrationDAO();
                ResultSet rs = dao.getMyRegistrations(student.getId());
                while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("course_name") %></td>
                <td><%= rs.getString("duration") %></td>
            </tr>
            <% } %>
        </table>
    </div>
    <a href="courses" class="btn">Browse More Courses</a>
</div>
</body>
</html>