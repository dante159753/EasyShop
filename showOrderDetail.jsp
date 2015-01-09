<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="checkLogStatus.jsp"%>

<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

Connection con;
Statement stmt;
ResultSet rs;

Context ctx= new InitialContext();
DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/shopDB");
con=ds.getConnection();
stmt = con.createStatement();

String orderID=request.getParameter("orderID");
if(orderID==null){
response.sendRedirect("showOrder.jsp");
}
rs=stmt.executeQuery("select * from order_list where oID='"+orderID+"'");
if(!rs.next()){
response.sendRedirect("showOrder.jsp");
}
request.setAttribute("title","Order Detail");
%>

<%@ include file="header.jsp"%>

<h2 align='center'>订单详情</h2>
<a href='showOrder.jsp'><button type='button' class='btn btn-primary'>返回</button></a>

<div class='col-md-12'>
	<table class="table table-hover">

			<tr>
				<td>订单号</td>
				<td><%=rs.getString(1)%></td>
			</tr>
			<tr>
				<td>总价</td>
				<td>￥<%=rs.getString(3)%></td>
			</tr>
			<tr>
				<td>下单时间</td>
				<td><%=rs.getString(4)%></td>
			</tr>
			<tr>
				<td>状态</td>
				<td><%=rs.getString(5)%></td>
			</tr>
			<tr>
				<td>商品</td>
				<td>
					<table class='table table-hover'>
<%
rs=stmt.executeQuery("select item.itemID,order_item.quantity,item.itemName,item.itemImage,item.price "+
	"from order_item,item where order_item.oID='"+orderID+"' and order_item.itemID=item.itemID");
while(rs.next()){
%>
						<tr>
							<td>
								<img width='100' height='100' src='<%=rs.getString(4)%>'/>
							</td>
							<td>
								<a href="itemDetail.jsp?itemID=<%=rs.getString(1)%>"><%=rs.getString(3)%></a>
							</td>
							<td><%=rs.getString(5)%></td>
							<td><%=rs.getString(2)%>个</td>
						</tr>
<%}
%>
					</table>
					
				</td>
			</tr>


	</table>
</div>






<%@ include file="footer.jsp"%>

