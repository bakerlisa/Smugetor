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
<body class="indvhistory">
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
 	
 	<div class="container">
 		<a href="/history" class="back"> < Back</a>
 		<h1>History - <span>${budget.name }</span></h1>
 		<p class="date"><fmt:formatDate value="${budget.createdAt }" pattern="MMMMM"/> <fmt:formatDate value="${budget.createdAt }" pattern="y"/> </p>
 		<div class="expenseList">
 			<div class="expenseWrp title">	
         		<p class="icon"></p>
         		<p class="expense">Expense</p>
         		<p class="amount">Amount</p>
        	</div>
         
 			<!--  Temporary expenses -->
         	<c:forEach var="temp" items="${ budget.temps}">
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
         			<p class="expense type">${temp.type} </p>
         			<p class="amount cost">$${temp.cost }</p>
         		</div>
         	</c:forEach>
         						
         	<!--  Monlthy expenses -->
         	<c:forEach var="expense" items="${ budget.expenses}">
         		<div class="expenseWrp">	
         			<div class="icon"><i class="fa-solid fa-arrows-rotate"></i></div>
         			<p class="expense type">${expense.type }</p>
         			<p class="amount cost">$${expense.cost }</p>
         		</div>					
         	</c:forEach>	
 		</div>
 		
 		<div class="expenseWrp totals">
     		<p class="icon"></p>
     		<p class="expense">Unspent:</p>
     		<c:choose>	
     			<c:when test="${budget.outcome > 0}">
     				<p class="amount positive">$${budget.outcome}</p>
     			</c:when>
     					
     			<c:otherwise>
     				<p class="amount negative">$${budget.outcome}</p>
     			</c:otherwise>
     		</c:choose>
     	</div>
 		
 	</div>
 	
    <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
    <script type="text/javascript" src="/js/script.js"></script>
    <script src="https://kit.fontawesome.com/402ff570bf.js" crossorigin="anonymous"></script>
</body>
</html>