package com.fs;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class FirstServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String jdbc = "com.mysql.jdbc.Driver";
    private static final String db_url = "jdbc:mysql://localhost/ducat";
    private static final String user = "root";
    private static final String db_pass = "mysql@2016";
    private static final String sql = "select email , password from user";
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    boolean valid = false;
    public FirstServer() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		
		try
		{
			Class.forName(jdbc);
			con = DriverManager.getConnection(db_url,user,db_pass);
			ps = con.prepareStatement(sql);//, resultSetType, resultSetConcurrency)
			rs = ps.executeQuery();
			while(rs.next())
			{
				if(rs.getString(1).equals(email)&&rs.getString(2).equals(pass)){
					valid =true;
					break;
				}
			}
			if(valid)
			{
				RequestDispatcher rd = request.getRequestDispatcher("Inbox");
				rd.forward(request, response);
			}
			else
			{
				out.print("<html><body><p>Email or password Incorrect</p></body></html>");
				RequestDispatcher rd = request.getRequestDispatcher("index.html");
				rd.include(request, response);
			}
		}
		catch(Exception e)
		{
			out.print(e);
		}
	}
}
