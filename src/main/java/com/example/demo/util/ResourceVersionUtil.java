package com.example.demo.util;

import org.springframework.stereotype.Component;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class ResourceVersionUtil {
    private final String version;

    public ResourceVersionUtil() {
        this.version = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
    }

    public String getVersionedUrl(String resourceUrl) {
        return resourceUrl + "?v=" + version;
    }
} 