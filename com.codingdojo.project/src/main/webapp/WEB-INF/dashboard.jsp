<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <!-- c:out ; c:forEach ; c:if -->
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
   <!-- Formatting (like dates) -->
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
   <!-- form:form -->
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
   <!-- for rendering errors on PUT routes -->
 <%@ page isErrorPage="true" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smugetor - Personal Dashboard</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link href="/fontawesome/css/all.css" rel="stylesheet">
</head>
<body class="dash">
	<nav>
    	<div>		
    		<a href="/dashboard" class="logo">SMUGETOR</a>
    		<span>${logged.firstName } ${logged.lastName }</span>
    	</div>
    	<div class="navWrp">
    		<a href="/new/smuget" class="tooltip"><i class="fa-solid fa-circle-dollar-to-slot"></i><span class="tooltiptext">New Budget</span></a>
    		<a href="/history" class="tooltip"><i class="fa-solid fa-timeline"></i><span class="tooltiptext">Past Budgets</span></a>
    		<a href="/settings" class="tooltip"><i class="fa fa-cog" aria-hidden="true"></i><span class="tooltiptext">Settings</span></a>
    		<a href="/logout" class="tooltip"><i class="fa fa-sign-out" aria-hidden="true"></i><span class="tooltiptext">Logout</span></a>
    	</div>
    </nav>
    
    <div class="banner">
    	<div class="txtWrp">	
    		<h1>Dash</h1>
    		<p class="subtitle">Quit monkeying around. <br/>Start getting more for less</p>
    	</div>
 	</div>
 	
 	<div class="container">
 		<h2>Current Budget</h2>
 		
 		<c:choose>
  			<c:when test="${logged.budgets.size() > 0}">
				<h4>${budget.name} - <span>$${budget.income}</span></h4>
				<c:set var="salary" scope="session" value="0"/>
				<c:if test = "${logged.budgets.size() > 0}">
         			<div class="expenseWrp title">	
         				<p class="icon"></p>
         				<p class="expense">Expense</p>
         				<p class="amount">Amount</p>
         				<p class="action">Action</p>
         			</div>
         			
         			<c:forEach var="temp" items="${ budget.temporary}">
         				<c:if test = "${temp.tag != 'inactive'}">		
         					<div class="expenseWrp">	
         						<div class="icon"><!-- <i class="fa-solid fa-arrows-rotate"></i> --></div>
         						<p class="expense type"><a href="/temporary/edit/${temp.id }/${budget.id}">${temp.type }</a></p>
         						<p class="amount cost">$${temp.cost }</p>
         						<p class="action"><a href="/temporary/edit/${temp.id }/${budget.id}"><i class="fa-solid fa-pencil"></i></a></p>
         						<c:set var="salary" scope="session" value="${ salary + temp.cost }"/>
         					</div>
         				</c:if>
         			</c:forEach>
         			
         			<c:forEach var="expense" items="${ budget.expenses}">
         				<c:if test = "${expense.tag != 'inactive'}">	
         					<div class="expenseWrp">	
         						<div class="icon"><i class="fa-solid fa-arrows-rotate"></i></div>
         						<p class="expense type"><a href="/expense/edit/${expense.id }/${budget.id}">${expense.type }</a></p>
         						<p class="amount cost">$${expense.cost }</p>
         						<p class="action"><a href="/expense/edit/${expense.id }/${budget.id}"><i class="fa-solid fa-pencil"></i></a></p>
         						<c:set var="salary" scope="session" value="${ salary + expense.cost }"/>
         					</div>
         				</c:if>
         			</c:forEach>
         			
         			
         			
     			</c:if>	
     			
     			<div class="expenseWrp totals">
     				<p class="icon"><!-- <i class="fa-solid fa-equals"></i> --></p>
     				<p class="expense">Unspent:</p>
     				<c:choose>	
     					<c:when test="${budget.income - salary > 0}">
     						<p class="amount positive">$${budget.income - salary}</p>
     					</c:when>
     					
     					<c:otherwise>
     						<p class="amount negative">$${budget.income - salary}</p>
     					</c:otherwise>
     				</c:choose>
     			</div>
     			<div class="button-wrp">
     				<a href="/temporary/${budget.id }" class="button temporary">Create Temporary Expense!</a>
					<a href="/expense/${budget.id }" class="button recurring">Create Recurring Expense!</a>
					<a href="/clear" class="clear">Clear</a>
				</div>
				
  			</c:when> 
  
  			<c:otherwise>
  				<h4>No Smugets...</h4>
  				<a href="/new/smuget" class="button create">Create Smuget!</a>
  			</c:otherwise>
		</c:choose>
		
 	</div>
 	
    <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
    <script type="text/javascript" src="/js/script.js"></script>
    <script src="https://kit.fontawesome.com/402ff570bf.js" crossorigin="anonymous"></script>
</body>
</html>