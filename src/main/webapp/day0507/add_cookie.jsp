<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="쿠키를 받아 추가"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- favicon 설정 -->
<link rel="shortcut icon" href="http://192.168.10.98/jsp_prj/common/images/favicon.ico"/>
<!-- bootstrap CDN -->
<link rel="stylesheet" type="text/css"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}
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
<%
    // 1. 한글 처리
    request.setCharacterEncoding("UTF-8");

    // 2. 파라미터 받기
    String name = request.getParameter("name");
    String age = request.getParameter("age");
    String chk = request.getParameter("saveFlag");

    if (name != null && !name.isEmpty() && age != null && !age.isEmpty()) {

        // 3. 쿠키 생성
        Cookie CookieName = new Cookie("name", name);
        Cookie CookieAge = new Cookie("age", age);
        Cookie CookieSave = new Cookie("saveFlag", (chk == null) ? "false" : "true");

        // 4. 쿠키 생존시간 설정
        CookieName.setMaxAge(60 * 60 * 1); // 1시간
        CookieAge.setMaxAge(60 * 60 * 1);  // 1시간
        CookieSave.setMaxAge(60 * 60 * 24); // 24시간

        // 5. 응답에 쿠키 추가
        response.addCookie(CookieName);
        response.addCookie(CookieAge);
        response.addCookie(CookieSave);
        
        // 6. 리다이렉트
        response.sendRedirect("read_cookie.jsp");
        return; // 이후 내용 출력 방지
    } else {
%>
  <div class="alert alert-warning" role="alert">
    이름과 나이를 모두 입력해 주세요.
  </div>
  <a href="read_cookie.jsp" class="btn btn-secondary">돌아가기</a>
<%
    }
%>
</div>
</main>
<footer class="text-body-secondary py-5">
  <div class="container">
    <p class="float-end mb-1">
      <a href="#">Back to top</a>
    </p>
    <p class="mb-1"><strong style="font-size: 18px">2강의실</strong> 서울특별시 강남구 테헤란로 132(역삼동) 한독약품빌딩 8층 쌍용교육센터 <strong>Tel_02-3482-4632~5</strong> </p>
  </div>
</footer>
</body>
</html>
