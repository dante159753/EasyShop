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
<div class="wrapper wrapper-login center-block">
<h1 class="text-center">登录到 EasyShop</h1>
<h3 class="text-danger">
<%
String status=(String)request.getAttribute("status");
if(status=="1"){
	out.println("用户名或密码错误");
}
%>
</h3>
<form role="form" name="loginForm" method="POST" action="checkLogin.jsp" class="login-form">
    <div class="form-group">
    <label for="username">用户名</label>
    <input type="text" class="form-control" name="username" id="username" placeholder="Enter username">
  </div>
  <div class="form-group">
    <label for="password">密码</label>
    <input type="password" class="form-control" name="password" id="password" placeholder="Password">
  </div>
  <div class="checkbox">
    <label>
      <input type="checkbox"> 记住我
    </label>
  </div>
  <div class="row">
    <div class="col-md-8">
  <button type="submit" class="btn btn-info btn-block">提交</button>
  </div>
  <div class="col-md-4">
<a href="signUp.jsp" class="btn btn-default btn-block">注册</a>
</div>
</div>
</form>
</div>
<%@ include file="footer.jsp"%>