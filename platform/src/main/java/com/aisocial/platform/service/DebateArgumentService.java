package com.aisocial.platform.service;

import com.aisocial.platform.entity.Debate;
import com.aisocial.platform.entity.DebateArgument;
import com.aisocial.platform.entity.User;
import com.aisocial.platform.repository.DebateArgumentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class DebateArgumentService {

    private final DebateArgumentRepository repository;

    public DebateArgumentService(DebateArgumentRepository repository) {
        this.repository = repository;
    }

    /**
     * Saves a debate argument with validation for round number.
     * @param argument DebateArgument to save
     * @return Saved DebateArgument
     */
    public DebateArgument saveArgument(DebateArgument argument) {
        if (argument.getRoundNumber() < 1 || argument.getRoundNumber() > 3) {
            throw new IllegalArgumentException("Round number must be between 1 and 3");
        }
        // Optionally: validate debate has exactly 2 users
        return repository.save(argument);
    }

    /**
     * Retrieves all arguments for a debate, ordered by round ascending.
     * @param debate Debate object
     * @return List of DebateArguments
     */
    public List<DebateArgument> getArgumentsByDebate(Debate debate) {
        return repository.findByDebateOrderByRoundNumberAsc(debate);
    }

    /**
     * Finds a specific argument by debate, user, and round number.
     * @param debate Debate object
     * @param user User object
     * @param round Round number (1-3)
     * @return Optional of DebateArgument
     */
    public Optional<DebateArgument> getArgumentByDebateUserRound(Debate debate, User user, int round) {
        return repository.findByDebateAndUserAndRoundNumber(debate, user, round);
    }
}
