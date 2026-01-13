package com.aisocial.platform.service;

import com.aisocial.platform.entity.DebateVote;
import com.aisocial.platform.entity.VoteType;
import com.aisocial.platform.repository.DebateVoteRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.UUID;

@Service
public class DebateVoteService {

    private final DebateVoteRepository voteRepository;

    public DebateVoteService(DebateVoteRepository voteRepository) {
        this.voteRepository = voteRepository;
    }

    /**
     * Creates or updates a user's vote for a debate.
     * If the user has already voted, overwrite the existing vote.
     */
    @Transactional
    public DebateVote vote(UUID debateId, UUID userId, VoteType voteType) {
        DebateVote vote = voteRepository.findByDebateIdAndUserId(debateId, userId)
                .orElseGet(DebateVote::new);

        vote.setDebateId(debateId);
        vote.setUserId(userId);
        vote.setVote(voteType);
        vote.setCreatedAt(Instant.now());

        return voteRepository.save(vote);
    }

    /**
     * Count votes of a specific type for a debate.
     */
    @Transactional(readOnly = true)
    public long countVotes(UUID debateId, VoteType voteType) {
        return voteRepository.countByDebateIdAndVote(debateId, voteType);
    }
}
