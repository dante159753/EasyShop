<% request.setAttribute("title","login");%>
<%@ include file="header.jsp"%>
<%
//验证是否已经登陆，是则跳到欢迎页

String userID="";
userID=(String)session.getAttribute("userID");
if(userID!=null){
	response.sendRedirect("welcome.jsp");
}

%>
<div class="wrapper wrapper-login center-block">
<h1>Welcome to Easy Shop!</h1>
<h3>
<%
String status=(String)request.getAttribute("status");
if(status=="1"){
	out.println("wrong Username or password! Please check again!");
}

else{
	out.println("please log in!");
}
%>
</h3>
<form role="form" name="loginForm" method="POST" action="checkLogin.jsp" class="login-form">
    <div class="form-group">
    <label for="username">Username</label>
    <input type="text" class="input-login" name="username" id="username" placeholder="Enter username">
  </div>
  <div class="form-group">
    <label for="password">Password</label>
    <input type="password" class="input-login" name="password" id="password" placeholder="Password">
  </div>
  <div class="checkbox">
    <label>
      <input type="checkbox"> Stay log in
    </label>
  </div>
  <button type="submit" class="btn-login btn-login-submit">Submit</button>
<a href="signUp.jsp"><button class="btn-login">Sign Up</button></a>
</form>
</div>
<%@ include file="footer.jsp"%>