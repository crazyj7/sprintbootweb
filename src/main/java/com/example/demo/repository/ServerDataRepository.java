package com.example.demo.repository;

import com.example.demo.model.ServerData;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.lang.NonNull;

public interface ServerDataRepository extends JpaRepository<ServerData, String> {
    @NonNull
    Page<ServerData> findAll(@NonNull Pageable pageable);
} 