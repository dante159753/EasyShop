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
//未设置商品Id跳出
String itemID=request.getParameter("itemID");
if(itemID==null){
response.sendRedirect("showItem.jsp");
}
rs=stmt.executeQuery("select * from item where itemID='"+itemID+"'");
//无相应商品
if(!rs.next()){
response.sendRedirect("showItem.jsp");
}

String userID=(String)session.getAttribute("userID");
String ope=(String)request.getParameter("operation");
if(ope==null){
response.sendRedirect("showItem.jsp");
}

rs=stmt.executeQuery("select * from shop_cart where uID='"+userID+"' and itemID='"+itemID+"'");
//添加操作
if(ope.equals("0")){

	//购物车中已存在该商品，数量加1
	if(rs.next()){
	%>
	<jsp:forward page="cartManager.jsp">
		<jsp:param name="operation" value="1"/>
		<jsp:param name="changeTo" value="plus"/>
	</jsp:forward>
	<%
		
	}
	else{
		stmt.executeUpdate("insert into shop_cart(uID,itemID,quantity) values('"+userID+"','"+itemID+"',1)");
		response.sendRedirect("showItem.jsp");
	}
}

//修改数量操作
if(ope.equals("1")){
	//购物车中没有相应商品
	if(!rs.next()){
		response.sendRedirect("showItems.jsp");
	}
	String changeTo=(String)request.getParameter("changeTo");
	if(changeTo==null){
		response.sendRedirect("showItem.jsp");
	}
	if(changeTo.equals("plus")){
		int quantity=rs.getInt(4);
		changeTo=Integer.toString(quantity+1);
	}
	stmt.executeUpdate("update shop_cart set quantity='"+changeTo+"' where uID='"+userID+"' and itemID='"+itemID+"'");
	response.sendRedirect("showItem.jsp");
		
}

//删除商品
if(ope.equals("2")){
	//购物车没有相应商品
	if(!rs.next()){
		response.sendRedirect("showItems.jsp");
	}
	stmt.executeUpdate("delete from shop_cart where uID='"+userID+"' and itemID='"+itemID+"'");
	response.sendRedirect("showItem.jsp");
		
}
%>
