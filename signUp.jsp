<%@ page contentType="text/html; charset=utf-8" %>
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

<h1>Sign Up</h1>
<h3>
<%
String status=(String)request.getAttribute("status");
if(status=="0"){
	out.println("请输入用户名和密码!");
}
if(status=="1"){
	out.println("此用户名已经被注册!");
}
if(status=="2"){
	out.println("两次密码输入不符!");
}
%>
</h3>
<form role="form" name="loginForm" method="POST" action="checkSignUp.jsp">
    <div class="form-group">
    <label for="exampleInputEmail1">User name</label>
    <input type="text" class="form-control" name="username" placeholder="Enter username">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input type="password" class="form-control" name="password" placeholder="Password">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Repeat Password</label>
    <input type="password" class="form-control" name="repeatPassword" placeholder="repeatPassword">
  </div>
  <button type="submit" class="btn btn-default">Submit</button>
</form>
<%@ include file="footer.jsp"%>
