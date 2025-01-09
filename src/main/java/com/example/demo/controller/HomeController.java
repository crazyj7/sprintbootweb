package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.demo.util.ResourceVersionUtil;

@Controller
public class HomeController {
    @Autowired
    private ResourceVersionUtil resourceVersion;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("currentPage", "home");
        model.addAttribute("resourceVersion", resourceVersion);
        return "index";
    }
} 