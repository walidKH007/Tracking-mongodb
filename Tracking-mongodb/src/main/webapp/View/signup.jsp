<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Sign Up</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
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
<link rel="stylesheet" type="text/css" href="css/util.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>

	<div class="limiter">
		<div class="container-login100"
			style="background-image: url('images/bg-01.jpg');">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<form class="login100-form validate-form" method="post">
					<span class="login100-form-title p-b-49"> Sign Up </span> 
					<div id="alert_placeholder"></div>

					<div class="wrap-input100 validate-input m-b-23"
						data-validate="Full Name is reauired">
						<span class="label-input100">Full Name</span> <input
							class="input100" type="text" name="full_name"
							placeholder="Type your Full Name"> <span
							class="focus-input100" data-symbol="&#xf206;"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-23"
						data-validate="Email is reauired">
						<span class="label-input100">Email</span> <input class="input100"
							type="email" name="email" placeholder="Type your Email">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-23"
						data-validate="Password is required">
						<span class="label-input100">Password</span> <input
							class="input100" type="password" name="pass"
							placeholder="Type your password" id="pass"> <span
							class="focus-input100" data-symbol="&#xf190;"></span>
					</div>

					<div class="wrap-input100 validate-input"
						data-validate=" Repeat Password is required">
						<span class="label-input100"> Confirm Password </span> 
						<input class="input100" id="rep_pass" type="password" name="rep_pass"	placeholder="Type your password" onkeyup='check();'> 
							
						<span class="focus-input100" data-symbol="&#xf190;"></span>
					</div>

					</br>

					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button type="submit" class="login100-form-btn">
							<b>Create Account</b></button>
						</div>
					</div>


					<div class="flex-col-c p-t-30">
						<span class="txt1 p-b-10"> You have an account? </span> <a
							href="/login" class="txt2"> <b>Sign in</b>
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>



	<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
	<!--===============================================================================================-->
	<script src="js/main.js"></script>



	<%if (request.getAttribute("emailError") == null) {	%>

	<%} else {%>

	<script>
		//alert("Sorry Email Address already exist.");
		$('#alert_placeholder')
		.html(
				'<div class="alert alert-danger"><a class="close" data-dismiss="alert">×</a><span>Sorry Email Address already exist.</span></div>')
	</script>

	<%}%>
	
	<%if (request.getAttribute("pass_no_match") == null) {	%>

	<%} else {%>

	<script>
		//alert("your password and confirmation password do not match.\nTry again!");
		$('#alert_placeholder')
		.html(
				'<div class="alert alert-danger"><a class="close" data-dismiss="alert">×</a><span>your password and confirmation password do not match. Try again!</span></div>')
	</script>

	<%}%>





</body>
</html>