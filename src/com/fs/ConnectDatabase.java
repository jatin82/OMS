package com.fs;

import java.sql.*;

public class ConnectDatabase {
	private static Connection con;
	public static Connection  getConnect()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql:///oms","root","mysql@2016");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println(e+" from connect Database");
		}
		return con;
	}
}
