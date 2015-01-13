<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%
try{

	String username=(String)request.getParameter("username");
	String password=(String)request.getParameter("password");
	String repeatPassword=(String)request.getParameter("repeatPassword");

	if(username.length()==0||password.length()==0){
	request.setAttribute("status","0");
	%>
	<jsp:forward page="signUp.jsp"/>
	<%}

	if(!password.equals(repeatPassword)){
	request.setAttribute("status","2");
	%>
	<jsp:forward page="signUp.jsp"/>
	<%}

	Connection con;
	Statement stmt;
	ResultSet rs;

	Context ctx= new InitialContext();
	DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/shopDB");
	con=ds.getConnection();

	stmt = con.createStatement();
	rs=stmt.executeQuery("select * from user where user.username= '"+request.getParameter("username")+"'");
	if(rs.next()){

		request.setAttribute("status","1");
	%>
	<jsp:forward page="signUp.jsp"/>
	<%
		rs.close();
		stmt.close();
		con.close();
		return;
	}
	else{
		//增加新记录
		stmt.executeUpdate("insert into user(username,password) values ('"+username+"','"+password+"')");
		rs=stmt.executeQuery("select * from user where username='"+username+"'");
		rs.first();
		session.setAttribute("userID",rs.getString(1));
		session.setAttribute("username",rs.getString(2));

		response.sendRedirect("showItem.jsp");
	}
	
	
rs.close();
stmt.close();
con.close();
}catch(Exception e){out.println(e.getMessage());e.printStackTrace();}

%>





