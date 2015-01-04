<%
String userID="";
userID=(String)session.getAttribute("userID");
if(userID==null){
	response.sendRedirect("/EasyShop/hello.jsp");
}
%>
<p>Welcome to Easy Shop ,<%=session.getAttribute("username")%>!</p>
