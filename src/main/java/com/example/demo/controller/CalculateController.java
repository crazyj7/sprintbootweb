package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.demo.util.ResourceVersionUtil;

@Controller
public class CalculateController {
    
    @Autowired
    private ResourceVersionUtil resourceVersion;
    
    @GetMapping("/calculate")
    public String calculateForm(Model model) {
        model.addAttribute("currentPage", "calculate");
        model.addAttribute("resourceVersion", resourceVersion);
        return "calculate";
    }
    
    @PostMapping("/calculate")
    @ResponseBody
    public double calculate(@RequestParam double num1, 
                          @RequestParam double num2, 
                          @RequestParam String operation) {
        switch(operation) {
            case "add": return num1 + num2;
            case "subtract": return num1 - num2;
            case "multiply": return num1 * num2;
            case "divide": return num2 != 0 ? num1 / num2 : 0;
            default: return 0;
        }
    }
} 