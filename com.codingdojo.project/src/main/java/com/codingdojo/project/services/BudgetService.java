package com.codingdojo.project.services;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.codingdojo.project.models.Budget;
import com.codingdojo.project.repositories.BudgetRepository;

@Service
public class BudgetService {
	private final BudgetRepository budRepo;
	
	public BudgetService(BudgetRepository budRepo) {
		this.budRepo = budRepo;
	}
	
	public Budget oneBudget(Long id) {
		Optional<Budget> optBud = budRepo.findById(id);;
		if(optBud.isPresent()) {
			return optBud.get();
		}else {
			return null;
		}
	}
	
	public Budget createBudget(Budget budget) {
		return budRepo.save(budget);
	}
	
//	public Budget searchBudget(int year, String month) {
//		return budRepo
//	}
	
}
