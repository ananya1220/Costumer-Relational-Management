<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.task_management_system.model.Tasks"%>
<%@page import="jakarta.servlet.http.HttpSession"%>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("username") == null) {
        response.sendRedirect("index.html");
        return;
    }
    String username = (String) userSession.getAttribute("username");
    List<Tasks> tasks = (List<Tasks>) userSession.getAttribute("tasks");
    if (tasks == null) {
        tasks = new java.util.ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>CRM Dashboard</title>
</head>
<body style="
    margin: 0;
    padding: 0;
    background-image: url('https://img.freepik.com/free-vector/background-realistic-abstract-technology-particle_23-2148431735.jpg?semt=ais_country_boost&w=740');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: #fff;
">

<div class="container" style="
    background: linear-gradient(135deg, rgba(173, 216, 230, 0.4), rgba(135, 206, 250, 0.4));
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0px 12px 24px rgba(0, 0, 0, 0.4);
    width: 90%;
    max-width: 900px;
    color: #fff;
">
    <h2 style="text-align:center; font-size: 28px;">Welcome, <%= username %>!</h2>
    <h3 style="text-align:center; font-size: 22px; margin-bottom: 20px;">Customer Relationship Management Dashboard</h3>

    <!-- Add Task -->
    <form id="addTaskForm" onsubmit="addTask(event)" style="margin-bottom: 30px; text-align: center;">
        <input type="hidden" name="action" value="addTask">
        <input type="text" name="title" placeholder="Title (Customer Name)" required style="width: 25%; padding: 10px; border-radius: 8px; border: none; margin: 5px;">
        <input type="text" name="description" placeholder="Email (e.g. john@example.com)" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required style="width: 30%; padding: 10px; border-radius: 8px; border: none; margin: 5px;">
        <input type="text" name="category" placeholder="Phone Number" required style="width: 20%; padding: 10px; border-radius: 8px; border: none; margin: 5px;">
        <button type="submit" style="
            padding: 10px 20px;
            background: linear-gradient(to right, #d0bdf4, #8093f1);
            border: none;
            border-radius: 8px;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s ease;
        " onmouseover="this.style.background='linear-gradient(to right, #7b6fdc, #5c5edc)'" onmouseout="this.style.background='linear-gradient(to right, #d0bdf4, #8093f1)'">Add Costumer</button>
    </form>

    <!-- Task Table -->
    <table style="width: 100%; border-collapse: collapse; background-color: rgba(255,255,255,0.1); color: #fff; border-radius: 8px; overflow: hidden;">
        <thead>
            <tr style="background: rgba(0, 0, 0, 0.2);">
                <th style="padding: 12px;">ID</th>
                <th style="padding: 12px;">Name</th>
                <th style="padding: 12px;">Email</th>
                <th style="padding: 12px;">Phone</th>
                <th style="padding: 12px;">Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Tasks task : tasks) { %>
            <tr style="text-align: center;">
                <td><%= task.getId() %></td>
                <td><%= task.getTitle() %></td>
                <td><%= task.getDescription() %></td>
                <td><%= task.getCategory() %></td>
                <td style="display: flex; flex-direction: column; gap: 5px; align-items: center; padding: 10px;">
                    <!-- Update -->
                    <form onsubmit="updateTask(event)">
                        <input type="hidden" name="action" value="updateTask">
                        <input type="hidden" name="id" value="<%= task.getId() %>">
                        <input type="text" name="title" placeholder="New Name" required style="margin: 3px; padding: 5px; border-radius: 5px;">
                        <input type="text" name="description" placeholder="New Email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required style="margin: 3px; padding: 5px; border-radius: 5px;">
                        <input type="text" name="category" placeholder="New Phone" required style="margin: 3px; padding: 5px; border-radius: 5px;">
                        <button type="submit" style="
                            padding: 5px 10px;
                            background: linear-gradient(to right, #b388eb, #8093f1);
                            color: white;
                            border: none;
                            border-radius: 5px;
                            cursor: pointer;
                        " onmouseover="this.style.background='linear-gradient(to right, #7b6fdc, #5c5edc)'" onmouseout="this.style.background='linear-gradient(to right, #b388eb, #8093f1)'">Update</button>
                    </form>

                    <!-- Delete -->
                    <form onsubmit="deleteTask(event)">
                        <input type="hidden" name="action" value="deleteTask">
                        <input type="hidden" name="id" value="<%= task.getId() %>">
                        <button type="submit" style="
                            padding: 5px 10px;
                            background: linear-gradient(to right, #ff6b6b, #ff5252);
                            color: white;
                            border: none;
                            border-radius: 5px;
                            cursor: pointer;
                        " onmouseover="this.style.background='linear-gradient(to right, #e53935, #c62828)'" onmouseout="this.style.background='linear-gradient(to right, #ff6b6b, #ff5252)'">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <!-- Logout -->
    <form action="NewServlet" method="post" style="text-align: center; margin-top: 20px;">
        <input type="hidden" name="action" value="logout">
        <button type="submit" style="
            padding: 10px 20px;
            background: linear-gradient(to right, #ce93d8, #ba68c8);
            border: none;
            border-radius: 8px;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s ease;
        " onmouseover="this.style.background='linear-gradient(to right, #ab47bc, #8e24aa)'" onmouseout="this.style.background='linear-gradient(to right, #ce93d8, #ba68c8)'">Logout</button>
    </form>
</div>

<!-- Scripts -->
<script>
    function addTask(event) {
        event.preventDefault();
        const form = new FormData(document.getElementById('addTaskForm'));
        fetch("NewServlet", {
            method: "POST",
            body: new URLSearchParams(form),
            headers: { "Content-Type": "application/x-www-form-urlencoded" }
        }).then(res => {
            if (res.redirected) {
                window.location.href = res.url;
                throw "Redirected";
            }
            return res.text();
        }).then(data => {
            alert("Task Added");
            location.reload();
        }).catch(error => console.error("Error adding task:", error));
    }

    function updateTask(event) {
        event.preventDefault();
        const form = new FormData(event.target);
        fetch("NewServlet", {
            method: "POST",
            body: new URLSearchParams(form),
            headers: { "Content-Type": "application/x-www-form-urlencoded" }
        }).then(res => res.text())
          .then(data => {
              alert("Task Updated");
              location.reload();
          })
          .catch(error => console.error("Error updating task:", error));
    }

    function deleteTask(event) {
        event.preventDefault();
        const form = new FormData(event.target);
        if (confirm("Are you sure you want to delete this task?")) {
            fetch("NewServlet", {
                method: "POST",
                body: new URLSearchParams(form),
                headers: { "Content-Type": "application/x-www-form-urlencoded" }
            }).then(res => res.text())
              .then(data => {
                  alert("Task Deleted");
                  location.reload();
              })
              .catch(error => console.error("Error deleting task:", error));
        }
    }
</script>

</body>
</html>
