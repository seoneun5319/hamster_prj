<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TITLE</title>

<!-- favicon 설정 -->
<link rel="shortcut icon" href="http://192.168.10.88/jsp_prj/common/images/favicon.ico"/>
<!--  bootstrap CDN -->
<link rel="stylesheet" type="text/css"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<style type="text/css">
body{background-color: aqua }
#wrap{ width: 600px; height: auto; margin: 0px auto; back}
#container{ position: relative; width: 100%; margin-top:100px}
#container > div {height: auto; margin: 5px; border: 1px solid #efefef}
</style>
<!-- jquery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script> 
<script type="text/javascript">
$(function(){

});//ready


</script>
</head>
<body>
<main>

<%--
	public String createCalendar(int numOfWeek, int numOfDays){
	StringBuilder sbTemp = new StringBuilder();
	sbTemp.append("<td>")
	.append()
	.append()
	.append()
	;
	
	
	return sbTemp.toString();
	}//createCalendar
	
--%>

<div id="wrap">
<div id="container">

<%
    LocalDate current = LocalDate.of(2025, 4, 1);
    int currentYear = current.getYear();
    int currentMonth = current.getMonthValue();
    int lengthOfMonth = current.lengthOfMonth();
    DayOfWeek firstDayOfWeek = current.getDayOfWeek();
%>

<%!
    public int check(DayOfWeek dayOfWeek) {
        int startDay = 0;

        switch (dayOfWeek) {
            case SUNDAY: startDay = 0; break;
            case MONDAY: startDay = 1; break;
            case TUESDAY: startDay = 2; break;
            case WEDNESDAY: startDay = 3; break;
            case THURSDAY: startDay = 4; break;
            case FRIDAY: startDay = 5; break;
            case SATURDAY: startDay = 6; break;
        }//end switch

        return startDay;
    }//check
%>

<div>
	<%= currentYear %>년 <%= currentMonth %>월은 시작: 
	<%= check(firstDayOfWeek) %> 마지막: 
	<%= lengthOfMonth %>일
</div>

<table class="table table-bordered">
	<thead class= "table table-dark">
		<tr>
			<th>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
		</tr>
	</thead>
	<tbody>
	<tr>
	<%
		int startDay = check(firstDayOfWeek);
		int day = 1;
	%>
			          
	<% for(int i=0; i<startDay; i++){%>
		<td></td>
	<%}//end for %>
			
	<% for(int i=startDay; i<7; i++){%>
		<td><%= day++ %></td>
	<%}//end for %>
		</tr>
			
	<% while (day <= lengthOfMonth){%>
			        
	<tr>
		<%for (int i=0; i<7; i++){%>
			<%if (day > lengthOfMonth){%>
			<td></td>
			<%}else{%>
			<td><%= day++ %></td>
			<%}//end if-else%>
		<%}//end for%>
	</tr>		            
	<% }//end while %>
	</tbody>
</table>

</div><!-- container -->
</div><!-- wrap -->
</main>

</body>
</html>