package com.fs;

import java.sql.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
import java.sql.*;
import com.fs.ConnectDatabase;


public class CustomTag extends TagSupport
{
	private String email;
	private String password;
	 
	public void setEmail(String email)
	{
		this.email=email;		
	}
	
	public void setPassword(String password)
	{
		this.password=password;
	}
	public int doStartTag() throws JspException
	{
		try
		{
			Connection con = ConnectDatabase.getConnect();
			PreparedStatement ps = con.prepareStatement("select email, password from user;");
			ResultSet rs = ps.executeQuery();
			JspWriter out=pageContext.getOut();
			while(rs.next())
			{
				if(rs.getString(1).equals(email)&&rs.getString(2).equals(password))
				{
					out.println("<b>Valid "+email+" and "+password+" entered </b>");
					return SKIP_BODY;
				}
			}
			out.println("<b>Not Valid</b>");
		}
		catch (Exception ioException)
		{
			System.err.println("IO Exception");
			System.err.println("ioException.toString()");
		}
		return SKIP_BODY;
	}
}
