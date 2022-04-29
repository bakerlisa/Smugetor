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
<body class="search">
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
    		<h1>Seach History</h1>
    		<p class="subtitle">Whoa! Whoa! Whoa! Nobody freak out! </p>
    	</div>
 	</div>
 	
 	<div class="container">
 		<h2>Results: </h2>
 		<p>Work in progress!</p>
 		${allBugets.size()}
 		<div class="pervious">
 			<div class="allBudWrp">
 				<c:choose>
  					<c:when test="${logged.budgets.size() > 0}">
 						<c:forEach var="bud" items="${logged.budgets }">
 							<a href="/history/${bud.id }" class="budgetsIndv">	
 								<p class="title" >${bud.name }</p>
 								<p class="amount">
 									<c:choose>
  										<c:when test="${bud.outcome > 0 }">
											<i class="fa-solid fa-caret-up"></i>
  										</c:when>
  										
  										<c:otherwise>
  											<i class="fa-solid fa-caret-down"></i>
										</c:otherwise>
									</c:choose>
 									Budget: $${bud.income }
 								</p>
 								<p><fmt:formatDate value="${bud.createdAt }" pattern="MMMMM"/> <fmt:formatDate value="${bud.createdAt }" pattern="y"/> </p>
							</a>
 						</c:forEach>
 					</c:when>
 				</c:choose>
 			</div>
 		
 		</div>
 	</div>
 	
    <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
    <script type="text/javascript" src="/js/script.js"></script>
    <script src="https://kit.fontawesome.com/402ff570bf.js" crossorigin="anonymous"></script>
</body>
</html>