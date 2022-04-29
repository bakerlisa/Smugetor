package com.codingdojo.project.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.codingdojo.project.models.Budget;
import com.codingdojo.project.models.Expense;
import com.codingdojo.project.models.User;
import com.codingdojo.project.repositories.ExpenseRepository;

@Service
public class ExpenseService {
	private final ExpenseRepository expRepo;
	
	public ExpenseService(ExpenseRepository expRepo) {
		this.expRepo = expRepo;
	}
	
	public List<Expense> allExpenses(){
		return expRepo.findAll();
	}
	
	public Expense createExpense(Expense expense) {
		return expRepo.save(expense);
	}
	
	public Expense oneExpense(Long id) {
		Optional<Expense> optExp = expRepo.findById(id);;
		if(optExp.isPresent()) {
			return optExp.get();
		}else {
			return null;
		}
	}
	
	public Expense updateExpense(Expense expense) {
		Optional<Expense> optExp = expRepo.findById(expense.getId());
		if(optExp.isPresent()) {
			Expense thisExp = optExp.get();
			
			thisExp.setCost(expense.getCost()); 
			thisExp.setType(expense.getType());
			thisExp.setTag(expense.getTag());
			thisExp.setBudget(expense.getBudget());
			
			return expRepo.save(thisExp);
		}else {
			return null;
		}
	}
	
	public void deleteExpense(Long id) {
		expRepo.deleteById(id);
	}
	

}
