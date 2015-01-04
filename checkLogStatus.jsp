<%
String userID="";
userID=(String)session.getAttribute("username");
if(userID==null){
	response.sendRedirect("login.jsp");
}
%>
