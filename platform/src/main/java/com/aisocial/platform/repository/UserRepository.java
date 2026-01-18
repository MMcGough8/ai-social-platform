package com.aisocial.platform.repository;

import com.aisocial.platform.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID>, JpaSpecificationExecutor<User> {

    Optional<User> findByUsername(String username);

    boolean existsByUsername(String username);

    /**
     * Search users by username or display name (case-insensitive, partial match)
     * @param searchTerm The term to search for
     * @param pageable Pagination parameters
     * @return Page of matching users
     */
    @Query("SELECT u FROM User u WHERE " +
           "LOWER(u.username) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(u.displayName) LIKE LOWER(CONCAT('%', :searchTerm, '%'))")
    Page<User> searchByUsernameOrDisplayName(@Param("searchTerm") String searchTerm, Pageable pageable);

    /**
     * Search users by username or display name with trust score range filter
     * @param searchTerm The term to search for
     * @param minTrustScore Minimum trust score (inclusive)
     * @param maxTrustScore Maximum trust score (inclusive)
     * @param pageable Pagination parameters
     * @return Page of matching users
     */
    @Query("SELECT u FROM User u WHERE " +
           "(LOWER(u.username) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(u.displayName) LIKE LOWER(CONCAT('%', :searchTerm, '%'))) AND " +
           "u.trustScore >= :minTrustScore AND u.trustScore <= :maxTrustScore")
    Page<User> searchByUsernameOrDisplayNameWithTrustScore(
            @Param("searchTerm") String searchTerm,
            @Param("minTrustScore") BigDecimal minTrustScore,
            @Param("maxTrustScore") BigDecimal maxTrustScore,
            Pageable pageable);

    /**
     * Search users by username only (case-insensitive, partial match)
     * @param username Username to search for
     * @param pageable Pagination parameters
     * @return Page of matching users
     */
    @Query("SELECT u FROM User u WHERE LOWER(u.username) LIKE LOWER(CONCAT('%', :username, '%'))")
    Page<User> searchByUsername(@Param("username") String username, Pageable pageable);

    /**
     * Search users by display name only (case-insensitive, partial match)
     * @param displayName Display name to search for
     * @param pageable Pagination parameters
     * @return Page of matching users
     */
    @Query("SELECT u FROM User u WHERE LOWER(u.displayName) LIKE LOWER(CONCAT('%', :displayName, '%'))")
    Page<User> searchByDisplayName(@Param("displayName") String displayName, Pageable pageable);

    /**
     * Find users within a trust score range
     * @param minTrustScore Minimum trust score (inclusive)
     * @param maxTrustScore Maximum trust score (inclusive)
     * @param pageable Pagination parameters
     * @return Page of users within the trust score range
     */
    @Query("SELECT u FROM User u WHERE u.trustScore >= :minTrustScore AND u.trustScore <= :maxTrustScore ORDER BY u.trustScore DESC")
    Page<User> findByTrustScoreRange(
            @Param("minTrustScore") BigDecimal minTrustScore,
            @Param("maxTrustScore") BigDecimal maxTrustScore,
            Pageable pageable);

    /**
     * Search users ordered by trust score (highest first)
     * @param searchTerm The term to search for
     * @param pageable Pagination parameters
     * @return Page of matching users ordered by trust score
     */
    @Query("SELECT u FROM User u WHERE " +
           "LOWER(u.username) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
           "LOWER(u.displayName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) " +
           "ORDER BY u.trustScore DESC")
    Page<User> searchByUsernameOrDisplayNameOrderByTrustScore(@Param("searchTerm") String searchTerm, Pageable pageable);
}