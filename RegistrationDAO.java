package model;

import java.sql.*;

public class RegistrationDAO {

    public boolean registerCourse(int studentId, int courseId) throws Exception {
        Connection con = DBConnection.getConnection();

        // 🔍 Check if already enrolled
        String checkSql = "SELECT * FROM registrations WHERE student_id=? AND course_id=?";
        PreparedStatement checkPs = con.prepareStatement(checkSql);
        checkPs.setInt(1, studentId);
        checkPs.setInt(2, courseId);

        ResultSet rs = checkPs.executeQuery();

        if (rs.next()) {
            rs.close();
            checkPs.close();
            con.close();
            return false; // ❌ Already enrolled
        }

        // ✅ Insert if not enrolled
        String sql = "INSERT INTO registrations (student_id, course_id, registration_date) VALUES (?,?,CURDATE())";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, studentId);
        ps.setInt(2, courseId);

        int rows = ps.executeUpdate();

        // 🔥 decrease seats
        String updateSeats = "UPDATE courses SET seats_available = seats_available - 1 WHERE id=? AND seats_available > 0";
        PreparedStatement ps2 = con.prepareStatement(updateSeats);
        ps2.setInt(1, courseId);
        ps2.executeUpdate();

        // 🔒 Close everything properly
        ps2.close();
        ps.close();
        checkPs.close();
        con.close();

        return rows > 0;
    }

    public ResultSet getMyRegistrations(int studentId) throws Exception {
        Connection con = DBConnection.getConnection();

        String sql = "SELECT DISTINCT c.course_name, c.duration FROM registrations r " +
                     "JOIN courses c ON r.course_id = c.id WHERE r.student_id=?";
        
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, studentId);

        return ps.executeQuery();
    }

    // 🔥 NEW METHOD (ADMIN VIEW)
    public ResultSet getAllRegistrations() throws Exception {
        Connection con = DBConnection.getConnection();

        String sql = "SELECT s.name, c.course_name, r.registration_date " +
                     "FROM registrations r " +
                     "JOIN students s ON r.student_id = s.id " +
                     "JOIN courses c ON r.course_id = c.id";

        PreparedStatement ps = con.prepareStatement(sql);

        return ps.executeQuery();
    }
}