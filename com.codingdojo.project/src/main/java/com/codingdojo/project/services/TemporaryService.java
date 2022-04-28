package com.codingdojo.project.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.codingdojo.project.models.Budget;
import com.codingdojo.project.models.Expense;
import com.codingdojo.project.models.Temporary;
import com.codingdojo.project.repositories.TemporaryRepository;

@Service
public class TemporaryService {
	private final TemporaryRepository tempRepo;
	
	public TemporaryService(TemporaryRepository tempRepo) {
		this.tempRepo = tempRepo;
	}
	
	public Temporary createTemp(Temporary temporary) {
		return tempRepo.save(temporary);
	}
	
	public List<Temporary> allTemps(Budget budget){
		return tempRepo.findAllByBudget(budget);
	}
	
	public Temporary oneTemp(Long id) {
		Optional<Temporary> optTemp = tempRepo.findById(id);
		if(optTemp.isPresent()) {
			return optTemp.get();
		}else {
			return null;
		}
	}
	
	public Temporary updateTemporary(Temporary temporary) {
		Optional<Temporary> optTemp = tempRepo.findById(temporary.getId());
		
		if(optTemp.isPresent()) {
			Temporary thisTemp = optTemp.get();
			
			thisTemp.setType(temporary.getType());
			thisTemp.setCost(temporary.getCost()); 
			thisTemp.setTag(temporary.getTag());
			thisTemp.setBudget(temporary.getBudget());
			
			return tempRepo.save(thisTemp);
		}else {
			return null;
		}
	}
	
	public void deleteTemporary(Long id) {
		tempRepo.deleteById(id);
	}
	
}
