package com.codingdojo.project.repositories;

import java.util.List;
import java.util.Optional;

import javax.persistence.Entity;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.project.models.Budget;

@Repository
public interface BudgetRepository extends CrudRepository<Budget, Long> {
	List<Budget> findAll();
	
	Optional<Budget> findByTag(String active);
	
	
	List<Budget> findBySearchDateLike(String data);
}
