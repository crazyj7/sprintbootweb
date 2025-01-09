package com.example.demo.service;

import com.example.demo.model.ServerData;
import com.example.demo.repository.ServerDataRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ServerDataService {
    
    @Autowired
    private ServerDataRepository repository;
    
    public Page<ServerData> getAllData(int page, int size) {
        return repository.findAll(PageRequest.of(page, size));
    }
    
    public ServerData saveData(ServerData data) {
        if (repository.existsById(data.getDataName())) {
            throw new IllegalArgumentException("이미 존재하는 키입니다: " + data.getDataName());
        }
        return repository.save(data);
    }
    
    public void deleteData(String dataName) {
        repository.deleteById(dataName);
    }
    
    public ServerData updateData(ServerData data) {
        return repository.save(data);
    }
} 