package mypack;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class DispatcherServlet extends GenericServlet {
	public void service(ServletRequest request. ServletResponse response)
		throws ServletException, IOException{
		ServletContext context=getServletContext();
		RequestDispatcher dispatcher = context.getRequestDispatcher("/hello.jsp");
		dispatcher.forward(request,response);
	}
}

