package com.codingdojo.project.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.project.models.Expense;

@Repository
public interface ExpenseRepository extends CrudRepository<Expense,Long> {
	List<Expense> findAll();
}
