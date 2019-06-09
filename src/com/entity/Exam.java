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
public class Exam {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String examplace; //考试地点
    private String examname; //考试名称
    private String examnumber; //考试人数
    private int examstate; //监考状态，-1未分配；0已分配；1已完成

    @Temporal(TemporalType.DATE)
    private Date examstart;

    @Temporal(TemporalType.DATE)
    private Date examend;


    @OneToMany(mappedBy = "exam")
    Set<ExamMessage> examMessage;


    public int getId() {
        return id;
    }


    public void setId(int id) {
        this.id = id;
    }


    public String getExamplace() {
        return examplace;
    }


    public void setExamplace(String examplace) {
        this.examplace = examplace;
    }


    public String getExamname() {
        return examname;
    }


    public void setExamname(String examname) {
        this.examname = examname;
    }


    public String getExamnumber() {
        return examnumber;
    }


    public void setExamnumber(String examnumber) {
        this.examnumber = examnumber;
    }


    public int getExamstate() {
        return examstate;
    }


    public void setExamstate(int examstate) {
        this.examstate = examstate;
    }


    public Date getExamstart() {
        return examstart;
    }


    public void setExamstart(Date examstart) {
        this.examstart = examstart;
    }


    public Date getExamend() {
        return examend;
    }


    public void setExamend(Date examend) {
        this.examend = examend;
    }


    public Set<ExamMessage> getExamMessage() {
        return examMessage;
    }


    public void setExamMessage(Set<ExamMessage> examMessage) {
        this.examMessage = examMessage;
    }


}
