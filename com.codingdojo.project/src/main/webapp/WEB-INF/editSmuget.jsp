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
<body class="editBud">
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
    		<h1>Edit Expense </h1>
    		<p class="subtitle">Don't be goosed. 80% of people do budget </p>
    	</div>
    </div> -->
    
    <div class="container"> <!-- Beginning of Container -->
		<h2>Edit Recurring Payment: <span>${exp.type }</span></h2>
        <form:form method="post" action="/api/update/expense/${exp.id }/${bud.id}" modelAttribute="expense">
 			<span class="flex">	
 				<div>
 					<form:input type="text" path="type" placeholder="Expense..."  value="${exp.type }" />
 					<form:errors class="error" path="type"/>
 				</div>
 				<div>	
 					<form:input type="number" path="cost" step="0.01" placeholder="$..." value="${exp.cost }" />
 					<form:errors class="error" path="cost"/>
 				</div>
 				
 				<input type="hidden" name="old" value="${exp.cost }" />
 				<form:input type="hidden" path="id"  value="${exp.id }"/>
 				<form:input type="hidden" path="budget"  value="${bud.id }"/>
 				<input class="submit" type="submit" value="Edit" />
 			</span>
 		</form:form> 
 		
 		<div class="buttonWrp">
 			<a href="/dashboard" class="cancel">Cancel</a>
 			<form action="/delete/expense/${exp.id}" method="post" class="delete">
    			<input type="hidden" name="_method" value="delete">
    			<input type="submit" value="Delete">
			</form>
		</div>
      	
        
        
		
    </div> <!-- End of Container -->
    
     <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
</body>
</html>