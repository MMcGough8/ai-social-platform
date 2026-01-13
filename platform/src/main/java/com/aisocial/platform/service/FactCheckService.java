package com.aisocial.platform.service;

import com.aisocial.platform.entity.DebateArgument;
import com.aisocial.platform.entity.FactCheck;
import com.aisocial.platform.entity.Post;
import com.aisocial.platform.entity.User;
import com.aisocial.platform.repository.FactCheckRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class FactCheckService {

    private final FactCheckRepository repository;

    public FactCheckService(FactCheckRepository repository) {
        this.repository = repository;
    }

    public FactCheck save(FactCheck factCheck) {
        return repository.save(factCheck);
    }

    public Optional<FactCheck> findById(UUID id) {
        return repository.findById(id);
    }

    public List<FactCheck> findByPost(Post post) {
        return repository.findByPost(post);
    }

    public List<FactCheck> findByDebateArg(DebateArgument arg) {
        return repository.findByDebateArg(arg);
    }

    public List<FactCheck> findByRequestedBy(User user) {
        return repository.findByRequestedBy(user);
    }
}
