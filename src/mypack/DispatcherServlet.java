package mypack;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import mypack.DatabaseConn;

public class DispatcherServlet extends HttpServlet {
  public void doGet(HttpServletRequest request,HttpServletResponse response)
    throws ServletException, IOException {
    ServletContext context=getServletContext(); 

    response.setContentType("text/html;charset=GB2312");
   
    PrintWriter out = response.getWriter();
    out.println("<html><head><title>FontServlet</TITLE></head>");
    out.println("<body>");
    out.println("<br>Email: "+context.getInitParameter("emailOfwebmaster"));
    out.println("<br>Path: "+context.getRealPath("/WEB-INF"));
    out.println("<br>MimeType: "+context.getMimeType("/WEB-INF/web.xml"));
    out.println("<br>MajorVersion: "+context.getMajorVersion()); 
    out.println("<br>ServerInfo: "+context.getServerInfo()); 
    out.println("</body></html>");
    
    context.log("这是ContextTesterServlet输出的日志。"); 
    out.close(); 
  }
}
