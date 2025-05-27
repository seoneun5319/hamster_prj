<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/octet-stream; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ include file="../common/jsp/site_config.jsp" %>
<%
	String fileName=request.getParameter("fileName");//파일명 영어, 한글은 다운x
	String downFile=fileName;
	fileName=URLEncoder.encode(fileName,"UTF-8");//파일명의 인코딩 -  한글 다운 가능
	//2.응답 헤더를 변경 : 선택한 파일명으로 응답 파일명이 설정된다.
	response.setHeader("Content-Disposition", "attachement;fileName="+fileName);
	//3.다운로드 할 파일의 정보를 얻기
	File file=new File("C:/dev/jsp_prj/src/main/webapp/upload/"
		+downFile);
	
	if(file.exists()){//파일이 존재하면
		//파일에 읽기 스트림 연결
		FileInputStream fis=new FileInputStream(file);
		//파일을 응답하기 위해 현재 접속자의 스트림 얻기
		OutputStream os=response.getOutputStream();
		
		//파일에서 읽어들인 내용을 저장하기 위한 배열 생성
		byte[] readData=new byte[1024];// 512, 1024
		int readSize=0;
		
		while( (readSize=fis.read(readData)) != -1 ){
			os.write(readData, 0, readSize);
		}//end while
		
		//분출
		os.flush();
		
		//출력 스트림 초기화
		out.clear();
		
		//응답 헤더 초기화
		out=pageContext.pushBody();
	}//end if
%>