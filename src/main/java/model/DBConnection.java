package model;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    static final String URL = "jdbc:mysql://localhost:3306/course_db";
    static final String USER = "root";
    static final String PASS = "Himalaya@67";
    
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}