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
<%@ include file="../common/jsp/login_chk.jsp"  %> 
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
<h3>자유 게시판</h3>
<div id="boardWrap" style="margin:0px auto; width:1200px; height: 540px">
<%
BoardService bs = new BoardService();
int totalCount=0;//총 게시물의 수
totalCount=bs.totalCount(rDTO);
pageContext.setAttribute("totalCount", totalCount);

int pageScale=0;
pageScale=bs.pageScale();
pageContext.setAttribute("pageScale", pageScale);

int totalPage=0;
totalPage=bs.totalPage(totalCount, pageScale);
pageContext.setAttribute("totalPage", totalPage);

String tempPage=request.getParameter("currentPage");

int startNum;//시작번호
startNum=bs.startNum(pageScale, rDTO);
pageContext.setAttribute("startNum", rDTO.getStartNum());

int endNum;//끝 번호
endNum=bs.endNum(pageScale,rDTO);
pageContext.setAttribute("endNum", rDTO.getEndNum());

List<BoardDTO> boardList=bs.searchBoard(rDTO);
pageContext.setAttribute("boardList", boardList);

session.setAttribute("cntFlag", true);

pageContext.setAttribute("fieldText", rDTO.getFieldText());
%>
전체 : <c:out value="${totalPage }"/>페이지<br>
현재 : <c:out value="${rDTO.currentPage }"/>페이지
<%-- 총 게시물의 수 : ${totalCount }<br>
한 화면에 보여줄 게시물 수 : ${pageScale }<br>
총 페이지 수 : ${totalPage}<br>
시작번호 : ${startNum}<br>
끝번호 : ${endNum}<br> --%>
<div style="text-align: right;">
<a href="write_frm.jsp "class="btn btn-info">글 작성</a> 
</div>
<table class="table table-hover">
<thead>
<tr style="text-align: center">
<th style="width:80px">번호</th>
<th style="width:650px">제목</th>
<th style="width:120px">작성자</th>
<th style="width:200px">작성일</th>
<th style="width:100px">조회수</th>
</tr>
</thead>
<tbody>
<c:if test="${empty boardList}">
<tr>
<td colspan="5" style="text-align: center">
게시물이 없습니다<br>
<img src="../login/images/login_fail.jpg" style="width: 60px">
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

<c:forEach var="bDTO" items="${boardList}" varStatus="i">
<tr>
<td><c:out value="${totalCount-(rDTO.currentPage-1)*pageScale-i.index}"/></td>
<td><a href="board_detail.jsp?num=${bDTO.num }&currentPage=${rDTO.currentPage}${queryStr}"><c:out value="${bDTO.subject}"/></a></td>
<td><c:out value="${bDTO.id}"/></td>
<td><fmt:formatDate value="${bDTO.input_date}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
<td><c:out value="${bDTO.cnt}"/></td>

</tr>
</c:forEach>
</tbody>
</table>
</div>
<div id="searchDiv" style="text-align: center; margin-top: 30px" >
<form action="board_list.jsp" method="get" id="searchFrm">
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
<%-- <div id="paginationDiv">
<c:forEach var="i" begin="1" end="${totalPage}" step="1">
[<a href="board_list.jsp?currentPage=${i}"><c:out value="${i}"/></a>]
</c:forEach>
</div> --%>

<div id="paginationDiv">
<%-- <%

int pageNumber=3;//한 화면에 보여줄 페이지 인덱스의 수
//2. 화면에 보여줄 시작페이지 번호
int startPage=((rDTO.getCurrentPage()-1)/pageNumber)*pageNumber+1;//1,2,3 =>1 , 4,5,6=>2
//3. 화면에 보여줄 마지막 번호
int endPage=(((startPage-1)+pageNumber)/pageNumber)*pageNumber;
//4. 총 페이지수가 연산된 마지막 페이지 수보다 총 페이지수가 마지막 페이지 수로 설정
if(totalPage <= endPage){
	endPage=totalPage;
}
//5. 첫 페이지가 인덱스 화면이 아닌 경우
int movePage=0;
StringBuilder prevMark = new StringBuilder("[ <span class='pagiPrevMark'>&lt;&lt;</span> ]");
if(rDTO.getCurrentPage() > pageNumber){//시작페이지보다 1적은 페이지로 이동
	prevMark.delete(0, prevMark.length());
	movePage=startPage-1;
	prevMark.append("[ <a href='board_list.jsp?currentPage=")
	.append(movePage).append(searchQueryString.toString()).
	append("' class='prevMark'>&lt;&lt;</a> ]");
}//end if
movePage=startPage;
StringBuilder pageLink=new StringBuilder();
while( movePage <= endPage ){
	if(movePage == rDTO.getCurrentPage()){//현재 페이지는 링크를 설정하지 않음.
		pageLink.append("[ <span class='pagiCurrent'> ").append(rDTO.getCurrentPage()).append("</span> ]");
	}else{
		pageLink.append("[ <a href='board_list.jsp?currentPage=")
		.append(movePage).append(searchQueryString.toString()).append("' class='pagiNotCurrent'>").
		append(movePage).append("</a> ]");
	}//end else
	movePage++;
}//end while
	
//7.뒤에 페이지가 더 있는 경우
StringBuilder nextMark = new StringBuilder(" [ <span class='pagiNextMark'>&gt;&gt; ]</span> ");
if( totalPage > endPage ){
	nextMark.delete(0, nextMark.length());
	movePage=endPage+1;
	nextMark.append("[ <a href='board_list.jsp?currentPage=")
	.append(movePage).append(searchQueryString.toString()).
	append("'class='pagiNextMark'>&gt;&gt;</a> ]");
}//end if
%> --%>

<%-- <%=prevMark %> ... <%=pageLink %> ... <%=nextMark %> --%>
<%
PaginationDTO pDTO = new PaginationDTO(3,rDTO.getCurrentPage(),totalPage,"board_list.jsp",rDTO.getField(),rDTO.getKeyword());
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