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
 		<h2>Current Budget </h2>
		<c:set var="budgetsTrue" scope="session" value="false"/>
  				
 		
 		<c:choose>
  				<c:when test="${logged.budgets.size() > 0}">
 					<c:forEach var="bud" items="${logged.budgets }">
 						<c:choose>
  							<c:when test="${bud.tag.equals('on')}">
  							<c:set var="budgetID" scope="session" value="${bud.id}"/>
  								<c:set var="budgetsTrue" scope="session" value="true"/>
  								<h4>${bud.name } - <span>$${bud.income}</span></h4>
  								
  								<div class="expenseWrp title">	
         							<p class="icon"></p>
         							<p class="expense">Expense</p>
         							<p class="amount">Amount</p>
         							<p class="action">Action</p>
         						</div>
         						
         						<!--  Temporary expenses -->
         						<c:forEach var="temp" items="${ bud.temps}">
         							<div class="expenseWrp">	
         								<div class="icon">
											<c:choose>
												<c:when test="${temp.category.equals('birthday')}">
													<i class="fa-solid fa-gift"></i>
												</c:when>

												<c:when test="${temp.category.equals('clothing')}">
													<i class="fa-solid fa-shirt"></i>
												</c:when>

												<c:when test="${temp.category.equals('date')}">
													<i class="fa-solid fa-champagne-glasses"></i>
												</c:when>

												<c:when test="${temp.category.equals('education')}">
													<i class="fa-solid fa-book"></i>
												</c:when>

												<c:when test="${temp.category.equals('entertainment')}">
													<i class="fa-solid fa-film"></i>
												</c:when>

												<c:when test="${temp.category.equals('food')}">
													<i class="fa-solid fa-apple-whole"></i>
												</c:when>

												<c:when test="${temp.category.equals('kids')}">
													<i class="fa-solid fa-children"></i>
												</c:when>

												<c:when test="${temp.category.equals('miscellaneous')}">
													<i class="fa-solid fa-cart-shopping"></i>
												</c:when>

												<c:when test="${temp.category.equals('pet')}">
													<i class="fa-solid fa-dog"></i>
												</c:when>

												<c:when test="${temp.category.equals('tax')}">
													<i class="fa-solid fa-sack-dollar"></i>
												</c:when>

												<c:when test="${temp.category.equals('transportation')}">
													<i class="fa-solid fa-car"></i>
												</c:when>

												<c:when test="${temp.category.equals('travel')}">
													<i class="fa-solid fa-plane"></i>
												</c:when>
											</c:choose>

										 </div>
         								<p class="expense type"><a href="/temporary/edit/${temp.id }/${budgetID}">${temp.type }</a></p>
         								<p class="amount cost">$${temp.cost }</p>
         								<p class="action"><a href="/temporary/edit/${temp.id }/${budgetID}"><i class="fa-solid fa-pencil"></i></a></p>
         							</div>
         						</c:forEach>
         						
         						<!--  Monlthy expenses -->
         						<c:forEach var="expense" items="${ bud.expenses}">
         							<div class="expenseWrp">	
         								<div class="icon"><i class="fa-solid fa-arrows-rotate"></i></div>
         								<p class="expense type"><a href="/expense/edit/${expense.id }/${budgetID}">${expense.type }</a></p>
         								<p class="amount cost">$${expense.cost }</p>
         								<p class="action"><a href="/expense/edit/${expense.id }/${budgetID}"><i class="fa-solid fa-pencil"></i></a></p>
         						
         							</div>					
         						</c:forEach>
         						
         						<!--  Generates Total -->
         						<div class="expenseWrp totals">
     								<p class="icon"><!-- <i class="fa-solid fa-equals"></i> --></p>
     								<p class="expense">Unspent:</p>
     								<c:choose>	
     									<c:when test="${bud.outcome > 0}">
     										<p class="amount positive">$${bud.outcome}</p>
     									</c:when>
     					
     									<c:otherwise>
     										<p class="amount negative">$${bud.outcome}</p>
     									</c:otherwise>
     								</c:choose>
     							</div>
     							
     							<!-- Buttons  -->
     							<div class="button-wrp">
     								<a href="/temporary/${bud.id }" class="button temporary">Create Temporary Expense!</a>
									<a href="/expense/${bud.id }" class="button recurring">Create Recurring Expense!</a>
									<a href="/clear" class="clear">Clear</a>
								</div>
         					
  							</c:when> 
  						</c:choose>
 					</c:forEach>
 					
 					
 				</c:when>
 		</c:choose>
 		
 		<c:if test = "${budgetsTrue == false}">	
 			<h4>No Active Smuget</h4>
  			<a href="/new/smuget" class="button create">Create Smuget!</a>
  			<!-- //put a  -->
  		</c:if>
 		
 		
 	</div>
 	
    <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
    <script type="text/javascript" src="/js/script.js"></script>
    <script src="https://kit.fontawesome.com/402ff570bf.js" crossorigin="anonymous"></script>
</body>
</html>