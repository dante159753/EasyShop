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
//获取参数
int itemPerPage=4;
String pageIndex=(String)request.getParameter("pageIndex");
String pagetotal=null;
String totalInfo=(String)request.getParameter("totalInfo");
pagetotal=request.getParameter("pagetotal");
//表示第一次进入当前结果，计算总页数
if(pageIndex==null){
	pageIndex="0";
	totalInfo="0";
}
if(totalInfo==null){
	totalInfo="0";
}
String attachPara="";

Connection con;
Statement stmt;
ResultSet rs;

Context ctx= new InitialContext();
DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/shopDB");
con=ds.getConnection();
stmt = con.createStatement();

request.setAttribute("title","My Order");

String searchKey=null;
%>

<%@ include file="header.jsp"%>
<%@ include file="navbar.jsp"%>
<br/><br/>

<%
//如果是第一次进入，计算总页数
if(pageIndex.equals("0")){
	int ntotal=0;
	//获取个数
	rs=stmt.executeQuery("select count(oID) from order_list where uID='"+userID+"'");

	//计算页数
	rs.first();
	ntotal=rs.getInt(1);
	pageIndex="1";
	int pageSize=ntotal/itemPerPage+(ntotal%itemPerPage==0?0:1);
	pagetotal=Integer.toString(pageSize);
	totalInfo=Integer.toString(ntotal);
	out.print("<h2 align='center'>订单列表<small><em>共 "+totalInfo+" 项订单， "+pagetotal+" 页</em></small></h2>");
	
	if(ntotal==0){
		out.print("<h2 align='center'>您还没有购买商品</h2>");
	}
}
else{
	out.print("<h2 align='center'>订单列表<small><em>共 "+totalInfo+" 项订单， "+pagetotal+" 页</em></small></h2>");
}

int beginWith=itemPerPage*(Integer.parseInt(pageIndex)-1);
//获取结果
rs=stmt.executeQuery("select order_list.*,order_status.osInfo "+
	"from order_list,order_status where order_list.uID='"+userID+"' and order_status.osID=order_list.oStatus "+
	"order by oID limit "+Integer.toString(beginWith)+","+Integer.toString(itemPerPage));
/*rs=stmt.executeQuery("select  "+
	"from order_list,item,order_item where order_list.uID='"+userID+"' "+
	"and order_list.oID = order_item.oID and order_item.itemID=item.itemID "+
	"order by oID limit "+Integer.toString(beginWith)+","+Integer.toString(itemPerPage));*/
%>
<div class="container">
<div class='bs-callout col-md-9'>
	<table class="table table-hover">
		<thead>
			<th>订单价格</th>
			<th>订单状态</th>
			<th>下单时间</th>
			<th>操作</th>
		</thead>
		<tbody>
		<%
		while(rs.next()){
		%>

			<tr>
				<td><h5>￥<%=rs.getString(3)%></h5></td>
				<td>
					<%=rs.getString(6)%>
					<%
					if(rs.getString(5).equals("1")){
						out.print("<a href='orderManager.jsp?operation=1&orderID="+rs.getString(1)+"'><button type='button' class='btn btn-primary btn-xs'>支付</button></a>");
					}
					%>
				</td>
				<td><h5><%=rs.getString(4)%></h5></td>
				<td>
				<%
				if(rs.getString(5).equals("1"))
				{%>
					<a href="javascript:confirmCancel(<%=rs.getString(1)%>)">取消订单</a>
				<%}%>
				<a href="showOrderDetail.jsp?orderID=<%=rs.getString(1)%>&operation=2">订单详情</a>
				</td>
			</tr>

			<%
			}
			%>

		</tbody>

	</table>
		

</div>
<div class='col-md-3'>
	<div class="panel panel-default">
		<div class="panel-body">
	<a href='showItem.jsp' class="btn btn-default btn-block">继续购物</a>
	</div>
</div>
</div>
</div>
<script type="text/javascript">
function confirmCancel(orderID) {
	if(confirm("确认取消订单？"))
		location.href = "orderManager.jsp?orderID=" + orderID + "&operation=2";
}
</script>
<%
rs.close();
stmt.close();
con.close();
String pageURL="showOrder.jsp";
%>
<%@ include file="pages.jsp"%>
<%@ include file="footer.jsp"%>

