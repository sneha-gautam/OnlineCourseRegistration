package model;

public class Course {
    private int id;
    private String courseName;
    private String description;
    private String duration;
    private int seatsAvailable;

    private String level;
    private int projects;
    private String certificate;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }

    public int getSeatsAvailable() { return seatsAvailable; }
    public void setSeatsAvailable(int seatsAvailable) { this.seatsAvailable = seatsAvailable; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }

    public int getProjects() { return projects; }
    public void setProjects(int projects) { this.projects = projects; }

    public String getCertificate() { return certificate; }
    public void setCertificate(String certificate) { this.certificate = certificate; }
}