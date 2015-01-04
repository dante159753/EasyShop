<% request.setAttribute("title","welcome page");%>
<%@ include file="header.jsp"%>
<%@ include file="checkLogStatus.jsp"%>
<h1>Welcome to Easy Shop ,<%=session.getAttribute("username")%>!</h1>
<a href="showItem.jsp"><h2>list all item</h2></a>
<a href="deleteSession.jsp"><h2>log out</h2></a>
<%@ include file="footer.jsp"%>
