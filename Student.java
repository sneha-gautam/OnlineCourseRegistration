package model;

public class Student {
    private int id;
    private String name;
    private String email;
    private String role; // 🔥 NEW FIELD

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    // 🔥 GETTER & SETTER FOR ROLE
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}