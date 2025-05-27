<%@page import="day0512.ProductService"%>
<%@page import="java.lang.reflect.Member"%>
<%@page import="java.util.List"%>
<%@page import="day0512.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:import url="http://192.168.10.95/jsp_prj/common/jsp/external_file.jsp"/>
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
 <c:import url="http://192.168.10.95/jsp_prj/common/jsp/header.jsp"/>

</header>
<main>
<div id="container">
<%
ProductService ps=new ProductService();
pageContext.setAttribute("data", ps.searchPrd());
%>
<c:if test="${ empty data }">
<h2>준비된 상품이 없어요</h2>
<img src="../common/images/img_5.jpg"/>
</c:if>
<c:if test="${not empty data }">
<h2>상품</h2>
<div>
<c:forEach var="prd" items="${data}">
<div class="card" style="width: 18rem; float:left;margin-right: 10px ">
  <img style="width:280px;height: 160px " src="http://localhost/jsp_prj/common/images/${prd.img}" class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title"><c:out value="${prd.prd }"/></h5>
    <p class="card-text"><c:out value="${prd.code}"/></p>
    <p class="card-text"><fmt:formatDate value="${prd.date}" pattern="MM-dd-yyyy a HH:mm"/></p>
    <a href="#void" class="btn btn-primary">
    <fmt:formatNumber value="${prd.price}" pattern="#,###"/>원</a>
  </div>
</div>
</c:forEach>
</div>
</c:if>
</div>
</main>
<footer class="text-body-secondary py-5">
 <c:import url="http://192.168.10.95/jsp_prj/common/jsp/footer.jsp"/>

</footer>


</body>
</html>