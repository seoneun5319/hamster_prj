<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<%
	boolean flag=new Random().nextBoolean();
	pageContext.setAttribute("flag", flag);
	/*
	if(flag){
		response.sendRedirect("jstl_if.jsp");
		return;//을 기술하여 문제가 발생했을 때 아랫줄의 코드를 실행하지 못하도록 막아야한다.
	}//end if
	*/
%>

<c:if test="${flag}">
<c:redirect url="jstl_if.jsp"/>
</c:if>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../common/jsp/external_file.jsp"/>
<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}
</style>
<script type="text/javascript">
$(function(){
	
});//ready


</script>
</head>
<body>
<header data-bs-theme="dark">
<jsp:include page="../common/jsp/header.jsp"/>
</header>
<main>
<div id="container">

</div>
</main>
<footer class="text-body-secondary py-5">
<jsp:include page="../common/jsp/footer.jsp"/>
</footer>
</body>
</html>
<%
System.out.println("---------코드 실행--------");
%>