<%@page import="kr.co.sist.member.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
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
<%
//1. 한글처리
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mDTO" class="kr.co.sist.member.MemberDTO" scope="page"/>
<jsp:setProperty property="*" name="mDTO"/>
<%
	mDTO.setIp(request.getRemoteAddr());

	MemberService ms=new MemberService();
	//비연결성인 웹에서 한정적인 자원을 먼저 선점하는 접속자 이외에는 
	//"해당 자원을 다른 접속자가 사용 중입니다."를 제공해야한다.
	boolean flag=ms.searchId(mDTO.getId());
	
	if(!flag){
	pageContext.setAttribute("addResult", ms.addMember(mDTO));
	
%>

<c:choose>
<c:when test="${ addResult }">
<%-- 회원가입 성공 --%>
<div style="position: relative;">

<div style="margin:0px auto; background:#FFFFFF url('images/member_success.png'); position: relative; width:606px; height:378px;">
<div style="position: absolute; top:170px; left:160px; font-size:25px">
<strong><c:out value="${param.name}"/>님</strong>
</div>
<div style="position: absolute; top:270px; left:250px; font-size:25px">
<a href="javascript:location.replace('http://192.168.10.95/jsp_prj/index.html')" class="btn btn-dark">메인화면</a>
</div>
</div>
</div>
</c:when>
<c:otherwise>
<%-- 회원가입 실패 --%>
<h2>회원가입이 정상적으로 이루어지지 않았습니다.</h2>
<img src="images/member_fail.png">
<h3>잠시 후 다시 시도해주세요.</h3>
<a href="http://192.168.10.95/jsp_prj/index.html">메인화면</a>
<a href="javascript:history.back()">다시 시도</a>
</c:otherwise>
</c:choose>
<%}else{ %>
	<c:out value="${param.id }"/>는 이미 사용 중입니다.<br>
	<a href="javascript:history.back()">다시 시도</a>
<%}//end if %>

</div>
</main>
<footer class="text-body-secondary py-5">
  <jsp:include page="../common/jsp/footer.jsp"/>
  
</footer>


</body>
</html>