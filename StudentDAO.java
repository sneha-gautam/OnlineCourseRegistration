package model;
import java.sql.*;

public class StudentDAO {
    
    public boolean registerStudent(String name, String email, String password, String phone) throws Exception {
        Connection con = DBConnection.getConnection();
        String sql = "INSERT INTO students (name, email, password, phone) VALUES (?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, phone);
        int rows = ps.executeUpdate();
        con.close();
        return rows > 0;
    }
    
    public Student loginStudent(String email, String password) throws Exception {
        Connection con = DBConnection.getConnection();

        String sql = "SELECT * FROM students WHERE email=? AND password=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Student s = new Student();

            s.setId(rs.getInt("id"));
            s.setName(rs.getString("name"));
            s.setEmail(rs.getString("email"));

            // 🔥 MOST IMPORTANT LINE
            s.setRole(rs.getString("role"));

            rs.close();
            ps.close();
            con.close();

            return s;
        }

        rs.close();
        ps.close();
        con.close();

        return null;
    }
}