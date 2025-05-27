<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="day0425.DataDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- favicon 설정 -->
<link rel="shortcut icon" href="http://192.168.10.96/jsp_prj/common/images/favicon.ico"/>
<!--  bootstrap CDN -->
<link rel="stylesheet" type="text/css"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}
 .span{font-weight: bold; color:#3D8E4A; font-size: 24px}
</style>
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script> 
<script type="text/javascript">
$(function(){
	
});//ready


</script>
</head>
<body>
<header data-bs-theme="dark">
  <div class="collapse text-bg-dark" id="navbarHeader">
    <div class="container">
      <div class="row">
        <div class="col-sm-8 col-md-7 py-4">
          <h4>템플릿</h4>
          <p class="text-body-secondary">모름.</p>
        </div>
        <div class="col-sm-4 offset-md-1 py-4">
          <h4>Contact</h4>
          <ul class="list-unstyled">
            <li><a href="https://google.com" class="text-white">구글에서 찾기</a></li>
            <li><a href="https://chatgpt.com/" class="text-white">지피티 찾기</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="navbar navbar-dark bg-dark shadow-sm">
    <div class="container">
      <a href="index.jsp" class="navbar-brand d-flex align-items-center">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" aria-hidden="true" class="me-2" viewBox="0 0 24 24"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/><circle cx="12" cy="13" r="4"/></svg>
        <strong>템플릿</strong>
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
  </div>
</header>
<main>
<div id="container">

<% //scriptlet : _jspService() 안으로 코드가 생성.
	String name="이장훈";
%>
<% for (int i=1; i < 7; i++){ %>
<h<%=i  %>><%=name %>입니다.</h<%=i  %>>
<%} %>

<% int sum=0;
	for(int i=1; i < 101 ; i++) {
		sum += i;
	}
%>
<input type="text" placeholder="<%=name %>"/><br>

<div>
1~100 까지의 합은<span class="span"><%=sum %></span>입니다.
</div>

<table class="table table-bordered" id="table">
  <% for (int i = 1; i < 10; i++) { %>
    <tr>
      <% for (int j = 2; j < 10; j++) { %>
        <td onclick="result(<%=j%>, <%=i%>)"><%= j %> x <%= i %> = <%= i * j %></td>
      <% }//end for %>
    </tr>
  <% }//end for %>
</table>

<% 
List<DataDTO> list=new ArrayList<DataDTO>();
list.add(new DataDTO("img_1.jpg","뭐지?","너는 아냐?","https://chatgpt.com"));
list.add(new DataDTO("img_2.jpg","몰루","이장훈 너는 아는가?","https://google.com"));
list.add(new DataDTO("img_3.jpg","이건 못참지!!!","오전에 수고하셨고 점심","https://www.yogiyo.co.kr/mobile/#/"));
%>
<div>
<% for(DataDTO dto : list){ %>
<div class="card" style="width: 18rem; float:left; margin-right: 10px">
  <img style="width:280px; height:160px;" src="http://localhost/jsp_prj/common/images/<%= dto.getImg() %>" class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title"><%= dto.getTitle() %></h5>
    <p class="card-text"><%=dto.getInfo() %></p>
    <a href="<%= dto.getUrl() %>" class="btn btn-primary">Go somewhere</a>
  </div>
</div>
<%}//end for %>
</div>

<div style="clear: both;">
<% 
	LocalDate ld=LocalDate.now();//현재 시간 얻기
	int nowYear=ld.getYear();
	int nowMonth=ld.getMonthValue();
	int nowDay=ld.getDayOfMonth();
%>
<select id="year">
<option value="none">---선택---</option>

<%
	int optionYear=0;
	String selected="";
	
for( int tempYear=-2; tempYear < 3  ; tempYear++ ){
	
	optionYear=nowYear+tempYear;
	selected="";
	
	if(optionYear == nowYear){
		selected=" selected= 'selected' ";
	}
%>
<option value="<%= optionYear %>"<%= selected %>><%= optionYear %></option>
<% } %>
</select>
년
<select id="month">
<option value="none">---선택---</option>
<%
for(int month=1; month < 13 ; month++){ %>
<option value="<%= month %>" <%= month == nowMonth ? "selected='selected'":""%>></option>
<% }//end for %>
</select>월

<select id="day">
<option value="none">선택</option>
<% for(int day=1; day < 32 ; day++) { %>
<option value="<%= day %>" <%= day == nowDay ? "selected='selected'":"" %>> </option>
<% }//end for %>
</select>일
</div>

</main>
<footer style="clear: both;" class="text-body-secondary py-5">
  <div class="container">
    <p class="float-end mb-1">
      <a href="#">Back to top</a>
    </p>
    <p class="mb-1"><strong style="font-size: 18px">2강의실</strong> 서울특별시 강남구 테헤란로 132(역삼동) 한독약품빌딩 8층 쌍용교육센터 <strong>Tel_02-3482-4632~5</strong> </p>
  </div>
</footer>


</body>
</html>