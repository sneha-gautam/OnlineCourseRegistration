<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.Course, java.sql.*, model.DBConnection, model.Student" %>
<!DOCTYPE html>
<html>
<head>
<title>Available Courses</title>

<style>

body {
    font-family: 'Segoe UI', sans-serif;
    margin: 0;
    background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
}

.navbar {
    background: #0b1f2a;
    color: white;
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
}

.navbar a {
    color: #ddd;
    text-decoration: none;
    margin-left: 15px;
}

.container {
    max-width: 1000px;
    margin: 2rem auto;
}

h2 {
    text-align: center;
    font-size: 30px;
    color: #fff;
}

.container p {
    text-align: center;
    color: #ccc;
}

.course-card {
    border-radius: 15px;
    padding: 20px;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 20px;
    color: #fff;
    box-shadow: 0 6px 15px rgba(0,0,0,0.3);
    transition: 0.3s;
}

.course-card:hover {
    transform: scale(1.02);
}

.course-color-1 { background: linear-gradient(45deg, #ff7e5f, #feb47b); }
.course-color-2 { background: linear-gradient(45deg, #6a11cb, #2575fc); }
.course-color-3 { background: linear-gradient(45deg, #11998e, #38ef7d); }
.course-color-4 { background: linear-gradient(45deg, #fc466b, #3f5efb); }
.course-color-5 { background: linear-gradient(45deg, #f7971e, #ffd200); }
.course-color-6 { background: linear-gradient(45deg, #00c6ff, #0072ff); }
.course-color-7 { background: linear-gradient(45deg, #ff9966, #ff5e62); }
.course-color-8 { background: linear-gradient(45deg, #56ab2f, #a8e063); }
.course-color-9 { background: linear-gradient(45deg, #614385, #516395); }
.course-color-10 { background: linear-gradient(45deg, #e65c00, #f9d423); }

.course-img img {
    width: 130px;
    height: 90px;
    border-radius: 10px;
    object-fit: cover;
}

.course-info {
    flex: 1;
}

.course-title {
    font-size: 24px;
    font-weight: 700;
    color: #000;
    margin-bottom: 6px;
    letter-spacing: 0.5px;
}

.course-desc {
    font-size: 14px;
    color: #000 !important;
    margin: 5px 0;
}

.course-extra {
    font-size: 13px;
    color: #000 !important;
}

.course-meta {
    font-size: 13px;
    color: #000 !important;
}

button {
    padding: 8px 18px;
    background: white;
    color: #333;
    border: none;
    border-radius: 20px;
    cursor: pointer;
    font-weight: bold;
}

button:hover {
    background: #eee;
}

.disabled-btn {
    background: gray;
    color: white;
}

</style>

<script>
function handleEnroll(btn){
    btn.innerText = "Enrolling...";
    setTimeout(function(){
        btn.disabled = true;
    }, 100);
}
</script>

</head>

<body>

<div class="navbar">
    <span>Smart Course Portal</span>
    <div>
        <a href="dashboard.jsp">My Courses</a>
        <a href="admin.jsp">Admin</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">

<h2>Available Courses</h2>
<p>Explore tech courses and enhance your skills</p>

<%
Student s = (Student) session.getAttribute("student");
List<Course> courses = (List<Course>) request.getAttribute("courses");

int i = 0;

if(courses != null){
for(Course c : courses){
i++;

boolean isEnrolled = false;

try {
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
"SELECT * FROM registrations WHERE student_id=? AND course_id=?"
);
ps.setInt(1, s.getId());
ps.setInt(2, c.getId());

ResultSet rs = ps.executeQuery();
if(rs.next()) isEnrolled = true;

rs.close(); ps.close(); con.close();
} catch(Exception e){
e.printStackTrace();
}

String extra = "Hands-on learning";

if(c.getCourseName().toLowerCase().contains("java")){
extra = "Core Java, OOP, Projects";
}
else if(c.getCourseName().toLowerCase().contains("python")){
extra = "Automation, scripting, apps";
}
else if(c.getCourseName().toLowerCase().contains("web")){
extra = "Frontend + full website building";
}
else if(c.getCourseName().toLowerCase().contains("data")){
extra = "Data handling & structures";
}
%>

<div class="course-card course-color-<%= i %>">

<div class="course-img">
<img src="images/<%= c.getCourseName().toLowerCase().replace(" ", "") %>.jpg" />
</div>

<div class="course-info">
<h2 class="course-title"><%= c.getCourseName() %></h2>
<p class="course-desc"><%= c.getDescription() %></p>
<p class="course-extra"><%= extra %></p>

<p class="course-meta">
Duration: <%= c.getDuration() %> | Seats: <%= c.getSeatsAvailable() %>
</p>

<p class="course-meta">
Level: <%= c.getLevel() %> | Projects: <%= c.getProjects() %> | Certificate: <%= c.getCertificate() %>
</p>

</div>

<form action="courses" method="post">
<input type="hidden" name="courseId" value="<%= c.getId() %>">

<% if(isEnrolled){ %>
<button class="disabled-btn" disabled>Enrolled</button>
<% } else { %>
<button type="submit" onclick="handleEnroll(this)">Enroll</button>
<% } %>

</form>

</div>

<% } } %>

</div>

</body>
</html>