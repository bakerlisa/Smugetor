package com.codingdojo.project.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.project.models.Budget;
import com.codingdojo.project.models.Temporary;

@Repository
public interface TemporaryRepository extends CrudRepository<Temporary,Long> {
	List<Temporary> findAllByBudget(Budget budget);
}
