<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

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

	String userID=(String)session.getAttribute("userID");
	String operation=null;
	operation=request.getParameter("operation");
	if(operation==null){
		response.sendRedirect("showCart.jsp");
		con.close();
		stmt.close();
		return;
	}

	//提交订单操作
	if(operation.equals("0")){
		
		rs=stmt.executeQuery("select shop_cart.itemID,shop_cart.quantity,item.itemName,item.price,item.itemImage "+
		"from shop_cart,item "+
		"where shop_cart.uID='"+userID+"' and shop_cart.itemID = item.itemID "+
		"order by scID ");
		
		if(rs.isLast()){
			response.sendRedirect("showCart.jsp");
			con.close();
			stmt.close();
			return;
		}
		
		//计算总价
		int totalPrice=0;
		while(rs.next()){
			int quantity=rs.getInt(2);
			int price=rs.getInt(4);
			totalPrice+=quantity*price;
		}
		//java.util.Date转换为Timestamp  
		Date dt = new Date(); 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentTime=sdf.format(dt);
		out.print(currentTime);
		
		//创建订单
		stmt.executeUpdate("insert into order_list(uID,price,time) values('"+userID+"','"+totalPrice+"','"+currentTime+"')");
		ResultSet orderInfo;
		orderInfo=stmt.executeQuery("select * from order_list where time='"+currentTime+"'");
		orderInfo.first();
		String orderID=orderInfo.getString(1);
		
		Statement tempstmt=con.createStatement();
		try{
			rs=stmt.executeQuery("select shop_cart.itemID,shop_cart.quantity,item.itemName,item.price,item.itemImage "+
				"from shop_cart,item "+
				"where shop_cart.uID='"+userID+"' and shop_cart.itemID = item.itemID "+
				"order by scID ");
			//添加订单内商品
			while(rs.next()){
				tempstmt.executeUpdate("insert into order_item(oID,quantity,itemID) values('"+orderID+"','"+rs.getString(2)+"','"+rs.getString(1)+"')");
			}
			stmt.executeUpdate("delete from shop_cart where uID='"+userID+"'");
		}catch(Exception e){out.println(e.getMessage());e.printStackTrace();}
		
		response.sendRedirect("showOrder.jsp");
		con.close();
		stmt.close();
		rs.close();
		return;
	}

	//支付操作
	if(operation.equals("1")){
		String orderID=null;
		orderID=request.getParameter("orderID");
		if(orderID==null){
			response.sendRedirect("showOrder.jsp");
			con.close();
			stmt.close();
			return;
		}
		rs=stmt.executeQuery("select * from order_list where oID='"+orderID+"'");
		if(rs.next()){
			stmt.executeUpdate("update order_list set oStatus='2' where oID='"+orderID+"'");
		}
		response.sendRedirect("showOrder.jsp");
		con.close();
		stmt.close();
		rs.close();
		return;
	}

	//删除订单
	if(operation.equals("2")){
		String orderID=null;
		orderID=request.getParameter("orderID");
		if(orderID==null){
			response.sendRedirect("showOrder.jsp");
			con.close();
			stmt.close();
			return;
		}
		rs=stmt.executeQuery("select * from order_list where oID='"+orderID+"'");
		if(rs.next()){
			if(rs.getString(5).equals("1")){//只有未支付时可以删除
				stmt.executeUpdate("delete from order_list where oID='"+orderID+"'");
				stmt.executeUpdate("delete from order_item where oID='"+orderID+"'");
			}
		}
		response.sendRedirect("showOrder.jsp");
		con.close();
		stmt.close();
		rs.close();
		return;
	}
%>

