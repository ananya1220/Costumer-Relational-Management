/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.task_management_system.services;

import com.mycompany.task_management_system.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import java.util.List;

public class UserService {

    private static final SessionFactory factory;

    static {
        factory = new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(User.class).buildSessionFactory();
    }

    
    public static void saveUser(User user) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        session.persist(user);
        transaction.commit();
    }


    public static String loginUser(String username, String password) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        Query query = session.createQuery("from User where username = :username");
        query.setParameter("username", username);
        User user = (User) query.uniqueResult();

        if (user == null) {
            return "User not found, please register.";
        }

        if (!password.equals(user.getPassword())) {
            return "Incorrect password!";
        }

        transaction.commit();
        return "success";
    }

    public static User getUserByUsername(String username) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        Query query = session.createQuery("from User where username = :username");
        query.setParameter("username", username);
        User user = (User) query.uniqueResult();
        transaction.commit();
        return user;
    }


    public static List<User> getAllUsers() {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        List<User> users = session.createQuery("from User", User.class).getResultList();
        transaction.commit();
        return users;
    }
    
    public static User getUserById(int userId) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        User user = session.get(User.class, userId);
        transaction.commit();
        return user;
    }


    public static void updateUser(int id, String username, String password) {
        Transaction transaction = null;
        try (Session session = factory.getCurrentSession()) {
            transaction = session.beginTransaction();
            User user = session.get(User.class, id);
            if (user != null) {
                user.setUsername(username);
                user.setPassword(password);
                session.merge(user);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
        }
    }

    public static void deleteUser(int userId) {
        Session session = factory.getCurrentSession();
        Transaction transaction = session.beginTransaction();
        User user = session.get(User.class, userId);
        if (user != null) {
            session.remove(user);
        }
        transaction.commit();
    }
}
