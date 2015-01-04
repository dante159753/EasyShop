package mypack;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import mypack.DatabaseConn;

public class LoginCheckerServlet extends HttpServlet {
	public void service(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{

		

	}
	public boolean validation(String username,String password){
		try{
			Connection conn = DatabaseConn.getConnection();
			stmt = con.createStatement();
		rs=stmt.executeQuery("select * from user where user.username= '"
				+username
				+"' and user.password= '"
				+password+"'");
		if(rs.next()){
			session.setAttribute("userID",rs.getString(1));
			session.setAttribute("username",rs.getString(2));

			response.sendRedirect("/EasyShop/welcome.jsp");
		}


		}catch(Exception e){
		}

}


