package com.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
//import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.entity.User;
import com.utils.MD5Utils;



/*
    dao持久层就是和数据库交互，对数据库表进行增删改查的。
 */
@Repository
public class UserDao {

    @PersistenceContext
    EntityManager entityManager = null;

    public void init() {  //初始化管理员
        User user = new User();
        user.setUserName("罗老师");
        user.setPassword(MD5Utils.md5("111"));
        user.setTitle("专业主任");
        user.setPhone("18866666666");
        user.setContent("罗老师是专业主任");
        user.setTag(1);
        user.setTimes(0);
        entityManager.persist(user);

    }

    public int init_find() {
        int flag = 0;
        String jpql = "FROM User u WHERE u.userName=?1";
        Query query = entityManager.createQuery(jpql);
        query.setParameter(1, "罗老师");
        User user = null;
        try {
            user = (User) query.getSingleResult();
            if (user != null) {
                flag = 1;
            }
        } catch (NoResultException e) {
            // TODO: handle exception
        }
        return flag;
    }

    public User find(String userName, String password) {
        // TODO Auto-generated method stub
        String jpql = "FROM User u WHERE u.userName=:userName AND u.password=:password";
        Query query = entityManager.createQuery(jpql);
        query.setParameter("userName", userName);
        query.setParameter("password", password);
        User user = null;
        try {
            user = (User) query.getSingleResult();
        } catch (NoResultException e) {
            // TODO: handle exception
        }
        return user;
    }

    /**
     * 改密码
     */
    public int executeUpdate(String newpassword, int id) {
        String jpql = "UPDATE User u SET u.password=?1 WHERE u.id=?2";
        Query query = entityManager.createQuery(jpql);
        query.setParameter(1, newpassword);
        query.setParameter(2, id);
        int a = query.executeUpdate();
        return a;
    }


    /**
     * 添加教师
     */
    public void addUser(User u) {
        User user = new User();
        user.setUserName(u.getUserName());
        user.setPassword(MD5Utils.md5(u.getPassword()));
        user.setTitle(u.getTitle());
        user.setPhone(u.getPhone());
        user.setContent(u.getContent());
        user.setTag(u.getTag());
        user.setTimes(u.getTimes());
        entityManager.persist(user);
    }

    /**
     * 查询教师
     */

    @SuppressWarnings("unchecked")
    public List<User> selectteachers() {
        List<User> users = new ArrayList<>();
        String jpql = "FROM User";
        Query query = entityManager.createQuery(jpql);
        //	query.setParameter("tag", 0);
        List<User> user2 = query.getResultList();
        for (User user : user2) {
            User user1 = new User();
            user1.setId(user.getId());
            user1.setUserName(user.getUserName());
            user1.setPassword(user.getPassword());
            user1.setTitle(user.getTitle());
            user1.setPhone(user.getPhone());
            user1.setContent(user.getContent());
            user1.setTimes(user.getTimes());
            user1.setTag(user.getTag());
            users.add(user1);
        }
        //	System.out.println(users);
        return users;
    }


    /**
     * 查询管理员
     */

    @SuppressWarnings("unchecked")
    public List<User> selectmanagers() {
        List<User> users = new ArrayList<>();
        String jpql = "FROM User u WHERE u.tag>?1";
        Query query = entityManager.createQuery(jpql);
        query.setParameter(1, 0);
        List<User> user2 = query.getResultList();
        for (User user : user2) {
            User user1 = new User();
            user1.setId(user.getId());
            user1.setUserName(user.getUserName());
            user1.setPassword(user.getPassword());
            user1.setTitle(user.getTitle());
            user1.setPhone(user.getPhone());
            user1.setContent(user.getContent());
            user1.setTimes(user.getTimes());
            user1.setTag(user.getTag());
            users.add(user1);
        }
        //	System.out.println(users);
        return users;
    }

    //删除用户
    public void deleteusers(int id) {
        String jpql = "DELETE User u WHERE u.id=:id";
        Query query = entityManager.createQuery(jpql);
        query.setParameter("id", id);
        int x = query.executeUpdate();

    }

    //更新用户
    public void updateuser(User user) {
        User user1 = entityManager.find(User.class, user.getId());
        user1.setUserName(user.getUserName());
        user1.setPassword(user.getPassword());
        user1.setPhone(user.getPhone());
        user1.setTitle(user.getTitle());
        user1.setContent(user.getContent());
        user1.setTimes(user.getTimes());
        entityManager.persist(user1);
    }

    public List<User> selectonlyteachers() {
        // TODO Auto-generated method stub

        List<User> users = new ArrayList<>();
        String jpql = "FROM User u WHERE u.tag=:tag";
        Query query = entityManager.createQuery(jpql);
        query.setParameter("tag", 0);
        List<User> user2 = query.getResultList();
        for (User user : user2) {
            User user1 = new User();
            user1.setId(user.getId());
            user1.setUserName(user.getUserName());
            user1.setPassword(user.getPassword());
            user1.setTitle(user.getTitle());
            user1.setPhone(user.getPhone());
            user1.setContent(user.getContent());
            user1.setTimes(user.getTimes());
            user1.setTag(user.getTag());
            users.add(user1);
        }
        //	System.out.println(users);
        return users;
    }

    public void setAdmin(int id) {
        // TODO Auto-generated method stub
        User user1 = entityManager.find(User.class, id);
        user1.setTag(id);
        entityManager.persist(user1);
    }

    //删除管理员
    public void deletemsnsgers(int id) {
        String jpql = "UPDATE User u SET u.tag=:tag WHERE u.id=:id and u.tag>?1";
        Query query = entityManager.createQuery(jpql);
        query.setParameter("id", id);
        query.setParameter(1, 0);
        query.setParameter("tag", 0);
        int x = query.executeUpdate();


    }


}
