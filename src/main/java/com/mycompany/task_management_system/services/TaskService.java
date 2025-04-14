/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.task_management_system.services;

import com.mycompany.task_management_system.model.Tasks;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import java.util.List;

public class TaskService {

    private static final SessionFactory factory;

    static {
        factory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(Tasks.class).buildSessionFactory();
    }

    public static void addTask(Tasks task) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        session.persist(task);
        transaction.commit();
    }

    public static List<Tasks> getAllTasks() {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        List<Tasks> tasks = session.createQuery("FROM Tasks", Tasks.class).getResultList();
        transaction.commit();
        return tasks;
    }

    public static void updateTask(int id, String title, String description, String category) {
        Transaction transaction = null;
        try (Session session = factory.getCurrentSession()) {
            transaction = session.beginTransaction();
            Tasks task = session.get(Tasks.class, id);
            if (task != null) {
                task.setTitle(title);
                task.setDescription(description);
                task.setCategory(category);
                session.merge(task);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
        }
    }

    public static void deleteTask(int taskId) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        Tasks task = session.get(Tasks.class, taskId);
        if (task != null) {
            session.remove(task);
        }
        transaction.commit();
    }
}
