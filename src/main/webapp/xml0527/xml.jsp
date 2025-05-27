<%@ page language="java" contentType="application/xml; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
    info=""%>
<?xml version="1.0" encoding="UTF-8"?>
<% String name=request.getParameter("name"); %>
<햄스터>
<msg><%= name %>님 안녕하세요?</msg>
</햄스터>