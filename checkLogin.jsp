<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<html>
	<body>
	<%
	try{

		String username=(String)request.getParameter("username");
		String password=(String)request.getParameter("password");

		Connection con;
		Statement stmt;
		ResultSet rs;

		Context ctx= new InitialContext();
		DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/shopDB");
		con=ds.getConnection();

		stmt = con.createStatement();
		rs=stmt.executeQuery("select * from user where user.username= '"+request.getParameter("username")+"' and user.password= '"+request.getParameter("password")+"'");
		if(rs.next()){

			session.setAttribute("userID",rs.getString(1));
			session.setAttribute("username",rs.getString(2));

			response.sendRedirect("showItem.jsp");
		}
		else{
		request.setAttribute("status","1");
		%>
		<jsp:forward page="login.jsp"/>
		<%}
	rs.close();
	stmt.close();
	con.close();
	}catch(Exception e){out.println(e.getMessage());e.printStackTrace();}

	%>
	</body>
</html>




