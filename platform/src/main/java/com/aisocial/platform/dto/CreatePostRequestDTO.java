package com.aisocial.platform.dto;

import java.util.UUID;

public class CreatePostRequestDTO {
    private UUID userId;
    private String content;
    private Boolean factCheck = false;

    public UUID getUserId() {
        return userId;
    }

    public void setUserId(UUID userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Boolean getFactCheck() {
        return factCheck;
    }

    public void setFactCheck(Boolean factCheck) {
        this.factCheck = factCheck;
    }

    public boolean shouldFactCheck() {
        return factCheck != null && factCheck;
    }
}