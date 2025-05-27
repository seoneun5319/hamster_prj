<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../common/jsp/external_file.jsp"></jsp:include>
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
<h2>어서오세여</h2>
이름 : <%= request.getParameter("name") %> <br>
나이 : <%= request.getParameter("age") %> <br>
<%-- 이전 페이지에서 <jsp:param name="language" value="<%= lang %>"/> --%>
사용언어 : <%= request.getParameter("language") %> <br>
접속ip : <%= request.getAttribute("ip") %> <br>
<a href="javascript:history.back()">뒤로</a>
</div>
</main>
<footer class="text-body-secondary py-5">

</footer>


</body>
</html>