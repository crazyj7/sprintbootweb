package com.example.demo.model;

import javax.persistence.*;

@Entity
@Table(name = "TDATA")
public class ServerData {
    
    @Id
    @Column(name = "DATA_NAME")
    private String dataName;
    
    @Column(name = "DATA_VALUE")
    private String dataValue;

    // Getters and Setters
    public String getDataName() {
        return dataName;
    }

    public void setDataName(String dataName) {
        this.dataName = dataName;
    }

    public String getDataValue() {
        return dataValue;
    }

    public void setDataValue(String dataValue) {
        this.dataValue = dataValue;
    }
} 