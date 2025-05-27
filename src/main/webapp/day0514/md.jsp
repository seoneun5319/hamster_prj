<%@page import="kr.co.sist.cipher.DataDecryption"%>
<%@page import="kr.co.sist.cipher.DataEncryption"%>
<%@page import="java.util.Base64"%>
<%@page import="java.security.MessageDigest"%>
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
<%
String msg="1234";
String msg2="q1w2e3r4~";
//1.SHA를 생성할 수 있는 객체 얻기
MessageDigest md=MessageDigest.getInstance("MD5");
MessageDigest md2=MessageDigest.getInstance("SHA-1");
MessageDigest md3=MessageDigest.getInstance("SHA-256");
//2 일방향 해시 설정
md.update(msg.getBytes());
md2.update(msg.getBytes());
md3.update(msg.getBytes());

//3.얻기
String md5=new String(Base64.getEncoder().encode(md.digest()));
String sha1=new String(Base64.getEncoder().encode(md2.digest()));
String sha256=new String(Base64.getEncoder().encode(md3.digest()));

md3.update(msg2.getBytes());
String sha2562=new String(Base64.getEncoder().encode(md3.digest()));
%>
MD5 : <%= md5 %> <br>
SHA-1 : <%= sha1 %> <br>
SHA-256 : <%= sha256 %> <br>
SHA-2562 : <%= sha2562 %> <br>
<%
//sist_util.jar에 제공
String temp=DataEncryption.messageDigest("SHA-256", msg);

//암호화
//키를 준비
String key="abcdefghijklmn1234";
DataEncryption de=new DataEncryption(key);
String name="이장훈";
String cipher=de.encrypt(name);

DataDecryption dd=new DataDecryption(key);
String plain=dd.decrypt(cipher);
%>
<%= temp %>
<br>
암호화된 문자열 : <%= cipher %>
</div>
</main>
<footer class="text-body-secondary py-5">
 <c:import url="http://192.168.10.95/jsp_prj/common/jsp/footer.jsp"/>

</footer>


</body>
</html>