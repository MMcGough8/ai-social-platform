package com.aisocial.platform.controller;

import com.aisocial.platform.dto.UserDTO;
import com.aisocial.platform.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "*")
public class FollowController {

    private final UserService userService;

    public FollowController(UserService userService) {
        this.userService = userService;
    }

    /**
     * Toggle follow/unfollow - similar to the like button behavior
     * Returns the new follow state
     */
    @PostMapping("/{id}/follow")
    public ResponseEntity<Map<String, Object>> toggleFollow(
            @PathVariable UUID id,
            @RequestHeader("X-User-Id") UUID currentUserId) {
        
        boolean isNowFollowing;
        boolean wasFollowing = userService.isFollowing(currentUserId, id);
        
        if (wasFollowing) {
            userService.unfollowUser(currentUserId, id);
            isNowFollowing = false;
        } else {
            userService.followUser(currentUserId, id);
            isNowFollowing = true;
        }
        
        long followerCount = userService.getFollowerCount(id);
        
        Map<String, Object> response = new HashMap<>();
        response.put("following", isNowFollowing);
        response.put("followerCount", followerCount);
        
        return ResponseEntity.ok(response);
    }

    /**
     * Legacy unfollow endpoint - kept for backwards compatibility
     */
    @DeleteMapping("/{id}/follow")
    public ResponseEntity<Void> unfollowUser(
            @PathVariable UUID id,
            @RequestHeader("X-User-Id") UUID currentUserId) {
        
        if (userService.isFollowing(currentUserId, id)) {
            userService.unfollowUser(currentUserId, id);
        }
        
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}/followers")
    public ResponseEntity<List<UserDTO>> getFollowers(@PathVariable UUID id) {
        List<UserDTO> followers = userService.getFollowers(id);
        return ResponseEntity.ok(followers);
    }

    @GetMapping("/{id}/following")
    public ResponseEntity<List<UserDTO>> getFollowing(@PathVariable UUID id) {
        List<UserDTO> following = userService.getFollowing(id);
        return ResponseEntity.ok(following);
    }

    @GetMapping("/{id}/is-following")
    public ResponseEntity<Boolean> isFollowing(
            @PathVariable UUID id,
            @RequestHeader("X-User-Id") UUID currentUserId) {
        boolean following = userService.isFollowing(currentUserId, id);
        return ResponseEntity.ok(following);
    }
}