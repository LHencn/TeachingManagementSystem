package com.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import com.entity.Task;

@Repository
public class TaskDao {

    @PersistenceContext
    EntityManager entityManager = null;

    /**
     * 创建任务
     */
    public void createTask(Task task) {
        Task task2 = new Task();
        task2.setTasktype(task.getTasktype());
        task2.setTaskname(task.getTaskname());
        task2.setTaskinfo(task.getTaskinfo());
        task2.setTaskend(task.getTaskend());

        entityManager.persist(task2);
    }
}
