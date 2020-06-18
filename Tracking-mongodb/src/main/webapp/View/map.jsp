<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>Activity</title>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="css/home_css.css">
<!-- ============================================================================================= -->
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<!-- ============================================================================================= -->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>



<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	width: 50%;
	height: 50%;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>



</head>
<body onload="getLocation()">
	<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
		<a class="login100-form-title p-b-49 " href="#">Tracking</a>

		<!-- Left -->
		<ul class="navbar-nav mr-auto">
			<li class="nav-item"><a class="nav-link" href="home">New Activity</a></li>
			<li class="nav-item"><a class="nav-link" href="statistic">Statistic</a></li>
		</ul>
		<!-- Right -->
		<ul class="navbar-nav ml-auto">
			<li class="nav-item">
				<div class="nav-link">

					<%
						String name = (String) session.getAttribute("full_name");
						String user_id = (String) session.getAttribute("user_id");
						String position = (String) session.getAttribute("position");
						
						if (name == null) {
							response.sendRedirect("/login");

						} else {
							out.print(name);
						}
					%>

				</div>
			</li>
			<li class="nav-item"><a class="nav-link" href="logout">
					Logout
			</a></li>
		</ul>
	</nav>


	<div id="map"></div>
	


	<script>
	   var mapLatitude;
	   var mapLongitude;
	   var myLatlng;
	   
	function getLocation() {
	  if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(showPosition);
	    
	  } else {   
	    windows.alert("Geolocation is not supported by this browser.");
	  }
	}

	function showPosition(position) {
		 console.log("showMapPosition");
		 mapLatitude = position.coords.latitude;
		 mapLongitude = position.coords.longitude;
		 myLatlng = new google.maps.LatLng(mapLatitude,mapLongitude);
		 initMap();
	}

	function initMap() {
		var mapOptions = {
			    zoom: 15,
			    center: new google.maps.LatLng(mapLatitude, mapLongitude)
			  };
			  map = new google.maps.Map(document.getElementById('map'),
			      mapOptions);

// 				var marker = new google.maps.Marker({
// 				    position: myLatlng,
// 				    map: map,
// 				    title:"You are here!"
// 				});

				drowPath();
				
				

	}


 		function drowPath(){
 			
 			var arr = <% out.print(position); %>
 			
 			//build the array
 			
 			var triangleCoordsLS12 = []
 			for (var i=0; i<arr.length; i++) {
 			    triangleCoordsLS12[i] = new google.maps.LatLng(arr[i]["LatitudeDegrees"], arr[i]["LongitudeDegrees"]);
 			}
 			
 			//use the array as coordinates
 			bermudaTriangleLS12 = new google.maps.Polyline({
 				  path: triangleCoordsLS12,
				  strokeColor: '#FF0000',
				  strokeOpacity: 3.5,
				  strokeWeight: 10,
				  geodesic: true
 			});
 			bermudaTriangleLS12.setMap(map);
 			
 			
 			
			

 		}

	</script>


	<script src="https://maps.googleapis.com/maps/api/js?key=<API-KEY>&callback=initMap" async defer></script>
	
</body>
</html>
