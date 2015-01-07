<% request.setAttribute("title","welcome page");%>
<%@ include file="header.jsp"%>
<%@ include file="checkLogStatus.jsp"%>
<div class="wrapper-login center-block">
<h1>Welcome to Easy Shop ,<%=session.getAttribute("username")%>!</h1>
<a href="showItem.jsp"><h2>list all item</h2></a>
<a href="deleteSession.jsp"><h2>log out</h2></a>
</div>
<%@ include file="footer.jsp"%>