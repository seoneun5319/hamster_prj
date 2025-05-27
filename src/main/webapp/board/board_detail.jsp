<%@page import="kr.co.sist.board.BoardService"%>
<%@page import="java.util.Random"%>
<%@page import="kr.co.sist.member.login.LoginResultDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
    
<%@ include file="../common/jsp/site_config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../common/jsp/login_chk.jsp" %> 
<%

String paramNum=request.getParameter("num");
int num=0;
try{
   num=Integer.parseInt(paramNum);
}catch(NumberFormatException nfe){
   response.sendRedirect("board_list.jsp");
   return;
}//end catch

BoardService bs=new BoardService();
Boolean cntFlag=(Boolean)session.getAttribute("cntFlag");
if(cntFlag.booleanValue()){
bs.modifyCnt(num);
session.setAttribute("cntFlag", false);
//session.setAttribute("cntFlag", true);
}//end if
pageContext.setAttribute("bDTO", bs.searchOneBoard(num));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${ site_name }"/></title>
<c:import url="${ url }/common/jsp/external_file.jsp"/>
<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}

 td{padding-top: 10px;padding-bottom: 10px}
</style>

<!-- summernote -->
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.js"></script>
<!-- summernote -->

<script type="text/javascript">
$(function(){
   $('#summernote').summernote({
       placeholder: '자유롭게 자신의 생각을 작성해주세요',
           tabsize: 2,
           height: 240,
           toolbar: [
             ['style', ['style']],
             ['font', ['bold', 'underline', 'clear']],
             ['color', ['color']],
             ['para', ['ul', 'ol', 'paragraph']],
             ['table', ['table']],
             ['insert', ['picture']]
            
           ]
   });
   
   $("#btnWrite").click(function(){
      //제목, 내용 등 필수 입력사항에 대한 유효성 검증
      
      $("#writeFrm").submit();
   })
   
   $("#btnModify").click(function(){
	//obj.method="get";//form의 요청방식 변경가능
	setEdit("m");
   });//click
   
   $("#btnRemove").click(function(){
	setEdit("r");
   });//click

});//ready

function setEdit(flag){
	var url="modify_process.jsp";
	var msg="변경";
	if (flag=='r') {
		url="remove_process.jsp";
		msg="삭제";
	}//end if
	
	if(confirm("정말 \""+msg+"\"하시겠습니까?")){
	var obj=$("#writeFrm")[0];
	obj.action=url;
	obj.submit();
	
	}//end if
}//setEdit
</script>
</head>
<body>
<header data-bs-theme="dark">
 <c:import url="${ url }/common/jsp/header.jsp"/>

</header>
<main>
<div id="container">
<div id="writeWrap" style="width: 620px; margin:0px auto">

<div>
<form method="post" id="writeFrm">
<input type="hidden" name="num" value="${bDTO.num }"/>
<table>
<tr>
<th colspan="2" style="text-align: center;">
   <h3>글 읽기</h3>
</th>
</tr>
<tr style="height:40px">
<td style="width:80px">제목</td>
<td><input type="text" name="subject" id="subject" 
value="${bDTO.subject }"
   style="width:520px;border:1px solid #CDCDCD;height:30px"/></td>
</tr>
<tr>
<td>내용</td>
<td>

  <textarea id="summernote" name="content"><c:out value="${bDTO.content }"/></textarea>

</td>
</tr>
<tr>
<td>조회수</td>
<td><strong><c:out value="${bDTO.cnt }"/></strong></td>
</tr>
<tr>
<td>작성자 ID</td>
<td><strong><c:out value="${bDTO.id }"/></strong>
(<c:out value="${bDTO.ip }"/>)</td>
</tr>
<tr>
<td>작성일</td>
<td><strong><fmt:formatDate value="${bDTO.input_date}"
			pattern="yyyy-MM-dd a HH:mm"/></strong>
	</td>
</tr>
<tr>
<td colspan="2" style="text-align: center;">
<c:if test="${bDTO.id eq userData.id }">
<input type="button" value="글수정" id="btnModify" class="btn btn-success btn-sm"/>
<input type="button" value="글삭제" id="btnRemove" class="btn btn-danger btn-sm"/>
</c:if>
<%
String search="";
String field=request.getParameter("field");
String keyword=request.getParameter("keyword");
if(field != null && !field.isEmpty()){
	search="&field="+field+"&keyword="+keyword;
}//end if
pageContext.setAttribute("search", search);
%>
<a href="board_list.jsp?currentPage=${ param.currentPage }${search}" class="btn btn-info btn-sm">글 목록</a>
</td>
</tr>
</table>
</form>
</div>
</div>

</div>
</main>
<footer class="text-body-secondary py-5">
 <c:import url="${ url }/common/jsp/footer.jsp"/>

</footer>


</body>
</html>