package com.example.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource("classpath:application-secret.properties")
public class ApplicationConfigSecret {
    
}
