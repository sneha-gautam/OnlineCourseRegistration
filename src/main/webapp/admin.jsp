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
body {
    font-family: 'Segoe UI', sans-serif;
    margin: 0;
    background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
    color: white;
}

/* NAVBAR */
.navbar {
    background: #0b1f2a;
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
}

.navbar a {
    color: #ddd;
    text-decoration: none;
    margin-left: 15px;
}

/* HEADINGS */
h2 {
    text-align: center;
    margin-top: 20px;
}

/* TABLE */
table {
    width: 85%;
    margin: 30px auto;
    border-collapse: collapse;
    background: white;
    color: black;
    border-radius: 10px;
    overflow: hidden;
}

th {
    background: #0b1f2a;
    color: white;
}

td, th {
    padding: 12px;
    text-align: center;
}

tr:hover {
    background: #f1f1f1;
}

/* STATUS COLORS */
.status-full { color: red; font-weight: bold; }
.status-low { color: orange; font-weight: bold; }
.status-ok { color: green; font-weight: bold; }

</style>
</head>

<body>

<div class="navbar">
    <span>Admin Panel</span>
    <div>
        <a href="courses">Courses</a>
        <a href="logout">Logout</a>
    </div>
</div>

<!-- 🔥 COURSE ANALYTICS -->
<h2>Course Analytics</h2>

<table>
<tr>
    <th>Course</th>
    <th>Students Enrolled</th>
    <th>Seats Left</th>
    <th>Status</th>
</tr>

<%
    try {
        RegistrationDAO dao = new RegistrationDAO();
        ResultSet rs = dao.getCourseStats();

        while(rs.next()){
            int students = rs.getInt("total_students");
            int seats = rs.getInt("seats_available");
%>

<% if(rs.isFirst()){ %>
<tr style="background: gold; font-weight: bold;">
<% } else { %>
<tr>
<% } %>
    <td><%= rs.getString("course_name") %></td>
    <td><%= students %></td>
    <td><%= seats %></td>

    <td>
        <% if(seats == 0){ %>
            <span class="status-full">Full</span>
        <% } else if(seats < 5){ %>
            <span class="status-low">Filling Fast</span>
        <% } else { %>
            <span class="status-ok">Available</span>
        <% } %>
    </td>
</tr>

<%
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>

</table>

<!-- 🔥 REGISTRATION DETAILS -->
<h2>All Registrations</h2>

<table>
<tr>
    <th>Student Name</th>
    <th>Course</th>
    <th>Date</th>
</tr>

<%
    try {
        RegistrationDAO dao = new RegistrationDAO();
        ResultSet rs2 = dao.getAllRegistrations();

        boolean hasData = false;

        while(rs2.next()){
            hasData = true;
%>

<tr>
    <td><%= rs2.getString("name") %></td>
    <td><%= rs2.getString("course_name") %></td>
    <td><%= rs2.getDate("registration_date") %></td>
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