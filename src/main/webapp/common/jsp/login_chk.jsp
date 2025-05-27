<%@page import="kr.co.sist.member.login.LoginResultDTO"%>
<%@page import="kr.co.sist.member.login.LoginDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<%
//세션에 존재하는 값 얻기
//String name=(String)session.getAttribute("name");
Object obj=session.getAttribute("userData");
if(obj == null){
	//세션에 값이 없다면 (세션 만료) 첫 페이지로 이동
	//response.sendRedirect("http://192.168.10.68/jsp_prj/day0501/use_session_a.jsp");
	response.sendRedirect("http://192.168.10.95/jsp_prj/index.html");
	return;
}
LoginResultDTO lrDTO=(LoginResultDTO)obj;
%>