package com.codingdojo.project.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="temporary")
public class Temporary {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@NotNull
	@Size(min=2,max=100,message="Expense needs a name")
	private String type;
	
	@NotNull(message="Cost cannot be empty")
	@Min(0)
	private double cost;
	
	private String tag;
	
	private String category; 
	
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
	
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    // ================================ RELATIPNSHIPS ================================
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="budget_id")
    private Budget budget;
    
    // ================================ CONSTRUCTORS ================================
    public Temporary() {
		super();
	}
    
	public Temporary(Long id, @NotNull @Size(min = 2, max = 100, message = "Expense needs a name") String type,
			@NotNull(message = "Cost cannot be empty") @Min(0) double cost, String tag, String category, Date createdAt,
			Date updatedAt, Budget budget) {
		super();
		this.id = id;
		this.type = type;
		this.cost = cost;
		this.tag = tag;
		this.category = category;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.budget = budget;
	}

	public Temporary(@NotNull @Size(min = 2, max = 100, message = "Expense needs a name") String type,
			@NotNull(message = "Cost cannot be empty") @Min(0) double cost, String tag, String category,
			Budget budget) {
		super();
		this.type = type;
		this.cost = cost;
		this.tag = tag;
		this.category = category;
		this.budget = budget;
	}

	public Temporary(@NotNull @Size(min = 2, max = 100, message = "Expense needs a name") String type,
			@NotNull(message = "Cost cannot be empty") @Min(0) double cost, String tag, String category) {
		super();
		this.type = type;
		this.cost = cost;
		this.tag = tag;
		this.category = category;
	}

	// ================================ GETTERS / SETTERS ================================
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public double getCost() {
		return cost;
	}

	public void setCost(double cost) {
		this.cost = cost;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public Budget getBudget() {
		return budget;
	}

	public void setBudget(Budget budget) {
		this.budget = budget;
	}
	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
	@PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
}

