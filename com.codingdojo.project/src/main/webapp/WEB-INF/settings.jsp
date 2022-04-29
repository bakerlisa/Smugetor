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
<title>Smugetor - Personal Settings</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
	<script type="text/javascript" src="/js/app.js"></script>
	<link href="/fontawesome/css/all.css" rel="stylesheet">
</head>
<body class="settings">
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
    		<h1> Edit Settings </h1>
    		<p class="subtitle">Yup. I feel you bear, welcome to adulthood</p>
    	</div>
		<div class="formWrp">
			<h3>Edit Settings:</h3>
			<form:form method="post" action="/api/update/user" modelAttribute="user" >
				<div>
					<form:input path="firstName" type="text" placeholder="First Name:" value="${logged.firstName }"/>
					<form:errors path="firstName" class="error" />
				</div>
				<div>
					<form:input path="lastName" type="text"  placeholder="Last Name:"  value="${logged.lastName }"/>
					<form:errors path="lastName" class="error" />
				</div>
						
				<div>
					<form:input path="email" type="email" placeholder="Email:"  value="${logged.email }"/>
					<form:errors path="email" class="error" />
				</div>
				
				<form:input path="password" type="hidden" value="${logged.password }"/>
				<form:input path="confirm" type="hidden" value="${logged.password }"/>
				<input type="hidden" name="id" value="${logged.id }" />
				<input type="submit" value="Update" class="submit" />
			</form:form>
		</div>
    </div>
    	
    <%-- <div class="container">
    	
		
		
		<h2>Update Password:</h2>
		<form:form method="post" action="/api/update/password" modelAttribute="password" >
			<div>
				<form:input path="password" type="password" placeholder="Password" />
				<form:errors path="password" class="error" />
			</div>
			<div>
				<form:input path="confirm" type="password"  placeholder="Confirm Password"/>
				<form:errors path="confirm" class="error" />
			</div>
			
			
			<input name="lastName" type="hidden" value="${logged.firstName }"/>
			<input name="lastName" type="hidden" value="${logged.lastName }"/>
			<input name="email" type="hidden" value="${logged.email }"/>
			<input name="id" type="hidden" value="${logged.id }" />
			<input type="submit" value="Update" class="submit" />
		</form:form> 
    </div>--%>
    
 	<footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
</body>
</html>