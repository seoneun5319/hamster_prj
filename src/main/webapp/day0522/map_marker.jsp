<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
    
 <%@ include file="../common/jsp/site_config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${ site_name }"/></title>
<c:import url="${ url }/common/jsp/external_file.jsp"/>
<style type="text/css">
 #container{ min-height: 600px; margin-top: 30px; margin-left: 20px}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=be94280ee5a5f60b757c31d5fa557d6e"></script>
<script>
var map;
$(function(){
   
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.499303, 127.033198), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };
map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var markerPosition  = new kakao.maps.LatLng(37.499303, 127.033198); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});


//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);
});//ready


function setCenter(lat, lng) {            
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(lat, lng);
    
    // 지도 중심을 이동 시킵니다
    map.setCenter(moveLatLon);
}

function panTo() {
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(33.450580, 126.574942);
    
    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);            
}        

function setMarker(lat, lng){
   setCenter(lat, lng);//지도의 위치를 가운데로 이동
   // 마커가 표시될 위치입니다 
   var markerPosition  = new kakao.maps.LatLng(lat, lng); 

   // 마커를 생성합니다
   var marker = new kakao.maps.Marker({
       position: markerPosition
   });
   marker.setMap(map);
   
   //인포 윈도우 띄우기
   var iwContent = `<div style="padding:5px;">안녕하세요!
   <br>
   <a href="#void" style="color:blue" target="_blank">인사메시지 보기</a></div>`, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
   iwPosition = new kakao.maps.LatLng(lat, lng); //인포윈도우 표시 위치입니다

	//인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	   position : iwPosition, 
	   content : iwContent 
	});
 
//마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 
}
</script>
<script>
$(function(){
   $("#btn").click(function(){
      setMarker(37.498189, 127.0315992);
   })

})
</script>
</head>
<body>
<header data-bs-theme="dark">
 <c:import url="${ url }/common/jsp/header.jsp"/>

</header>
<main>
<div id="container">
<div id="map" style="width:600px;height:350px;"></div>
   
<input type="button" value="제주은희네 강남점" class="btn btn-info" id="btn"/>
</div>
</main>
<footer class="text-body-secondary py-5">
 <c:import url="${ url }/common/jsp/footer.jsp"/>

</footer>


</body>
</html>