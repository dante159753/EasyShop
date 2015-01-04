package mypack;
import java.sql.*;
import javax.naming.*;
import javax.sql.DataSource;
public class DatabaseConn {
	public static  synchronized  Connection getConnection() 
		throws Exception
	{
		try
		{

			Context initCtx = new javax.naming.InitialContext(); 
			DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/shopDB"); 
			return ds.getConnection();
		}
		catch(SQLException e)
		{
			throw e;
		}
		catch(NamingException e)
		{
			throw e;
		}  
	}
}   
