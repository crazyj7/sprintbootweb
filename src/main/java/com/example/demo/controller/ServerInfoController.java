package com.example.demo.controller;

import com.example.demo.model.ServerData;
import com.example.demo.service.ServerDataService;
import com.example.demo.util.ResourceVersionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Value;

@Controller
public class ServerInfoController {
    
    @Value("${app.page-size}")
    private int pageSize;
    
    @Autowired
    private ResourceVersionUtil resourceVersion;
    
    @Autowired
    private ServerDataService service;
    
    @GetMapping("/serverinfo")
    public String serverInfo(Model model, 
                            @RequestParam(defaultValue = "0") int page) {
        Page<ServerData> pageResult = service.getAllData(page, pageSize);
        
        model.addAttribute("currentPage", "serverinfo");
        model.addAttribute("resourceVersion", resourceVersion);
        model.addAttribute("dataList", pageResult.getContent());
        model.addAttribute("totalPages", pageResult.getTotalPages());
        model.addAttribute("currentPageNumber", page);
        model.addAttribute("totalElements", pageResult.getTotalElements());
        model.addAttribute("pageSize", pageSize);
        
        return "serverinfo";
    }
    
    @PostMapping("/api/serverdata")
    @ResponseBody
    public ResponseEntity<?> addData(@RequestBody ServerData data) {
        try {
            ServerData savedData = service.saveData(data);
            return ResponseEntity.ok(savedData);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    
    @PutMapping("/api/serverdata/{dataName}")
    @ResponseBody
    public ServerData updateData(@PathVariable String dataName, @RequestBody ServerData data) {
        data.setDataName(dataName);
        return service.updateData(data);
    }
    
    @DeleteMapping("/api/serverdata/{dataName}")
    @ResponseBody
    public ResponseEntity<?> deleteData(@PathVariable String dataName) {
        service.deleteData(dataName);
        return ResponseEntity.ok().build();
    }
} 