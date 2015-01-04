<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Easy Shop</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
String userID="";
userID=(String)session.getAttribute("userID");
if(userID!=null){
	response.sendRedirect("/EasyShop/welcome.jsp");
}
%>
<h1>Welcome to Easy Shop!</h1>
<p>
<%="please log in!"%>
</p>
<form role="form" name="loginForm" method="POST" action="checkLogin.jsp">
    <div class="form-group">
    <label for="exampleInputEmail1">User name</label>
    <input type="text" class="form-control" name="username" placeholder="Enter username">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input type="password" class="form-control" name="password" placeholder="Password">
  </div>
  <div class="checkbox">
    <label>
      <input type="checkbox"> Stay log in
    </label>
  </div>
  <button type="submit" class="btn btn-default">Submit</button>
</form>



<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
