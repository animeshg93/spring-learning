package com.spring.animesh.spring_learning.repository;

import org.springframework.data.repository.CrudRepository;

import com.spring.animesh.spring_learning.model.User;

public interface UserRepository extends CrudRepository<User, Long> {

    User findByName(String name);

}
