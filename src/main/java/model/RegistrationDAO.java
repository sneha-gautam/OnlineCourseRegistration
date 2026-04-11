package model;

import java.sql.*;

public class RegistrationDAO {

    // ✅ REGISTER COURSE
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

        // 🔍 Check seats available
        String seatCheck = "SELECT seats_available FROM courses WHERE id=?";
        PreparedStatement psSeat = con.prepareStatement(seatCheck);
        psSeat.setInt(1, courseId);
        ResultSet rsSeat = psSeat.executeQuery();

        if (rsSeat.next() && rsSeat.getInt("seats_available") <= 0) {
            rsSeat.close();
            psSeat.close();
            con.close();
            return false; // ❌ No seats left
        }

        // ✅ Insert if not enrolled
        String sql = "INSERT INTO registrations (student_id, course_id, registration_date) VALUES (?,?,CURDATE())";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, studentId);
        ps.setInt(2, courseId);

        int rows = ps.executeUpdate();

        // 🔥 decrease seats
        String updateSeats = "UPDATE courses SET seats_available = seats_available - 1 WHERE id=?";
        PreparedStatement ps2 = con.prepareStatement(updateSeats);
        ps2.setInt(1, courseId);
        ps2.executeUpdate();

        // 🔒 Close everything
        ps2.close();
        ps.close();
        psSeat.close();
        rsSeat.close();
        checkPs.close();
        con.close();

        return rows > 0;
    }

    // ✅ STUDENT VIEW
    public ResultSet getMyRegistrations(int studentId) throws Exception {
        Connection con = DBConnection.getConnection();

        String sql = "SELECT DISTINCT c.course_name, c.duration FROM registrations r " +
                     "JOIN courses c ON r.course_id = c.id WHERE r.student_id=?";
        
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, studentId);

        return ps.executeQuery();
    }

    // ✅ ADMIN: ALL REGISTRATIONS
    public ResultSet getAllRegistrations() throws Exception {
        Connection con = DBConnection.getConnection();

        String sql = "SELECT s.name, c.course_name, r.registration_date " +
                     "FROM registrations r " +
                     "JOIN students s ON r.student_id = s.id " +
                     "JOIN courses c ON r.course_id = c.id";

        PreparedStatement ps = con.prepareStatement(sql);

        return ps.executeQuery();
    }

    // 🔥 NEW: COURSE ANALYTICS (VERY IMPORTANT)
    public ResultSet getCourseStats() throws Exception {
        Connection con = DBConnection.getConnection();

        String sql = "SELECT c.course_name, COUNT(r.id) AS total_students, c.seats_available " +
                     "FROM courses c " +
                     "LEFT JOIN registrations r ON c.id = r.course_id " +
                     "GROUP BY c.id " +
                     "ORDER BY total_students DESC";

        PreparedStatement ps = con.prepareStatement(sql);

        return ps.executeQuery();
    }
}