package com.entity;

import java.util.Date;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String tasktype;  //任务类型
    private String taskname;  //任务名称
    private String taskinfo;  //任务描述

    @Temporal(TemporalType.DATE)
    private Date taskend;    //截止时间


    //private int taskstate;  //任务状态。1按时完成；0未按时完成；

    @OneToMany(mappedBy = "task")
    Set<TaskMessage> taskMessage;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTasktype() {
        return tasktype;
    }

    public void setTasktype(String tasktype) {
        this.tasktype = tasktype;
    }

    public String getTaskname() {
        return taskname;
    }

    public void setTaskname(String taskname) {
        this.taskname = taskname;
    }

    public String getTaskinfo() {
        return taskinfo;
    }

    public void setTaskinfo(String taskinfo) {
        this.taskinfo = taskinfo;
    }

    public Date getTaskend() {
        return taskend;
    }

    public void setTaskend(Date taskend) {
        this.taskend = taskend;
    }


    public Set<TaskMessage> getTaskMessage() {
        return taskMessage;
    }

    public void setTaskMessage(Set<TaskMessage> taskMessage) {
        this.taskMessage = taskMessage;
    }


}
