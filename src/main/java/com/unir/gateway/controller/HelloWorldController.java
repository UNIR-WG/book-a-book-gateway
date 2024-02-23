package com.unir.gateway.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.logging.Logger;

@RestController
public class HelloWorldController {

    @GetMapping("/hello")
    public ResponseEntity<String> helloWorld()
    {
        try {
            return ResponseEntity.ok("Hello World from gateway!");
        } catch (Exception e) {
            Logger.getGlobal().warning("Error saying hello from gateway" + e.getMessage());
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/")
    public ResponseEntity<String> hello()
    {
        try {
            return ResponseEntity.ok("Hello World from root gateway!");
        } catch (Exception e) {
            Logger.getGlobal().warning("Error saying hello from root gateway" + e.getMessage());
            return ResponseEntity.internalServerError().build();
        }
    }
}
