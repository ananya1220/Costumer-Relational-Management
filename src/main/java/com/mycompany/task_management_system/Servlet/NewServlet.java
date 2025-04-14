/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.task_management_system.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import com.mycompany.task_management_system.services.UserService;
import com.mycompany.task_management_system.services.TaskService;
import com.mycompany.task_management_system.model.Tasks;
import com.mycompany.task_management_system.model.User;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.*;

@WebServlet(name = "NewServlet", urlPatterns = {"/NewServlet"})
public class NewServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("register".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            User newUser = new User(username, password);
            UserService.saveUser(newUser);
            response.sendRedirect("index.html");

        } else if ("login".equals(action)) {

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            String loginResult = UserService.loginUser(username, password);
            if ("success".equals(loginResult)) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                List<Tasks> tasks = TaskService.getAllTasks();
                System.out.println(tasks);
                session.setAttribute("tasks", tasks);
                response.sendRedirect("dashboard.jsp");
            } else {
                response.getWriter().println("<script>alert('" + loginResult + "'); window.location='index.jsp';</script>");
            }

        } else if ("addTask".equals(action)) {

            HttpSession session = request.getSession();
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            Tasks task = new Tasks(title, description, category);
            TaskService.addTask(task);
            List<Tasks> tasks = TaskService.getAllTasks();
            session.setAttribute("tasks", tasks);
            response.getWriter().write("task added successfully");
            response.sendRedirect("dashboard.jsp");

        } else if ("updateTask".equals(action)) {

            HttpSession session = request.getSession();
            int taskId = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");

            TaskService.updateTask(taskId, title, description, category);
            List<Tasks> tasks = TaskService.getAllTasks();
            session.setAttribute("tasks", tasks);
            response.sendRedirect("dashboard.jsp");

        } else if ("deleteTask".equals(action)) {

            int taskId = Integer.parseInt(request.getParameter("id"));
            TaskService.deleteTask(taskId);
            HttpSession session = request.getSession();
            List<Tasks> tasks = TaskService.getAllTasks();
            session.setAttribute("tasks", tasks);
            response.sendRedirect("dashboard.jsp");
        } else if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            session.invalidate();
            response.sendRedirect("index.html");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for User Authentication and Task Management.";
    }
}
