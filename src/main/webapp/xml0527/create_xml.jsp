<%@page import="org.jdom2.Element"%>
<%@page import="org.jdom2.Document"%>
<%@page import="org.jdom2.output.Format"%>
<%@page import="org.jdom2.output.XMLOutputter"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="application/xml; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
    info=""%>
<%
//1.XML문서객체 생성
		Document doc=new Document();
		
		//2.최상위 부모노드 생성
		Element rootNode=new Element("root");
		
		//3.자식 노드 생성
		Element msgNode=new Element("msg");
		//자식 노드에 값 설정
		msgNode.setText("햄스터");
		
		//4.배치
		rootNode.addContent(msgNode);
		//모든 자식노드를 가진 부모노드를 문서객체에 배치
		doc.addContent(rootNode);
		
		//출력객체 생성
		//XMLOutputter xOUT=new XMLOutputter(Format.getRawFormat());
		//XMLOutputter xOUT=new XMLOutputter(Format.getCompactFormat());
		XMLOutputter xOUT=new XMLOutputter(Format.getPrettyFormat());
		
		try {
			//out 내장객체를 할당하면 web browser로 출력한다.
			xOUT.output(doc, out);
		} catch (IOException e) {
			e.printStackTrace();
		}//end catch
	
	
%>