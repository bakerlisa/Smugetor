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
<title>Smugetor - Edit your Smuget</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script type="text/javascript" src="/js/app.js"></script>
	<link href="/fontawesome/css/all.css" rel="stylesheet">
</head>
<body class="expense">
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
    
    <!-- Beginning of Container -->
 	<!-- <div class="banner">
 		<div class="txtWrp">
        	<h1>Add Expenses</h1>
       		<p class="subtitle">Stop being lazy. Everyone's busy and tired, Smugetor will help </p>
       	</div>
     </div> 	 -->
        
	<div class="container"> 
		<h2>Recurring Monthly Expenses</h2>
		<h4>${budget.name}</h4>
		
		<form:form method="post" action="/api/add/expense/${budget.id}" modelAttribute="expense">
 			<span class="wrp flex">	
 				<form:input type="text" path="type" placeholder="Expense..." />
 				<form:errors class="error" path="type"/>
 				<form:input type="number" path="cost" step="0.01" placeholder="$..."/>
 				<form:errors class="error" path="cost"/>
 				<form:input type="hidden" path="budget" value="${budget.id }" />
 				<input class="submit" type="submit" value="Add" />
 			</span>
 		</form:form>
 		
 		<div class="expenseList">
 			<h5>Current Recurring Expenses:</h5>
 			
 			<ul>
 				<c:forEach var="charge" items="${budget.expenses }">
 				<li>${ charge.type} - $${charge.cost }</li>
 				</c:forEach>
 			</ul>
 		</div>
 		<a href="/dashboard" class="button">Full Smuget</a>
    </div> <!-- End of Container -->
    
     <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
</body>
</html>