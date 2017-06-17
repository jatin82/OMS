<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%!
/*Connection con;
PreparedStatement ps;
ResultSet rs;
public static final String jdbc = "com.mysql.jdbc.Driver";
public static final String db_url = "jdbc:mysql://localhost/ducat";
public static final String user = "root";
public static final String db_pass = "mysql@2016";
public static final String sql = "update user set status='logout' where email='";*/
%>
<%
	/*String email = (String)session.getAttribute("email");
	Class.forName(jdbc);
	con = DriverManager.getConnection(db_url,user,db_pass);
	ps = con.prepareStatement(sql+email+"'");
	ps.executeUpdate();*/
	//session.invalidate();
	response.sendRedirect("validateSession.jsp");
%>	