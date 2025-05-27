<%@page import="day0430.DataDTO"%>
<%@page import="java.util.List"%>
<%@page import="day0430.Service"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="요청을 받아서 업무를 처리하는 용도의 페이지"%>

<%
//업무처리 페이지에서는 응답이 되지 않기 때문에 디자인 코드를 작성하지 않고,
//업무로직 구현에 집중

Service service=new Service();
//업무로직 처리
String name=service.name();
List<DataDTO> list=service.subject();

//1. 이동할 페이지로 값 설정
request.setAttribute("name", name);
request.setAttribute("list", list);
//2. 이동할 페이지의 URI를 설정
RequestDispatcher rd=request.getRequestDispatcher("forward_b.jsp");
//3. 이동
rd.forward(request, response);
%>
