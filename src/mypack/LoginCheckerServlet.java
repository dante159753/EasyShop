package mypack;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class DispatcherServlet extends GenericServlet {
	public void service(ServletRequest request. ServletResponse response)
		throws ServletException, IOException{
		Connection con;
		Statement stmt;
		ResultSet rs;

		Context ctx= new InitialContext();
		DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/shopDB");
		con=ds.getConnection();

		stmt = con.createStatement();

		dispatcher.forward(request,response);
	}
}


