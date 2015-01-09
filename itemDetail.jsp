<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%@ page contentType="text/html; charset=utf-8" %>

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

String searchKey=null;
%>


<%@ include file="header.jsp"%>
<%@ include file="navbar.jsp"%>

<div class="container">
<div class='col-md-12'>
<a href='showItem.jsp'><button type='button' class='btn btn-primary'>返回</button></a>
</div>
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
		<% if (userID == null) {%>
		<a href='login.jsp' class='btn btn-primary'>加入购物车</a>
		<%}else{%>
		<a href='javascript:appendToCart(<%=itemID%>)' class='btn btn-primary'>加入购物车</a>
		<%}%>
	</div>
	<div class='col-md-3'>
		<h5>商品详情:<br/><%=rs.getString(4)%></h5>
	</div>
</div>
</div>
<script type="text/javascript">
function appendToCart(itemID) {
	var url = "cartManager.jsp?operation=0&itemID=" + itemID;
	htmlobj = $.ajax({
		url: url,
		type: 'POST',
		async: false,
		success: function() {
			alert('已添加到购物车！');
		}
	});
}
</script>

<%@ include file="footer.jsp"%>

