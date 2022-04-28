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
<body class="history">
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
    		<h1>History</h1>
    		<p class="subtitle">Stop fussing. It's only bad if<br/> you didn't follow the budget </p>
    	</div>
 	</div>
 	
 	<div class="container">
 		<h2>Search by Month and Year</h2>
 		<form method="post" action="/api/search" class="search-budget">
 			<select name="month">
 				<option value="01">January</option>
 				<option value="02">February</option>
 				<option value="03">March</option>
 				<option value="04">April</option>
 				<option value="05">May</option>
 				<option value="06">June</option>
 				<option value="07">July</option>
 				<option value="08">August</option>
 				<option value="09">September</option>
 				<option value="10">October</option>
 				<option value="11">November</option>
 				<option value="12">December</option>
 			</select>
 			<input type="number" name="year" class="year" placeholder="Year..." />
 			<input type="submit" value="Search" class="submit"/>
 		</form>
 	</div>
 	
    <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
    <script type="text/javascript" src="/js/script.js"></script>
    <script src="https://kit.fontawesome.com/402ff570bf.js" crossorigin="anonymous"></script>
</body>
</html>