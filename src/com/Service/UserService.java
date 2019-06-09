package com.Service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.UserDao;
import com.entity.User;


@Service
@Transactional
public class UserService implements InitializingBean {

    @Autowired
    private InitService initService;

    @Autowired
    private UserDao userDao;

    public User getUser(String userName, String password) {
        return userDao.find(userName, password);
    }

    public int updatePassword(String newpassword, int id) {
        return userDao.executeUpdate(newpassword, id);
    }

    public void addUser(User user) {
        userDao.addUser(user);
    }

    public List<User> allusers() {
        return userDao.selectteachers();
    }

    public List<User> allmanagers() {
        return userDao.selectmanagers();
    }

    public void removeuser(int id) {
        userDao.deleteusers(id);
    }

    public void updateuser(User user) {
        userDao.updateuser(user);
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        /**
         * 初始化的时候先判断数据库里面有没有用户名为罗老师的记录
         */
        if (initService.isexist_manager()) {
            System.out.println("初始化管理员已存在");
        } else {
            initService.initUserAuthority();
        }
    }

    public List<User> allteachers() {
        // TODO Auto-generated method stub
        return userDao.selectonlyteachers();
    }

    public void setAdmin(int id) {
        // TODO Auto-generated method stub
        userDao.setAdmin(id);
    }

    public void removeadmin(int id) {
        // TODO Auto-generated method stub
        userDao.deletemsnsgers(id);
    }


}
