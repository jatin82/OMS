<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%!
/*Connection con;
PreparedStatement ps;
ResultSet rs;
public static final String jdbc = "com.mysql.jdbc.Driver";
public static final String db_url = "jdbc:mysql://localhost/ducat";
public static final String user = "root";
public static final String db_pass = "mysql@2016";
public static final String sql = "select status from user where email='";*/
%>
<!DOCTYPE body PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<p>please wait...</p>
<%
if(session.isNew())
	response.sendRedirect("MainInbox");
else
{
	session.invalidate();
	response.sendRedirect("index.html");
}
	/*String email = (String)session.getAttribute("email");
	Class.forName(jdbc);
	con = DriverManager.getConnection(db_url,user,db_pass);
	ps = con.prepareStatement(sql+email+"'");
	rs = ps.executeQuery();
	while(rs.next())
	{
		if(rs.getString(1).equals("login"))
			response.sendRedirect("mainInbox.jsp");
		else
		{
			session.invalidate();
			response.sendRedirect("index.html");
		}
	}*/
%>
</body>
</html>