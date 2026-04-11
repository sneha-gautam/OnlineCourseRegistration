import model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.util.*;

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        try {
            CourseDAO dao = new CourseDAO();
            List<Course> courses = dao.getAllCourses();
            req.setAttribute("courses", courses);

            // ✅ forward to JSP
            req.getRequestDispatcher("courses.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        Student s = (Student) session.getAttribute("student");

        if(s == null){
            res.sendRedirect("login.jsp");
            return;
        }

        int courseId = Integer.parseInt(req.getParameter("courseId"));
        
        try {
            RegistrationDAO dao = new RegistrationDAO();

            boolean success = dao.registerCourse(s.getId(), courseId);

            if(success){
                session.setAttribute("msg", "Course Enrolled Successfully!");
            } else {
                session.setAttribute("msg", "Already Enrolled in this Course!");
            }

            res.sendRedirect("courses");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("msg", "Something went wrong!");
            res.sendRedirect("courses");
        }
    }      
    
}