<%@page import="kr.co.sist.member.login.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
<c:choose>
<c:when test="${empty sessionScope.userData }">
<a href="login/login_frm.jsp">로그인</a>
</c:when>
<c:otherwise>
<%-- <c:out value="${userData.name }"/> 복호화 필요 --%>
<a href="mypage/mypage_index.jsp" title="마이페이지"><c:out value="${userData.email}"/></a>님
<a href="login/login_frm.jsp">로그아웃</a>
<a href="board/board_list.jsp">게시글보기</a>

</c:otherwise>
</c:choose>
<a href="place/restaurant_list.jsp">맛집 리스트</a>
<a href="member/member_frm.jsp">회원가입</a>
<a href="member/member_list.jsp">회원목록</a>
<a href="file/file_list.jsp">파일목록</a>
<a href="#void">상품소개</a>
<a href="#void">영화소개</a>


</div>
</main>
<footer class="text-body-secondary py-5">
 <c:import url="http://192.168.10.95/jsp_prj/common/jsp/footer.jsp"/>

</footer>


</body>
</html>