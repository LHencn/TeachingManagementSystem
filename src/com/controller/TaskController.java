package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.Service.TaskService;
import com.entity.Task;

@RestController
public class TaskController {

    @Autowired
    private TaskService taskService;

    @PostMapping("/create")
    public void createTask(Task task) {
        taskService.createTask(task);
    }

}
