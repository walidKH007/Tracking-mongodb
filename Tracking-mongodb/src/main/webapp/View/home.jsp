<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Navbar Example</title>

<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"	href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"	href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"	href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"	href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"	href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"	href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"	href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="css/home_css.css">
<!-- ============================================================================================= -->
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<!-- ============================================================================================= -->


<link rel="stylesheet" type="text/css"	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
	
<link rel="stylesheet" type="text/css"	href="vendor/datepicker/dist/bootstrap-clockpicker.min.css">
<link rel="stylesheet" type="text/css"	href="vendor/datepicker/dist/bootstrap-datepicker.css">



</head>
<body>

<%

String name = (String) session.getAttribute("full_name");
String user_id = (String) session.getAttribute("user_id");

if (name == null) {
	response.sendRedirect("/login");

}


%>

	<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
		<a class="login100-form-title p-b-49 " href="#">Tracking</a>

		<!-- Left -->
		<ul class="navbar-nav mr-auto">
			<li class="nav-item">
				<a class="nav-link" href="home" >
				New Activity

				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="statistics">
				Statistic				
				</a>
			</li>
		</ul>
		<!-- Right -->
		<ul class="navbar-nav ml-auto">
			<li class="nav-item">
				<div class="nav-link">

					<%
							out.print(name);
					
					%>

				</div>
			</li>
			<li class="nav-item"><a class="nav-link" href="logout"> <!--   -->
					Logout
			</a></li>
		</ul>
	</nav>


	<div class="col-md-6 offset-md-3 mt-5">
		<header>
			<img src='images/logo-sport.png' width="100px" height="120px">
			<h1 style="display: inline; position: relative; top: 40px;">Create
				Your Activity</h1>
		</header>
		<form method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="exampleInputID">sportif ID : </label> <input type="text"
					name="identifiant" class="form-control" id="exampleInputID"
					value=<%out.print(user_id);%> readonly>
			</div>


			<div class=" form-group dates">
				<label class="control-label" for="date">Date :</label> <input
					type="text" class="form-control" id="date" name="date"
					placeholder="YYYY-MM-DD" autocomplete="off">
			</div>

			<div class="form-group">
				<label class="control-label" for="heure_debut">heure de
					début</label>
				<div class="input-group clockpicker">

					<input type="text" class="form-control" id="heure_debut"
						name="heure_debut" placeholder="HH:MM" autocomplete="off"> <span
						class="input-group-addon"> <span
						class="glyphicon glyphicon-time"></span>
					</span>
				</div>
			</div>


			<div class="form-group">
				<label class="control-label" for="heure_fin">heure de fin</label>
				<div class="input-group clockpicker">

					<input type="text" class="form-control" id="heure_fin"
						name="heure_fin" placeholder="HH:MM" autocomplete="off"> <span
						class="input-group-addon"> <span
						class="glyphicon glyphicon-time"></span>
					</span>
				</div>
			</div>



			<div class="form-group">
				<label for="exampleFormControlSelect1">sport pratiqué</label> <select
					class="form-control" id="exampleFormControlSelect1"
					name="sport_list">
					<option>cours</option>
					<option>Gitlab</option>
					<option>Bitbucket</option>
				</select>
			</div>
			<hr>
			<div class="form-group mt-3">
				<label class="mr-2">liste de points GPS :</label> <input type="file"
					name="file" multiple="true">
			</div>
			<hr>
			<button type="submit" class="btn btn-primary">Submit</button>
			<br> <br>
		</form>
	</div>



	<script type="text/javascript"
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/clockpicker/0.0.7/bootstrap-clockpicker.min.js"></script>

	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>


	<script type="text/javascript">
		$('.clockpicker').clockpicker().find('input').change(function() {
			console.log(this.value);
		});
	</script>

	<script>
		$(function() {
			$('.dates #date').datepicker({
				'format' : 'yyyy-mm-dd',
				'autoclose' : true
			});
		});
	</script>

</body>
</html>

