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
	String itemID=null;
	itemID=request.getParameter("itemID");
	if(itemID==null){
		response.sendRedirect("showItem.jsp");
		con.close();
		stmt.close();
		return;
	}
	rs=stmt.executeQuery("select * from item where itemID='"+itemID+"'");

	//无相应商品
	if(rs.isLast()){
		response.sendRedirect("showItem.jsp");
		con.close();
		stmt.close();
		rs.close();
		return;
	}

	String userID=(String)session.getAttribute("userID");
	String operation=null;
	operation=request.getParameter("operation");
	if(operation==null){
		response.sendRedirect("showItem.jsp");
		con.close();
		stmt.close();
		rs.close();
		return;
	}

	rs=stmt.executeQuery("select * from shop_cart where uID='"+userID+"' and itemID='"+itemID+"'");
	//添加操作
	if(operation.equals("0")){

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
			response.sendRedirect("showCart.jsp");
			con.close();
			stmt.close();
			rs.close();
			return;
		}
	}

	//修改数量操作
	if(operation.equals("1")){
		//购物车中没有相应商品
		if(!rs.next()){
			response.sendRedirect("showCart.jsp");
			con.close();
			stmt.close();
			rs.close();
			return;
		}
		String changeTo=(String)request.getParameter("changeTo");
		if(changeTo==null){
			response.sendRedirect("showCart.jsp");
			con.close();
			stmt.close();
			rs.close();
			return;
		}
		if(changeTo.equals("plus")){
			int quantity=rs.getInt(4);
			changeTo=Integer.toString(quantity+1);
		}
		//改成0,转给删除操作
		if(changeTo.equals("0")){
			%>
			<jsp:forward page="cartManager.jsp">
			<jsp:param name="operation" value="2"/>
			</jsp:forward>
			<%
		}
		stmt.executeUpdate("update shop_cart set quantity='"+changeTo+"' where uID='"+userID+"' and itemID='"+itemID+"'");
		response.sendRedirect("showCart.jsp");
		con.close();
		stmt.close();
		rs.close();
		return;
			
	}

	//删除商品
	if(operation.equals("2")){
		//购物车没有相应商品
		if(!rs.next()){
			response.sendRedirect("showCart.jsp");
			con.close();
			stmt.close();
			rs.close();
			return;
		}
		stmt.executeUpdate("delete from shop_cart where uID='"+userID+"' and itemID='"+itemID+"'");
		response.sendRedirect("showCart.jsp");
		con.close();
		stmt.close();
		rs.close();
		return;
			
	}
%>
