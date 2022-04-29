package com.codingdojo.project.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.codingdojo.project.models.Budget;
import com.codingdojo.project.models.Expense;
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
	
	public void removeCurrentActive(String active) {
		Optional<Budget> optBud = budRepo.findByTag(active);
		if(optBud.isPresent()) {
			Budget thisBud = optBud.get();
			thisBud.setTag(null);
			budRepo.save(thisBud);
		}
	}
	
	public Budget updateIncome(Budget budget) {
		Optional<Budget> optBud = budRepo.findById(budget.getId());
		if(optBud.isPresent()) {
			Budget thisBud = optBud.get();
			
			thisBud.setIncome(budget.getIncome());
			
			return budRepo.save(thisBud);
			
		}else {
			return null;
		}
	}
	
	public List<Budget> findSearchResults(String data){
		return budRepo.findBySearchDateLike(data);
	}
	
	public Budget updateBudgetSearchDate(Budget budget) {
		Optional<Budget> optBud = budRepo.findById(budget.getId());
		if(optBud.isPresent()) {
			Budget thisBud = optBud.get();
			
			thisBud.setSearchDate(budget.getSearchDate());
			
			return budRepo.save(thisBud);
			
		}else {
			return null;
		}
	}
}
