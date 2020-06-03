<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*" %>
<%@page import="fusioncharts.FusionCharts" %> 
<%@page import="java.util.logging.*" %> 
<%@page import="com.mongodb.client.*" %> 
<%@page import="org.bson.Document" %> 
<%@page import="com.mongodb.client.model.Filters" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Statistic</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="css/home_css.css">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

<script type = "text/javascript" src = "https://cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"> </script> <script type = "text/javascript"
src = "https://cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.fusion.js"> </script>
    


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
			<li class="nav-item"><a class="nav-link" href="statistics">Statistic</a></li>
		</ul>
		<!-- Right -->
		<ul class="navbar-nav ml-auto">
			<li class="nav-item">
				<div class="nav-link">

					<%
						String name = (String) session.getAttribute("full_name");
						String user_id = (String) session.getAttribute("user_id");
						
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
	
	<div id =  "chart" > </div>

<%
			Logger.getLogger("org.mongodb.driver").setLevel(Level.WARNING);
			String uri = "mongodb://admin:walid@tracking-shard-00-00-mwydz.mongodb.net:27017,"
					+ "tracking-shard-00-01-mwydz.mongodb.net:27017,"
					+ "tracking-shard-00-02-mwydz.mongodb.net:27017/test?ssl=true&replicaSet=Tracking-shard-0"
					+ "&authSource=admin&retryWrites=true&w=majority";
			
			// connection to database
			MongoClient mongoClient = MongoClients.create(uri);

			// get collection
			MongoCollection<Document> database_collection = mongoClient.getDatabase("Tracking").getCollection("Activity");
			
			// get email if exist
			List<Document> userList = database_collection.find(Filters.eq("user_id", user_id)).into(new ArrayList<Document>());
			
			 // store chart config name-config value pair
            Map<String, String> chartConfig = new HashMap<String, String>();
            
			 //store label-value pair
            Map<String, Integer> dataValuePair = new HashMap<String, Integer>(); 
			 
            chartConfig.put("caption", name+" Statistic");
            chartConfig.put("subCaption", "All "+name+" Statistic for all Activity");
            chartConfig.put("xAxisName", "Dates");
            chartConfig.put("yAxisName", "Distance (Km)");
            chartConfig.put("numberSuffix", "km");
            chartConfig.put("theme", "fusion");
			
			for (Document users : userList) {
				        dataValuePair.put(users.getString("date"), users.getInteger("distance"));    			
			}
			
			
            StringBuilder jsonData = new StringBuilder();
            StringBuilder data = new StringBuilder();
            // json data to use as chart data source
            jsonData.append("{'chart':{");
            for(Map.Entry conf:chartConfig.entrySet())
            {
                jsonData.append("'" + conf.getKey()+"':'"+conf.getValue() + "',");
            }
            jsonData.replace(jsonData.length() - 1, jsonData.length() ,"},");
            // build  data object from label-value pair
            data.append("'data':[");
            for(Map.Entry pair:dataValuePair.entrySet())
            {
                data.append("{'label':'" + pair.getKey() + "','value':'" + pair.getValue() +"'},");
            }
            data.replace(data.length() - 1, data.length(),"]");
            jsonData.append(data.toString());
            jsonData.append("}");
            
            // Create chart instance
            // charttype, chartID, width, height,containerid, data format, data
            FusionCharts firstChart = new FusionCharts(
                "column2d",
                "first_chart",
                "700",
                "400",
                "chart",
                "json",
                jsonData.toString()
            );
        %>
<%= firstChart.render() %> 

	


	
</body>
</html>