package com.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Service.TaskService;
import com.Service.UserService;
import com.entity.Task;
import com.entity.User;
import com.utils.MD5Utils;

import antlr.StringUtils;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public void init() {

    }

    @PostMapping("/login")
    public String login(String username, String password, String checkcode, String exception, HttpSession session, RedirectAttributes attributes) {
        String key = (String) session.getAttribute("key");
        if (checkcode.equals(key)) { //验证码正确
            password = MD5Utils.md5(password);
            User user = userService.getUser(username, password);
            if (user != null) {
                session.setAttribute("user", user);
                attributes.addFlashAttribute("name", user.getUserName());
                return "redirect:/index";
            } else {
                //用户名或者密码错误
                exception = "用户名或者密码错误";
            }
        } else {
            //验证码错误
            exception = "验证码错误";
        }
        attributes.addFlashAttribute("exception", exception);
        return "redirect:/login";
    }

    @GetMapping("exit")
    public String exit(HttpSession session) {
        session.removeAttribute("user");
        return "login";
    }


    @PostMapping("/save")
    public String addteacher(User user) {
        userService.addUser(user);
        return "admin/addteacher";
    }


//	@PostMapping("/login")
//	public Map<String, String> login(String username, String password, String checkcode,String exception,HttpSession session,RedirectAttributes attributes){
//		Map<String, String> map=new HashMap<String, String>();
//		String key=(String) session.getAttribute("key");
//		if(checkcode.equals(key)){ //验证码正确
//		password=MD5Utils.md5(password);	
//		User user = userService.getUser(username, password);
//		if (user != null) {
//			session.setAttribute("user", user);
//			attributes.addFlashAttribute("name",user.getUserName());
//			map.put("flag", "1");
//			return "redirect:/index";
//		}else{
//			//用户名或者密码错误
//			exception="用户名或者密码错误";
//		}
//		}else{
//				//验证码错误
//		exception="验证码错误";
//		}
//		attributes.addFlashAttribute("exception",exception);
//		map.put("flag", "0");
//			return map; 
//	}


}
