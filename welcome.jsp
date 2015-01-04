<% request.setAttribute("title","welcome page");%>
<%@ include file="header.jsp"%>
<%@ include file="checkLogStatus.jsp"%>
<h1>Welcome to Easy Shop ,<%=session.getAttribute("username")%>!</h1>
<a href="deleteSession.jsp">log out</a>
<%@ include file="footer.jsp"%>
