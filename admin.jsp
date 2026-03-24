<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, model.RegistrationDAO, model.Student" %>

<%
    // 🔒 ADMIN ACCESS CONTROL
    Student s = (Student) session.getAttribute("student");

    if(s == null || !"admin".equals(s.getRole())){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial; background: #f4f4f4; margin: 0; }

        .navbar {
            background: #333;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 15px;
        }

        h2 { text-align: center; margin-top: 20px; }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background: #333;
            color: white;
        }

        tr:hover {
            background: #f1f1f1;
        }
    </style>
</head>

<body>

<div class="navbar">
    <span>🔐 Admin Panel</span>
    <div>
        <a href="courses">Courses</a>
        <a href="logout">Logout</a>
    </div>
</div>

<h2>📊 Admin Dashboard</h2>

<table>
<tr>
    <th>Student Name</th>
    <th>Course</th>
    <th>Date</th>
</tr>

<%
    try {
        RegistrationDAO dao = new RegistrationDAO();
        ResultSet rs = dao.getAllRegistrations();

        boolean hasData = false;

        while(rs.next()){
            hasData = true;
%>

<tr>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("course_name") %></td>
    <td><%= rs.getDate("registration_date") %></td>
</tr>

<%
        }

        if(!hasData){
%>
<tr>
    <td colspan="3">No registrations found</td>
</tr>
<%
        }

    } catch(Exception e){
        e.printStackTrace();
    }
%>

</table>

</body>
</html>