<%@page import="kr.co.sist.file.FileService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ include file="../common/jsp/site_config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${site_name}"/></title>
<c:import url="${url}/common/jsp/external_file.jsp"/>
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
<c:import url="${url}/common/jsp/header.jsp"/>
</header>
<main>
<div id="container">

<div>
<div><h3>업로드 파일목록</h3></div>
<div>
<%
FileService fs=new FileService();
pageContext.setAttribute("fileList", fs.fileList());
%>
<table class="table table-hover">
<thead>
<tr>
	<th>번호</th>
	<th>파일명</th>
	<th>파일크기(byte)</th>
	<th>업로드일</th>
</tr>
</thead>
<tbody>
<c:if test="${ empty fileList }">
<tr>
<td colspan="4" style="text-align: center">업로드된 파일이 없습니다.</td>
</tr>
</c:if>
<c:forEach var="file" items="${ fileList }" varStatus="i">
<tr>
<td><c:out value="${ i.count }"/></td>
<td><a href="download.jsp?fileName=${file.fileName}"><c:out value="${ file.fileName }"/></a></td>
<td><c:out value="${ file.length }"/></td>
<td><fmt:formatDate value="${ file.lastModified }" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>

</div>
</main>
<footer class="text-body-secondary py-5">
<c:import url="${url}/common/jsp/footer.jsp"/>
</footer>


</body>
</html>