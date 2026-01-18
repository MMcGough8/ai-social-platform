package com.aisocial.platform.controller;

import com.aisocial.platform.dto.TrustScoreBreakdownDTO;
import com.aisocial.platform.dto.UpdateUserRequestDTO;
import com.aisocial.platform.dto.UserDTO;
import com.aisocial.platform.dto.UserResponseDTO;
import com.aisocial.platform.dto.UserSearchRequestDTO;
import com.aisocial.platform.service.TrustScoreService;
import com.aisocial.platform.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "*")
public class UserController {

    private final UserService userService;
    private final TrustScoreService trustScoreService;

    public UserController(UserService userService, TrustScoreService trustScoreService) {
        this.userService = userService;
        this.trustScoreService = trustScoreService;
    }

    @GetMapping
    public ResponseEntity<List<UserDTO>> getAllUsers() {
        List<UserDTO> users = userService.getAllUsers();
        return ResponseEntity.ok(users);
    }

    @GetMapping("/me")
    public ResponseEntity<UserDTO> getCurrentUser(@RequestHeader("X-User-Id") UUID userId) {
        return userService.getUserById(userId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/{id}")
    public ResponseEntity<UserDTO> getUserById(
            @PathVariable UUID id,
            @RequestHeader(value = "X-User-Id", required = false) UUID currentUserId) {
        return userService.getUserById(id, currentUserId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/username/{username}")
    public ResponseEntity<UserDTO> getUserByUsername(
            @PathVariable String username,
            @RequestHeader(value = "X-User-Id", required = false) UUID currentUserId) {
        return userService.getUserByUsername(username, currentUserId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/{id}/trust-breakdown")
    public ResponseEntity<TrustScoreBreakdownDTO> getTrustBreakdown(@PathVariable UUID id) {
        return trustScoreService.getBreakdown(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<UserDTO> updateUser(
            @PathVariable UUID id,
            @RequestBody UpdateUserRequestDTO request
    ) {
        UserDTO updatedUser = userService.updateUser(id, request);
        return ResponseEntity.ok(updatedUser);
    }

    /**
     * Search users with flexible filters
     * 
     * Example requests:
     * - /api/users/search?username=john
     * - /api/users/search?displayName=alice&page=0&size=20
     * - /api/users/search?username=bob&minTrustScore=70&maxTrustScore=100
     * - /api/users/search?minTrustScore=80&maxTrustScore=100
     * 
     * @param username Search by username (optional, partial match)
     * @param displayName Search by display name (optional, partial match)
     * @param minTrustScore Minimum trust score filter (optional, 0-100)
     * @param maxTrustScore Maximum trust score filter (optional, 0-100)
     * @param page Page number (default: 0)
     * @param size Results per page (default: 20, max: 100)
     * @return Page of matching users
     */
    @GetMapping("/search")
    public ResponseEntity<Page<UserResponseDTO>> searchUsers(
            @RequestParam(required = false) String username,
            @RequestParam(required = false) String displayName,
            @RequestParam(required = false) BigDecimal minTrustScore,
            @RequestParam(required = false) BigDecimal maxTrustScore,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size
    ) {
        // Validate and limit page size
        if (size > 100) {
            size = 100;
        }

        // Validate trust score range if provided
        if (minTrustScore != null && minTrustScore.compareTo(BigDecimal.ZERO) < 0) {
            return ResponseEntity.badRequest().build();
        }
        if (maxTrustScore != null && maxTrustScore.compareTo(new BigDecimal("100")) > 0) {
            return ResponseEntity.badRequest().build();
        }
        if (minTrustScore != null && maxTrustScore != null && 
            minTrustScore.compareTo(maxTrustScore) > 0) {
            return ResponseEntity.badRequest().build();
        }

        // Build search request DTO
        UserSearchRequestDTO request = new UserSearchRequestDTO();
        request.setUsername(username);
        request.setDisplayName(displayName);
        request.setMinTrustScore(minTrustScore);
        request.setMaxTrustScore(maxTrustScore);
        request.setPage(page);
        request.setSize(size);

        Page<UserResponseDTO> results = userService.searchUsers(request);
        return ResponseEntity.ok(results);
    }
}