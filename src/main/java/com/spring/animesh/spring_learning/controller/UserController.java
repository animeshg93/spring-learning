package com.spring.animesh.spring_learning.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.animesh.spring_learning.model.User;

@RestController
public class UserController {

	@PostMapping("/users")
	public ResponseEntity<String> createUser(@RequestBody User user) {
		// In a real app you'd save the user to a database here.
		// For now echo back the received user with 201 Created.
		return new ResponseEntity<>(user.getName(), HttpStatus.CREATED);
	}

}
