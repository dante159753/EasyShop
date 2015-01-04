<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="checkLogStatus.jsp"%>
<% 
//获取参数
int itemPerPage=4;
String pageIndex=(String)request.getParameter("pageIndex");
String pageTotle=(String)request.getParameter("pageTotle");
String searchKey=(String)request.getParameter("searchKey");
String attachPara="";/*翻页的时候将一块传查找字符串*/
if(pageIndex==null)pageIndex="0";/*表示第一次进入当前结果，计算总页数*/
if(searchKey!=null){
request.setAttribute("title","Search for "+searchKey);
attachPara="&searchKey="+searchKey;
}
else{
request.setAttribute("title","All Items");
}
%>
<%@ include file="header.jsp"%>
<form class="form-inline" role="form" action="showItem.jsp">
	<div class="form-group">
		<label class="sr-only" for="exampleInputEmail2">请输入关键字</label>
		<input type="text" class="form-control" name="searchKey" placeholder="请输入关键字">
	</div>

	<button type="submit" class="btn btn-default">Search</button>
</form>
<%
Connection con;
Statement stmt;
ResultSet rs;

Context ctx= new InitialContext();
DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/shopDB");
con=ds.getConnection();
stmt = con.createStatement();

//如果是第一次进入，计算总页数
if(pageIndex.equals("0")){
//获取个数
if(searchKey==null){
rs=stmt.executeQuery("select count(itemID) from item order by itemID");
}
else{
rs=stmt.executeQuery("select count(itemID) from item where itemName like '%"+searchKey+"%' order by itemID");
}

//计算页数
rs.first();
int nTotle=rs.getInt(1);
if(nTotle==0){
out.print("<h2>抱歉，未找到符合的商品</h2>");
}
pageIndex="1";
int pageSize=nTotle/itemPerPage+(nTotle%itemPerPage==0?0:1);
pageTotle=Integer.toString(pageSize);
}
int beginWith=itemPerPage*(Integer.parseInt(pageIndex)-1);
//获取结果
if(searchKey==null){
rs=stmt.executeQuery("select * from item order by itemID limit "+Integer.toString(beginWith)+","+Integer.toString(itemPerPage));
}
else{
rs=stmt.executeQuery("select * from item where itemName like '%"+searchKey+"%' order by itemID limit "+Integer.toString(beginWith)+","+Integer.toString(itemPerPage));
}

while(rs.next()){
%>
<div class='bs-callout bs-callout-warning col-md-9'>
	<h4>
		<a href='itemDetail.jsp?itemID=<%=rs.getString(1)%>'>
			<%=rs.getString(2)%>
		</a>
	</h4>
	<table class="table table-hover">
		<thead>
			<th>图片</th>
			<th>价格</th>
		</thead>
		<tbody>

		<tr>
			<td><img width='200' height='200' src='<%=rs.getString(3)%>'/></td>
			<td><h5 class='info'><%=rs.getString(5)%></td>
			</tr>

			</tbody>

		</table>

	</div>
	<%}

	String pageURL="showItem.jsp";

	%>
	<%@ include file="pages.jsp"%>


	<%@ include file="footer.jsp"%>