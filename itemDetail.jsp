<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="checkLogStatus.jsp"%>

<% 
Connection con;
Statement stmt;
ResultSet rs;

Context ctx= new InitialContext();
DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/shopDB");
con=ds.getConnection();
stmt = con.createStatement();

String itemID=request.getParameter("itemID");
if(itemID==null){
response.sendRedirect("showItem.jsp");
}
rs=stmt.executeQuery("select * from item where itemID='"+itemID+"'");
if(!rs.next()){
response.sendRedirect("showItem.jsp");
}
%>


<%@ include file="header.jsp"%>

<div class='bs-callout bs-callout-warning col-md-12'>
	
	<div class='col-md-12'>
		<h2 align='center'><%=rs.getString(2)%></h2>
	</div>
	<div class='col-md-9'>
		<img src='<%=rs.getString(3)%>' />
	</div>
	<div class='col-md-3'>
		<h4>¥<%=rs.getString(5)%></h4>
	</div>
	<div class='col-md-3'>
		<a href='cartManager.jsp?operation=0&itemID=<%=itemID%>'><button type='button' class='btn btn-primary'>add to cart</button></a>
	</div>
	<div class='col-md-3'>
		<h5>商品详情:<br/><%=rs.getString(4)%></h5>
	</div>
</div>



<%@ include file="footer.jsp"%>
