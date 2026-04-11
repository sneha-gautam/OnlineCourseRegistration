<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>

        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            height: 100vh;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .box {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            width: 350px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        }

        h2 {
            text-align: center;
            color: #0b1f2a;
            margin-bottom: 5px;
        }

        .subtitle {
            text-align: center;
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            padding: 10px;
            background: linear-gradient(45deg, #4CAF50, #2ecc71);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            opacity: 0.9;
        }

        .error {
            color: red;
            text-align: center;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #0b1f2a;
            font-weight: bold;
            text-decoration: none;
        }

    </style>
</head>

<body>

<div class="box">

    <h2>Smart Course Portal</h2>
    <p class="subtitle">Create your account & start learning</p>

    <% if(request.getParameter("error") != null) { %>
        <p class="error">Registration failed. Try again!</p>
    <% } %>

    <form action="register" method="post">
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="text" name="phone" placeholder="Phone Number" required>
        <button type="submit">Register</button>
    </form>

    <a href="login.jsp">Already registered? Login</a>

</div>

</body>
</html>