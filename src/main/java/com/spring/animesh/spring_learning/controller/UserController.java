package com.spring.animesh.spring_learning.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.animesh.spring_learning.model.User;
import com.spring.animesh.spring_learning.repository.UserRepository;

@RestController
public class UserController {

	@Autowired
	private UserRepository userRepository;

	@PostMapping("/users")
	public ResponseEntity<String> createUser(@RequestBody User user) {
		userRepository.save(user);
		return new ResponseEntity<>(user.getName(), HttpStatus.CREATED);
	}

}
