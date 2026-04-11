import model.Course;
import model.DBConnection;
import java.sql.*;
import java.util.*;

public class CourseDAO {
    
    public List<Course> getAllCourses() throws Exception {
        Connection con = DBConnection.getConnection();
        List<Course> list = new ArrayList<>();

        String sql = "SELECT * FROM courses";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(sql);

        while (rs.next()) {
            Course c = new Course();

            c.setId(rs.getInt("id"));
            c.setCourseName(rs.getString("course_name"));
            c.setDescription(rs.getString("description"));
            c.setDuration(rs.getString("duration"));
            c.setSeatsAvailable(rs.getInt("seats_available"));

            c.setLevel(rs.getString("level"));
            c.setProjects(rs.getInt("projects"));
            c.setCertificate(rs.getString("certificate"));

            list.add(c);
        }

        rs.close();
        st.close();
        con.close();

        return list;
    }
}