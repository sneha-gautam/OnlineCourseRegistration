<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.Course, java.sql.*, model.DBConnection, model.Student" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Courses</title>
    <style>
        body { font-family: Arial; margin: 0; background: #f0f2f5; }

        .navbar {
            background: #333;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
        }

        .navbar a { color: white; text-decoration: none; margin-left: 15px; }

        .container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        h2 { text-align: center; }

        .msg-success { color: green; text-align: center; }
        .msg-error { color: red; text-align: center; }

        .course-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 3px 8px rgba(0,0,0,0.15);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: 0.3s;
        }

        .course-card:hover {
            transform: scale(1.03);
        }

        .course-info h3 {
            margin: 0 0 8px;
            font-size: 18px;
        }

        .tag {
            background: #eee;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            display: inline-block;
            margin-bottom: 6px;
        }

        .highlight {
            color: red;
            font-weight: bold;
        }

        button {
            padding: 8px 20px;
            background: linear-gradient(45deg, #4CAF50, #2ecc71);
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }

        button:hover { opacity: 0.9; }
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
    <span>🎓 Smart Course Portal</span>
    <div>
        <a href="dashboard.jsp">My Courses</a>
        <a href="admin.jsp">Admin</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">

    <h2>🚀 Available Courses</h2>

    <p style="text-align:center; color:#666;">
        Learn new skills & boost your career 💡
    </p>

    <% if(request.getParameter("success") != null) { %>
        <p class="msg-success">✅ Successfully enrolled!</p>
    <% } %>

    <% if(request.getParameter("already") != null) { %>
        <p class="msg-error">⚠ Already enrolled!</p>
    <% } %>

    <% if(request.getParameter("error") != null) { %>
        <p class="msg-error">❌ Something went wrong!</p>
    <% } %>

    <%
        Student s = (Student) session.getAttribute("student");

        List<Course> courses = (List<Course>) request.getAttribute("courses");
        if(courses != null) {
            for(Course c : courses) {

                // 🔥 CHECK IF ALREADY ENROLLED
                boolean isEnrolled = false;
                try {
                    Connection con = DBConnection.getConnection();
                    String sql = "SELECT * FROM registrations WHERE student_id=? AND course_id=?";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setInt(1, s.getId());
                    ps.setInt(2, c.getId());

                    ResultSet rs = ps.executeQuery();
                    if(rs.next()){
                        isEnrolled = true;
                    }

                    rs.close();
                    ps.close();
                    con.close();
                } catch(Exception e){
                    e.printStackTrace();
                }

                String name = c.getCourseName().toLowerCase();
                String category = "General";
                String emoji = "📘";

                if(name.contains("java") || name.contains("python") || name.contains("web")) {
                    category = "Programming";
                    emoji = "💻";
                } else if(name.contains("machine") || name.contains("data")) {
                    category = "AI / Data";
                    emoji = "🤖";
                } else if(name.contains("android")) {
                    category = "Mobile Dev";
                    emoji = "📱";
                } else if(name.contains("design") || name.contains("ui")) {
                    category = "Design";
                    emoji = "🎨";
                } else if(name.contains("security")) {
                    category = "Security";
                    emoji = "🔐";
                }
    %>

    <div class="course-card">
        <div class="course-info">
            <h3><%= emoji %> <%= c.getCourseName() %></h3>

            <p class="tag">Category: <%= category %></p>

            <p><%= c.getDescription() %></p>

            <p>
                ⏳ Duration: <%= c.getDuration() %> |
                🎯 Seats: <%= c.getSeatsAvailable() %>

                <% if(c.getSeatsAvailable() < 10){ %>
                    <span class="highlight">🔥 Filling Fast!</span>
                <% } %>
            </p>
        </div>

        <form action="courses" method="post">
            <input type="hidden" name="courseId" value="<%= c.getId() %>">

            <% if(isEnrolled){ %>
                <button disabled style="background:gray;">
                    ✔ Enrolled
                </button>
            <% } else { %>
                <button type="submit" onclick="handleEnroll(this)">
                    🚀 Enroll
                </button>
            <% } %>
        </form>
    </div>

    <% } } %>

</div>

</body>
</html>