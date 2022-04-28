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
<body class="clear">
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
    		<h1>Clear</h1>
    		<p class="subtitle"> </p>
    	</div>
 	</div>
 	
 	
 	<div class="container">
 		<h2>New Budget</h2>
 		<p>Old Smuget has been cleared! Create a new Smuget</p>
 		<form:form method="post" action="/api/add/budget" modelAttribute="bud">
 			<div>
 				<span>
 					<form:label path="name">Name </form:label>
 					<form:errors path="name" class="error"/>
 				</span>
 				<form:input path="name" value="${ bud.name}"/>
 			</div>
 			
 			<input type="submit" value="Create" class="submit" />
 		</form:form>
 		
 		<c:forEach var="expense" items="${ bud.expenses}">
         	<div>	
         		<p>${expense.type }</p>
         		<p class="amount cost">$${expense.cost }</p>
         	</div>
         </c:forEach>
 	</div>
 	
    <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
    <script type="text/javascript" src="/js/script.js"></script>
    <script src="https://kit.fontawesome.com/402ff570bf.js" crossorigin="anonymous"></script>
</body>
</html>