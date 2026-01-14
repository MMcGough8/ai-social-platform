package com.aisocial.platform.service;

import com.aisocial.platform.entity.DebateVote;
import com.aisocial.platform.repository.DebateVoteRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class DebateVoteService {

    private final DebateVoteRepository debateVoteRepository;

    public DebateVoteService(DebateVoteRepository debateVoteRepository) {
        this.debateVoteRepository = debateVoteRepository;
    }

    public DebateVote save(DebateVote vote) {
        return debateVoteRepository.save(vote);
    }

    public Optional<DebateVote> findById(UUID id) {
        return debateVoteRepository.findById(id);
    }

    public List<DebateVote> findByDebateId(UUID debateId) {
        return debateVoteRepository.findByDebateId(debateId);
    }

    public List<DebateVote> findByUserId(UUID userId) {
        return debateVoteRepository.findByUserId(userId);
    }

    public void delete(DebateVote vote) {
        debateVoteRepository.delete(vote);
    }
}
