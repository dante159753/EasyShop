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
<%@ include file="navbar.jsp"%>
<div class="container">
<h2 align='center'>订单详情</h2>

<div class='col-md-12'>
	<table class="table table-hover">
<thead>
						<tr><th colspan="2">
<a href='showOrder.jsp' class='btn btn-default btn-block'>返回</a></th></tr>
			<tr></thead>
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
<tr>
	<td colspan="2">
		<a href='javascript:confirmCancel(<%=request.getParameter("orderID")%>)' class="btn btn-danger btn-block">取消订单</a>
	</td>
</tr>

	</table>
</div>
</div>



<script type="text/javascript">
function confirmCancel(orderID) {
	if(confirm("确认取消订单？"))
		location.href = "orderManager.jsp?orderID=" + orderID + "&operation=2";
}
</script>


<%@ include file="footer.jsp"%>

