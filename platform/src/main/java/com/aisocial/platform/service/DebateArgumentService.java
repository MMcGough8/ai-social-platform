package com.aisocial.platform.service;

import com.aisocial.platform.entity.DebateArgument;
import com.aisocial.platform.entity.Debate;
import com.aisocial.platform.repository.DebateArgumentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class DebateArgumentService {

    private final DebateArgumentRepository debateArgumentRepository;

    public DebateArgumentService(DebateArgumentRepository debateArgumentRepository) {
        this.debateArgumentRepository = debateArgumentRepository;
    }

    // Create or update
    public DebateArgument save(DebateArgument debateArgument) {
        return debateArgumentRepository.save(debateArgument);
    }

    // Find by ID
    public Optional<DebateArgument> findById(UUID id) {
        return debateArgumentRepository.findById(id);
    }

    // Find all arguments for a debate
    public List<DebateArgument> findByDebate(Debate debate) {
        return debateArgumentRepository.findByDebateOrderByRoundNumberAsc(debate);
    }

    // Delete
    public void delete(DebateArgument debateArgument) {
        debateArgumentRepository.delete(debateArgument);
    }
}
