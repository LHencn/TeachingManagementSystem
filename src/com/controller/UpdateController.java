package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Service.UserService;
import com.dao.UserDao;
import com.entity.User;
import com.utils.MD5Utils;

@RestController
public class UpdateController {


    @Autowired
    private UserService userService;

    @PostMapping("/editpassword")
    public Map<String, String> editPassword(String password, HttpSession session) {
        User user = (User) session.getAttribute("user");
        user.setPassword(MD5Utils.md5(password));
        int count = userService.updatePassword(user.getPassword(), user.getId());
        Map<String, String> map = new HashMap<>();
        map.put("count", String.valueOf(count));
        return map;
    }

    @RequestMapping("/selectteachers")
    public List<User> selectteachers() {
        //	Map<String, Object> map=new HashMap<>();
        List<User> users = new ArrayList<>();
        users = userService.allusers();
        return users;
    }

    @RequestMapping("/selectonlyteachers")
    public List<User> selectonlyteachers() {
        //	Map<String, Object> map=new HashMap<>();
        List<User> users = new ArrayList<>();
        users = userService.allteachers();
        return users;
    }

    @RequestMapping("/selectmanagers")
    public List<User> selectmanagers() {
        //	Map<String, Object> map=new HashMap<>();
        List<User> users = new ArrayList<>();
        users = userService.allmanagers();
        return users;
    }

    @RequestMapping("/removeuser/{id}")
    public void removeuser(@PathVariable String id) {
        String[] ids = id.split(",");
        for (int i = 0; i < ids.length; i++) {
            userService.removeuser(Integer.parseInt(ids[i]));
        }

    }

    @RequestMapping("/removeadmin/{id}")
    public void removeadmin(@PathVariable String id) {
        String[] ids = id.split(",");
        for (int i = 0; i < ids.length; i++) {
            userService.removeadmin(Integer.parseInt(ids[i]));
        }

    }


    @RequestMapping("/update")
    public void updateuser(User user) {
        userService.updateuser(user);
    }


    @RequestMapping("/setadmin/{id}")
    public void setadmin(@PathVariable String id) {
        String[] ids = id.split(",");
        for (int i = 0; i < ids.length; i++) {
            userService.setAdmin(Integer.parseInt(ids[i]));
        }
    }

}
