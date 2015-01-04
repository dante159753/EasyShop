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
<a href="signUp.jsp"><button class="btn btn-default">Sign Up</button></a>
<%@ include file="footer.jsp"%>
