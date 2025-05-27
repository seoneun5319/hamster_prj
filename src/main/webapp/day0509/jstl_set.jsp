<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="JSTL 사용"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
변수의 선언
<c:set var="name" value="이장훈"/>
<c:set var="msg" value="<strong>산은 산이요 물은 물이다</strong>"/>
<c:set var="age" value="25"/>
<br>
<c:out value="${name}"/><br>
<strong>출력</strong>
${name}<br>
<%-- 웹 브라우저로 출력할 때에는 <c:out>을 사용한다. %-->
<c:out value="${name}"/><br>
<c:out value="${msg}"/><br>
<c:out value="${msg}" escapeXml="false"/><br>
<%-- 속성 값으로 출력할 때에는 EL만 사용한다. --%>
<input type="text" name="name" value="${name}"/><br>
나이 : <c:out value="${age}"/><br>
<c:remove var="age"/>
삭제 후 나이: <c:out value="${age}"/><br>
</div>
</main>
<footer class="text-body-secondary py-5">
<jsp:include page="../common/jsp/footer.jsp"/>
</footer>
</body>
</html>