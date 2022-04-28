package com.codingdojo.project.repositories;

import java.util.List;

import javax.persistence.Entity;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.project.models.Budget;

@Repository
public interface BudgetRepository extends CrudRepository<Budget, Long> {
	List<Budget> findAll();
	
//	List<Object> findByCreatedateBetween(LocalDate start,LocalDate end);
	
//	@Query("select e from Event e where year(e.eventDate) = ?1 and month(e.eventDate) = ?2")
//	List<Budget> getByYearAndMonth(int year, int month);
}
