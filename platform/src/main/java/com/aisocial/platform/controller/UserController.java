package com.aisocial.platform.controller;

import com.aisocial.platform.dto.UserDTO;
import com.aisocial.platform.entity.User;
import com.aisocial.platform.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "*")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public ResponseEntity<List<UserDTO>> getAllUsers() {
        List<UserDTO> users = userRepository.findAll()
                .stream()
                .map(UserDTO::fromEntity)
                .collect(Collectors.toList());
        return ResponseEntity.ok(users);
    }

    @GetMapping("/me")
    public ResponseEntity<UserDTO> getCurrentUser(@RequestHeader("X-User-Id") UUID userId) {
        return userRepository.findById(userId)
                .map(user -> ResponseEntity.ok(UserDTO.fromEntity(user)))
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserDTO> getUserById(
            @PathVariable UUID id,
            @RequestHeader(value = "X-User-Id", required = false) UUID currentUserId) {
        return userRepository.findById(id)
                .map(user -> {
                    UserDTO dto = UserDTO.fromEntity(user);
                    // TODO: Add follower/following/post counts when those repositories exist
                    // TODO: Add isFollowing check when Follow entity exists
                    return ResponseEntity.ok(dto);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/username/{username}")
    public ResponseEntity<UserDTO> getUserByUsername(
            @PathVariable String username,
            @RequestHeader(value = "X-User-Id", required = false) UUID currentUserId) {
        return userRepository.findByUsername(username)
                .map(user -> {
                    UserDTO dto = UserDTO.fromEntity(user);
                    return ResponseEntity.ok(dto);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/{id}/trust-breakdown")
    public ResponseEntity<TrustBreakdownDTO> getTrustBreakdown(@PathVariable UUID id) {
        return userRepository.findById(id)
                .map(user -> ResponseEntity.ok(new TrustBreakdownDTO(user)))
                .orElse(ResponseEntity.notFound().build());
    }

    public static class TrustBreakdownDTO {
        private UUID userId;
        private BigDecimal totalScore;
        private Integer postsFactChecked;
        private Integer postsVerified;
        private Integer postsFalse;
        private Integer debatesWon;
        private Integer debatesLost;
        private Double verifiedBonus;
        private Double falsePenalty;

        public TrustBreakdownDTO(User user) {
            this.userId = user.getId();
            this.totalScore = user.getTrustScore();
            this.postsFactChecked = user.getPostsFactChecked();
            this.postsVerified = user.getPostsVerified();
            this.postsFalse = user.getPostsFalse();
            this.debatesWon = user.getDebatesWon();
            this.debatesLost = user.getDebatesLost();
            
            this.verifiedBonus = Math.min(user.getPostsVerified() * 2.0, 30.0);
            this.falsePenalty = user.getPostsFalse() * 5.0;
        }

        public UUID getUserId() { return userId; }
        public BigDecimal getTotalScore() { return totalScore; }
        public Integer getPostsFactChecked() { return postsFactChecked; }
        public Integer getPostsVerified() { return postsVerified; }
        public Integer getPostsFalse() { return postsFalse; }
        public Integer getDebatesWon() { return debatesWon; }
        public Integer getDebatesLost() { return debatesLost; }
        public Double getVerifiedBonus() { return verifiedBonus; }
        public Double getFalsePenalty() { return falsePenalty; }
    }
}