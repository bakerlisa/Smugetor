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
		<link href="/fontawesome/css/all.css" rel="stylesheet">
	</head>

<body class="temp">
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
    
     <!-- <div class="banner">
    	<div class="txtWrp">	
    		<h1>Temporary Expense</h1>
    		<p class="subtitle">Wait wait wait...you bought what for how much?</p>
    	</div>
 	</div> -->
 	
 	<div class="container">
 		<h2>Temporary Expense</h2>
		 <p style="text-align:center">Expenses Unquie to this month</p>
 		
 		<form:form action="/api/add/temporary/${budget.id }" method="post" modelAttribute="temporary">
 			<div>
 				<span>
 					<form:label path="type">Purchase Label:</form:label>
 					<form:errors path="type" class="error"/>
 				</span>
 				<form:input path="type" type="text" />
 			</div>
 			
 			<div>
 				<span>
 					<form:label path="cost">Cost:</form:label>
 					<form:errors path="cost" class="error"/>
 				</span>
 				<form:input path="cost" type="text" />
 			</div>


			<div>
				<form:label path="category">Category:</form:label>
			   <form:select path="category">
				   <form:option value="">Leave Blank</form:option>
				   <form:option value="birthday">Birthday/Holiday</form:option>
				   <form:option value="clothing">Clothing</form:option>
				   <form:option value="date">Date</form:option>
				   <form:option value="education">Education</form:option>
				   <form:option value="entertainment">Entertainment</form:option>
				   <form:option value="food">Food</form:option>
				   <form:option value="kids">Kids</form:option>
				   <form:option value="miscellaneous">Miscellaneous</form:option>
				   <form:option value="pet">Pet</form:option>
				   <form:option value="tax">Taxes</form:option>
				   <form:option value="transportation">Transportation</form:option>
				   <form:option value="travel">Travel</form:option>
			   </form:select>
			</div>
 			<input type="hidden" name="budget" value="${budget.id }" />
 			<input type="submit" value="Add" class="submit"/>
 		</form:form>
 	
			<div class="expenseList">
 				<h5>Current Recurring Expenses:</h5>
 			
 				<ul>
 					<c:forEach var="charge" items="${budget.temps }">
 						<li>${ charge.type} - $${charge.cost }</li>
 					</c:forEach>
 				</ul>
 			</div>
 			<a href="/dashboard" class="button">Full Smuget</a>
 		</div>
 	
	 <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
    
    <script type="text/javascript" src="/js/script.js"></script>
</body>
</html>