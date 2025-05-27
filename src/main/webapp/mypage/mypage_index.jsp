<%@page import="kr.co.sist.member.MemberDTO"%>
<%@page import="kr.co.sist.member.MemberService"%>
<%@page import="java.nio.channels.MembershipKey"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
    
<%@ include file="../common/jsp/site_config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../common/jsp/login_chk.jsp" %> 
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
   
	$("#btnImg").click(function(){
		$("#profileImg").click();
	});
	
	$("#profileImg").change(function(evt){
		//선택한 파일이 이미지인지를 체크
		$("#imgName").val( $("#profileImg").val() );
		//이벤트를 발생시킨 file 객체를 얻는다.
		var file=evt.target.files[0];
		//스트림을 생성
		var reader=new FileReader();
		//FileReader 객체의 onload event handler 설정
		reader.onload=function(evt){
			
			$("#img").prop("src", evt.target.result);
		}//onload
		
		//파일을 읽어들여 img 설정
		reader.readAsDataURL(file);
		
	});
	
	$("#btnUpdate").click(function(){
		if (confirm("회원정보를 수정하시겠습니까?")) {
		var uploadFlag= $("img")[0].src.lastIndexOf("default.jpg") == -1;
			if(uploadFlag){
			
			//ajax fileUpload
			//1. input type="file"을 가진 <form을 얻어서
			var frm=$("#frm")[0];//parameter 전송방식 : 파일 업로드 x
			var formData=new FormData(frm); //binary 전송방식 : 파일 업로드 가능

			$.ajax({
				url:"profile_upload.jsp",
				contentType: false,
				processData: false,
				type:"post",
				data: formData,
				dataType: "json",
				error:function(xhr){
					console.log(xhr.status);
				},
				success:function(jsonObj){
					if (jsonObj.resultFlag) {
						$("#imgName").val(jsonObj.fileName);
						//이미지가 업로드 된 후 form submit 수행
						$("#frm").submit();
					}else{
						console.log("프로필 이미지가 업로드 되지 않았습니다.")
					}//else
				}
			});//ajax
			}//이미지 업로드
		}//end if
	});
	
});//ready


</script>
</head>
<body>
<header data-bs-theme="dark">
<c:import url="${url}/common/jsp/header.jsp"/>
</header>
<main>
<div id="container">
<%
String id=((LoginResultDTO)session.getAttribute("userData")).getId();

MemberService ms=new MemberService();
MemberDTO mDTO=ms.searchOneMember(id);
if(mDTO == null){
	response.sendRedirect("http://localhost/jsp_prj");
	return;
}//end if
pageContext.setAttribute("mDTO", mDTO);
%>
<div>
<h3>마이페이지</h3>
<form action="mypage_process.jsp" method="post" name="frm" id="frm">

<div style="float: left; width:200px; height:200px">
<img src="${mDTO.profile_img eq 'default.jpg'? "../common/images":uploadURL}/${mDTO.profile_img}"
	 style="width:170px; height:200px;" id="img"/>
	 <br>
	 <input type="button" value="이미지 선택" id="btnImg"
	 class="btn btn-info btn-sm"/>
	 <input type="hidden" name="imgName" id="imgName"
	 class="btn btn-info btn-sm"/>
	 <input type="file" style="display:none" name="profileImg" id="profileImg"/>
</div>

<table style="float:left;">
<tr>
<td>이름</td>
<td><c:out value="${ mDTO.name }"/></td>
</tr>
<tr>
<td>생년월일</td>
<td><input type="date" name="birth" value="${mDTO.birth}"/></td>
</tr>
<tr>
<td>전화번호</td>
<td><input type="text" name="tel" value="${mDTO.tel}"/></td>
</tr>
<tr>
<td>성별</td>
<td>
	<label>
	<input type="radio" name="gender" 
	value="남자" ${mDTO.gender eq '남자' ? "checked='checked'":""}/>
	남자
	</label>
	<label>
	<input type="radio" name="gender" 
	value="여자" ${mDTO.gender eq '여자' ? "checked='checked'":""}/>
	여자
	</label>
</td>
</tr>
<tr>
<td>가입시 사용된 ip address </td>
<td><c:out value="${mDTO.ip}"/></td>
</tr>
<tr>
<td>가입일</td>
<td><fmt:formatDate value="${ mDTO.input_date }"
		pattern="yyyy-MM-dd a EEEE HH:mm"/></td>
</tr>
<tr>
<td colspan="2" style="text-align:center">
	<input type="button" id="btnUpdate" value="정보변경" class="btn btn-success btn-sm"/>
</td>
</tr>
</table>
</form>
</div>
</div>
</main>
<footer class="text-body-secondary py-5">
<c:import url="${url}/common/jsp/footer.jsp"/>
</footer>


</body>
</html>