package com.aisocial.platform.service;

import com.aisocial.platform.entity.FactCheck;
import com.aisocial.platform.entity.DebateArgument;
import com.aisocial.platform.repository.FactCheckRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@Transactional
public class FactCheckService {

    private final FactCheckRepository factCheckRepository;

    public FactCheckService(FactCheckRepository factCheckRepository) {
        this.factCheckRepository = factCheckRepository;
    }

    public FactCheck save(FactCheck factCheck) {
        return factCheckRepository.save(factCheck);
    }

    public Optional<FactCheck> findById(UUID id) {
        return factCheckRepository.findById(id);
    }

    public List<FactCheck> findByDebateArg(DebateArgument debateArg) {
        return factCheckRepository.findByDebateArg(debateArg);
    }

    public void delete(FactCheck factCheck) {
        factCheckRepository.delete(factCheck);
    }
}
