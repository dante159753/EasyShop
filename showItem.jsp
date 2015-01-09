<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%@ page contentType="text/html; charset=utf-8" %>
<meta. http-equiv="Content-Type" content="text/html; charset=gb2312">

<!--在设置title后加载头，否则会没有标题-->
<%@ include file="header.jsp"%>
<!--searchKey 先在前面获取，后面才能在搜索框显示相应搜索文字-->
<%@ include file="navbar.jsp"%>
<% 
//获取参数
int itemPerPage=8;
String pageIndex=(String)request.getParameter("pageIndex");
String pagetotal=(String)request.getParameter("pagetotal");
searchKey=(String)request.getParameter("searchKey");
String totalInfo="";
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

<div class="container" style="margin-top:70px">

<% if(searchKey!=null){
out.print("<a href='showItem.jsp'>返回全部结果</a>");
}
%>

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
int ntotal=rs.getInt(1);
if(ntotal==0){
out.print("<h2>抱歉，未找到符合的商品</h2>");
}
pageIndex="1";
int pageSize=ntotal/itemPerPage+(ntotal%itemPerPage==0?0:1);
pagetotal=Integer.toString(pageSize);
}
int beginWith=itemPerPage*(Integer.parseInt(pageIndex)-1);
//获取结果
if(searchKey==null){
rs=stmt.executeQuery("select * from item order by itemID limit "+Integer.toString(beginWith)+","+Integer.toString(itemPerPage));
}
else{
rs=stmt.executeQuery("select * from item where itemName like '%"+searchKey+"%' order by itemID limit "+Integer.toString(beginWith)+","+Integer.toString(itemPerPage));
}
%>
<div class="itemList row">
<%
while(rs.next()){
%>
<div class="col-md-3">
<div class="thumbnail" style="">
	<a href="itemDetail.jsp?itemID=<%=rs.getString(1)%>" title="<%=rs.getString(2)%>">
      <img data-src="<%=rs.getString(3)%>" width="200" height="200" src="<%=rs.getString(3)%>" alt="...">
  </a>
      <div class="caption">
        <a href="itemDetail.jsp?itemID=<%=rs.getString(1)%>" title="<%=rs.getString(2)%>"><%=rs.getString(2)%></a>
        <p><span style="font-size:1.5em">¥ <%=rs.getString(5)%></span>
        &nbsp;</p>
      </div>
    </div>
    </div>
<!-- <div class='bs-callout bs-callout-warning'>
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
			<td><h5 class='info'>¥<%=rs.getString(5)%></td>
			</tr>

		</tbody>

	</table>

</div> -->
<%}%>
</div>
<%
rs.close();
stmt.close();
con.close();
String pageURL="showItem.jsp";

%>

<%@ include file="pages.jsp"%>

</div>
<%@ include file="footer.jsp"%>