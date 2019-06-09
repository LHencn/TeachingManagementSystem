package com.Service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.TaskDao;
import com.entity.Task;

@Service
@Transactional
public class TaskService {

    @Autowired
    private TaskDao taskDao;

    public void createTask(Task task) {

        taskDao.createTask(task);
    }


}
