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
	<title>Smugetor - Login and Registor</title>
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<link href="/fontawesome/css/all.css" rel="stylesheet">
</head>
<body class="home">
        <h1 class="logo">Smugetor</h1>
        <p class="define">[ smug - e - tor]</p>
        <p class="definition">Tired of feeling like a fish out of water? Tired of missing birthdays and holidays, because it doesn't fit your budget? Are budget's too strict? Try Smugetor, the budget that lets you smuge your budge a bit</p>
        <div class="button-wrapper">
        		<div class="btn btn-orange" onClick="onPopup('loginWrap')">Login</div>
        		<div class="btn btn-green" onClick="onPopup('registorWrap')">Register</div>
        </div>
        
        <div  class="registorWrap ${register }">
				<i class="fa fa-times" aria-hidden="true" onClick="onPopupRemove('registorWrap')"></i>
				<h2>Become a Smuget Lord</h2>
				<form:form method="post" action="/api/register" modelAttribute="newUser" >
					<div>
						<form:input path="firstName" type="text" placeholder="First Name:" />
						<form:errors path="firstName" class="error" />
					</div>
					<div>
						<form:input path="lastName" type="text"  placeholder="Last Name:" />
						<form:errors path="lastName" class="error" />
					</div>
					
					<div>
						<form:input path="email" type="email" placeholder="Email:" />
						<form:errors path="email" class="error" />
					</div>
					
					<div>
						<form:input path="password" type="password" placeholder="Password:"/>
						<form:errors path="password" class="error" />
					</div>
					
					<div>
						<form:input path="confirm" type="password" placeholder="Confirm Password:" />
						<form:errors path="confirm" class="error" />
					</div>
					
					<input type="submit" value="Register" class="submit" />
				</form:form>
			</div>
			<div  class="loginWrap ${login }">
				<i class="fa fa-times" aria-hidden="true" onClick="onPopupRemove('loginWrap')"></i>
				<h2>Already a Smuget Lord!</h2>
				
				<form:form method="post" action="/api/login" modelAttribute="newLogin">
					<div>
						<form:input path="email" type="email" placeholder="Email:" />
						<form:errors path="email" class="error"/>
					</div>
					<div>
						<form:input path="password" type="password" placeholder="Password:"/>
						<form:errors path="password" class="error"/>
					</div>
					
					<input type="submit" value="Login" class="submit" />
				</form:form>
			</div>
	<script type="text/javascript" src="/js/script.js"></script>
</body>
</html>