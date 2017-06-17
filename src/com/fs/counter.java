package com.fs;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.sql.*;
/**
 * Servlet implementation class counter
 */
public class counter extends HttpServlet implements Runnable
{   
	public counter() {
        super();
        // TODO Auto-generated constructor stub
    }
	static int count=0;
	Connection con;
	PreparedStatement ps;
	public void run()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost/ducat","root","mysql@2016");
			while(true)
			{
				Date d = new Date();
				String dd=d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
				ps=con.prepareStatement("insert into counter values(?, ?)");
				ps.setInt(1,count);
				ps.setString(2,dd);
				ps.executeUpdate();
				Thread.sleep(60*1000);
			}	
		}
		catch(Exception e)
		{
			
		}
	}
	public void init()
	{
		counter c= new counter();
		Thread t = new Thread(c);
		t.start();
	
	}
	public void doGet(HttpServletRequest req,HttpServletResponse res)throws IOException,ServletException
	{	
		
		PrintWriter out=res.getWriter();
		getServletContext().setAttribute("count",count++);
		out.print(getServletContext().getAttribute("count"));
		
	}
	
}


