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
<h2>Welcome.</h2>
Name : <%= request.getParameter("name") %> <br>
Age  : <%= request.getParameter("age") %> <br>

<a href="javascript:history.back()">Go Back</a>
</div>
</main>
<footer class="text-body-secondary py-5">

</footer>
</body>
</html>
