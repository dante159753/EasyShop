<%
String check_userID="";
check_userID=(String)session.getAttribute("username");
if(check_userID==null){
	response.sendRedirect("login.jsp");
}
%>
