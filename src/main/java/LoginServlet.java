import model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        try {
            StudentDAO dao = new StudentDAO();
            Student s = dao.loginStudent(email, password);

            if (s != null) {

                // 🔥 IMPORTANT (role check)
                System.out.println("Logged in role: " + s.getRole());

                HttpSession session = req.getSession();
                session.setAttribute("student", s);

                res.sendRedirect("courses");

            } else {
                res.sendRedirect("login.jsp?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("login.jsp?error=1");
        }
    }
}