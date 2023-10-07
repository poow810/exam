package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class controller {

    @Value("${app.version:1.0.0}")
    String version;

    @GetMapping("/")
    public String home() {
        return "Hello, CICD! version " + version;
    }
}
