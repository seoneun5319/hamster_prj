<%@page import="kr.co.sist.place.RestDTO"%>
<%@page import="kr.co.sist.place.PlaceService"%>
<%@page import="kr.co.sist.board.BoardUtil"%>
<%@page import="kr.co.sist.board.PaginationDTO"%>
<%@page import="kr.co.sist.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.sist.board.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ include file="../common/jsp/site_config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="rDTO" class="kr.co.sist.board.RangeDTO" scope="page"/>
<jsp:setProperty name="rDTO" property="*"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${site_name}"/></title>
<c:import url="${url}/common/jsp/external_file.jsp"/>
<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}
 a{text-decoration: none; color:#333}
 a:hover{color:#5A90D0;}
</style>

<script type="text/javascript">
$(function(){
   $("#btnSearch").click(function () {
   var keyword=$("#keyword").val();
   if(keyword==""){
      alert("검색 키워드는 필수 입력")
      return;
   }//end if
   $("#searchFrm").submit();
});//click
});//ready


</script>
</head>
<body>
<header data-bs-theme="dark">
<c:import url="${url}/common/jsp/header.jsp"/>
</header>
<main>
<div id="container">
<div style="width:1200px">
<h3>맛집리스트</h3>
<div id="boardWrap" style="margin:0px auto; width:1200px; height: 540px">
<%
PlaceService ps = new PlaceService();
int totalCount=0;//총 게시물의 수
totalCount=ps.totalCount(rDTO);
pageContext.setAttribute("totalCount", totalCount);

int pageScale=0;
pageScale=ps.pageScale();
pageContext.setAttribute("pageScale", pageScale);

int totalPage=0;
totalPage=ps.totalPage(totalCount, pageScale);
pageContext.setAttribute("totalPage", totalPage);

String tempPage=request.getParameter("currentPage");

int startNum;//시작번호
startNum=ps.startNum(pageScale, rDTO);
pageContext.setAttribute("startNum", rDTO.getStartNum());

int endNum;//끝 번호
endNum=ps.endNum(pageScale,rDTO);
pageContext.setAttribute("endNum", rDTO.getEndNum());

List<RestDTO> restList=ps.searchRestaurant(rDTO);
pageContext.setAttribute("restList", restList);


pageContext.setAttribute("fieldText", rDTO.getFieldText());
%>
맛집 전체 : <c:out value="${totalPage }"/>건

<div style="text-align: right;">
<a href="write_rest_frm.jsp "class="btn btn-info">당신의 맛집</a> 
</div>
<table class="table table-hover">
<thead>
<tr style="text-align: center">
<th style="width:80px">번호</ths>
<th style="width:350px">식당명</th>
<th style="width:320px">메인메뉴</th>
<th style="width:100px">작성자</th>
<th style="width:200px">작성일</th>
</tr>
</thead>
<tbody>
<c:if test="${empty restList}">
<tr>
<td colspan="5" style="text-align: center">
등록된 맛집이 없습니다.<br>
<img src="../login/images/login_fail.jpg" style="width: 60px">
<br>
<a href="write_rest_frm.jsp">맛집등록하기</a>
</td>
</tr>
</c:if>
<%
StringBuilder searchQueryString = new StringBuilder();
if(rDTO.getKeyword()!=null&&!rDTO.getKeyword().isEmpty()){
   searchQueryString.append("&field=").append(rDTO.getField())
   .append("&keyword=").append(rDTO.getKeyword());
}//end if

pageContext.setAttribute("queryStr", searchQueryString);
%>

<c:forEach var="restDTO" items="${restList}" varStatus="i">
<tr style="text-align: center">
<td><c:out value="${totalCount-(rDTO.currentPage-1)*pageScale-i.index}"/></td>
<td><a href="rest_detail.jsp?num=${restDTO.rest_num }&currentPage=${rDTO.currentPage}${queryStr}"><c:out value="${restDTO.restaurant}"/></a></td>
<td><c:out value="${restDTO.menu}"/></td>
<td><c:out value="${restDTO.id}"/></td>
<td><fmt:formatDate value="${restDTO.input_date}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>

</tr>
</c:forEach>
</tbody>
</table>
</div>
<div id="searchDiv" style="text-align: center; margin-top: 30px" >
<form action="restaurant_list.jsp" method="get" id="searchFrm">
<select name="field" id="field">
<c:forEach var="field" items="${fieldText}" varStatus="i">
<option value="${i.index}"><c:out value="${field}"/></option>
</c:forEach>
</select>
<input type="text" name="keyword" id="keyword">
<input type="text" style="display: none">
<input type="button" value="검색" id="btnSearch" class="btn btn-success btn-sm">
</form>
</div>
<%-- <div id="pagenationDiv">
<c:forEach var="i" begin="1" end="${totalPage}" step="1">
[<a href="board_list.jsp?currentPage=${i}"><c:out value="${i}"/></a>]
</c:forEach>
</div> --%>

<div id="pagenationDiv" style="text-align:center">

<%
PaginationDTO pDTO=new PaginationDTO(3, rDTO.getCurrentPage(), totalPage,"restaurant_list.jsp",
		rDTO.getField(),rDTO.getKeyword());
%>
<%=BoardUtil.pagination(pDTO) %>
</div>
</div>
</div> 
</main>
<footer class="text-body-secondary py-5">
<c:import url="${url}/common/jsp/footer.jsp"/>
</footer>


</body>
</html>