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

<body class="new">
	<nav>
    	<div>		
    		<a href="/dashboard" class="logo">SMUGETOR</a>
    		<span>${userName.firstName } ${userName.lastName }</span>
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
    		<h1>New Smuget</h1>
    		<p class="subtitle">Glad to hear you've stopped picking your nose<br/> and started a smuget!</p>
    	</div>
 	</div>
 	
 	<div class="container">
 		<h2>New Smuget</h2>
 	
 		
 		<form:form action="/api/add/budget" method="post" modelAttribute="budget">
 			<div>
 				<span>
 					<form:label path="name">Dub thy Smuget:</form:label>
 				</span>
 				<form:input path="name" type="text" />
 				<form:errors path="name" class="error"/>
 			</div>
 			
 			<div>
 				<span>
 					<form:label path="income">Monthly Income:</form:label>
 				</span>
 				<form:input path="income" type="text" />
 				<form:errors path="income" class="error"/>
 			</div>
 			
 			<c:choose>
  				<c:when test="${userName.budgets.size() > 0}">
   
 				<div>
 					<label for="copy">Copy a previous months recurring payments: </label>
 					<select name="copy">
 						<option value="0">Leave Blank</option>
 						<c:forEach var="bud" items="${ userName.budgets }">
							<c:choose>
								<c:when test='${bud.tag.equals("on")}'>
									<option class="current" value="${bud.id}">** ${bud.name }</option>
								</c:when>

								<c:otherwise>
									<option value="${bud.id}">${bud.name }</option>
								</c:otherwise>
							  </c:choose>
						 		
 						</c:forEach>
 					</select>
 				</div>
 			</c:when>
 			
 			 <c:otherwise>
 			 	<input type="hidden" name="copy" value="0" />
 			 </c:otherwise>
 			 
		</c:choose>
 			
 			
 			<div class="checkbox">
 				<input type="checkbox" name="tag" checked />
 				<label name="tag">Activate Budget:</label>	
 			</div>
 			
 			<div class="current">
 				<span class="title">Current active budget is: </span>
 				<c:forEach var="buds" items="${userName.budgets }">
 					<c:if test='${buds.tag.equals("on")}'>		
 						<span>${buds.name }</span>
 					</c:if>
 				</c:forEach>
 			</div>

 			<input type="hidden" name="user" value="${userName.id }" />
 			<input type="submit" value="Next" class="submit"/>
 		</form:form>
 	</div>
	
	 <footer>
    	<p>Smugetor™ 2022 - Coding Dojo, Java Stack Project - by: Lisa Broadhead </p>
    </footer>
    
    <script type="text/javascript" src="/js/script.js"></script>
</body>
</html>