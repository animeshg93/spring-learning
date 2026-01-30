package com.spring.animesh.spring_learning.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {
    // Add your controller methods here
    @GetMapping("/hello")
    public String helloWorld() {
        return "Hello, Animesh!";
    }
}
