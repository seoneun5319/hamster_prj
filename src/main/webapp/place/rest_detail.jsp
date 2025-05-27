<%@page import="kr.co.sist.place.RestDTO"%>
<%@page import="kr.co.sist.place.PlaceService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
    
 <%@ include file="../common/jsp/site_config.jsp" %>
 <%@ include file="../common/jsp/login_chk.jsp"  %> 
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String paramRestNum=request.getParameter("num");
int num=0;
try{
	num=Integer.parseInt(paramRestNum);	
}catch(NumberFormatException nfe) {
	
}
PlaceService ps=new PlaceService();
RestDTO rDTO=ps.searchOneRestaurant(num);
pageContext.setAttribute("rDTO", rDTO);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${ site_name }"/>맛집 상세 정보</title>
<c:import url="${ url }/common/jsp/external_file.jsp"/>
<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}
</style>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=649081be4a86628fec90854e9cbe8a37"></script>
<script>
$(function(){
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(${rDTO.lat}, ${rDTO.lng}), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter() 
}); 
// 지도에 마커를 표시합니다
marker.setMap(map);

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng; 
    
    // 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latlng);
    $("#lat").val(latlng.getLat());//위도 설정
    $("#lng").val(latlng.getLng());//위도 설정
    /*
    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
    message += '경도는 ' + latlng.getLng() + ' 입니다';
    
    var resultDiv = document.getElementById('clickLatlng'); 
    resultDiv.innerHTML = message;
    */
});//addListener
});//ready


</script>

<script type="text/javascript">
$(function(){
	
})
</script>

</head>
<body>
<header data-bs-theme="dark">
 <c:import url="${ url }/common/jsp/header.jsp"/>

</header>
<main>
<div id="container">
<div id="restWrap" style="width:80%; margin: 0px auto">
<h3>맛집 보기</h3>

<div id="map" style="width:100%;height:350px;border:1px solid #ddd"></div>
<form action="rest_frm_process.jsp" method="post" name="restFrm" id="restFrm">
<table>
<tbody>
<tr>
<td colspan="2" style="text-align: center;">
<h3>맛집 정보</h3>
</td>
</tr>
<tr>
<td>식당명</td>
<td><strong><c:out value="${rDTO.restaurant}"/></strong></td>
</tr>
<tr>
<td>대표메뉴</td>
<td><strong><c:out value="${rDTO.menu}"/></strong></td>
</tr>
<tr>
<td>메뉴가격</td>
<td><strong><fmt:formatNumber value="${rDTO.price}" pattern="#,###"/>원</strong></td>
</tr>
<tr>
<td>식당정보</td>
<td><strong><c:out value="${rDTO.info}"/></strong></td>
</tr>
<tr>
<td>작성자 / 작성일</td>
<td><strong><c:out value="${rDTO.id }"/> /
<fmt:formatDate value="${rDTO.input_date }" pattern="yyyy-MM-dd EEEE HH:mm"/>
</strong></td>
</tr>
<tr>
<td colspan="2" style="text-align:center;">
<input type="hidden" name="lat" id="lat"/>
<input type="hidden" name="lng" id="lng"/>
<input type="button" value="식당정보 추가" id="btnAdd" class="btn btn-success"/>
<a href="restaurant_list.jsp" class="btn btn-info">맛집리스트</a>
</td>
</tr>
</tbody>
</table>
</form>
</div>
</div>
</main>
<footer class="text-body-secondary py-5">
 <c:import url="${ url }/common/jsp/footer.jsp"/>

</footer>


</body>
</html>