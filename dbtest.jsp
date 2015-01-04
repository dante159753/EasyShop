<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<html>
	<head>
		<TITLE>dbtest</TITLE>
	</head>
	<body>
	<%
	try{
		Connection con;
		Statement stmt;
		ResultSet rs;

		Context ctx= new InitialContext();
		DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/shopDB");
		con=ds.getConnection();

		stmt = con.createStatement();
		rs=stmt.executeQuery("select * from user");
		out.println("<table border=1 width=400>");
		while(rs.next()){
			String col1 = rs.getString(1);
			String col2 = rs.getString(2);
			String col3 = rs.getString(3);
			//String col4 = rs.getString(4);
			
			out.println("<tr><td>"+col1+"</td><td>"+col2+"</td><td>"+col3+"</td></tr>");
		}
		out.println("</table>");
	rs.close();
	stmt.close();
	con.close();
	}catch(Exception e){out.println(e.getMessage());e.printStackTrace();}

	%>
	</body>
</html>




