package com.fs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class NewServer
 */
public class NewServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public static final String jdbc = "com.mysql.jdbc.Driver";
    public static final String db_url = "jdbc:mysql://localhost/ducat";
    public static final String user = "root";
    public static final String db_pass = "mysql@2016";
    public static final String sql1 = "select email from user";
    public static final String sql2 = "insert into user values(?,?,?,?)";
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    boolean valid =false;
    public NewServer() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String email = request.getParameter("email");
		try{
			Class.forName(jdbc);
			con = DriverManager.getConnection(db_url,user,db_pass);
			ps = con.prepareStatement(sql1);
			rs = ps.executeQuery();
			while(rs.next())
			{
				if(rs.getString(1).equals(email))
				{
					valid=true;
					break;
				}
			}
			RequestDispatcher rd;
			if(valid){
				out.print("<html><body><p>Email already exist</p></body></html>");
				rd = request.getRequestDispatcher("NewUser.html");
				rd.include(request, response);
			}
			else
			{
				String pass= request.getParameter("pass");
				String name= request.getParameter("name");
				String phone= request.getParameter("phone");
				ps = con.prepareStatement(sql2);
				ps.setString(2, email);
				ps.setString(3, pass);
				ps.setString(1, name);
				ps.setInt(4, Integer.parseInt(phone));
				ps.executeUpdate();
				rd = request.getRequestDispatcher("index.html");
				rd.forward(request,response);
			}
		}
		catch(Exception e){
			out.print(e);
		}
	}
}
