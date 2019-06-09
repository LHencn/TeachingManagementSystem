package com.entity;

import jdk.nashorn.internal.objects.annotations.Getter;
import jdk.nashorn.internal.objects.annotations.Setter;

import java.util.Date;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;

@Entity
@Setter
@Getter
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String userName;   //姓名
    private String password;   //密码
    private String title;      //职称
    private String phone;      //电话
    private String content;    //介绍
    private int tag = 0;       //管理员为1，普通用户为0
    private int times = 0;     //监考次数

    @OneToMany(mappedBy = "user")
    Set<ExamMessage> examMessage;

    @OneToMany(mappedBy = "user")
    Set<TaskMessage> taskMessage;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getTag() {
        return tag;
    }

    public void setTag(int tag) {
        this.tag = tag;
    }

    public int getTimes() {
        return times;
    }

    public void setTimes(int times) {
        this.times = times;
    }

    public Set<ExamMessage> getExamMessage() {
        return examMessage;
    }

    public void setExamMessage(Set<ExamMessage> examMessage) {
        this.examMessage = examMessage;
    }

    public Set<TaskMessage> getTaskMessage() {
        return taskMessage;
    }

    public void setTaskMessage(Set<TaskMessage> taskMessage) {
        this.taskMessage = taskMessage;
    }


}
