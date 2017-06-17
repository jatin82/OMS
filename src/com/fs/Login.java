package com.fs;

import java.sql.*;
public class Login {

	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	boolean valid=false;
	private String email;
	private String name;
	private String pass;
	private String phone;
	public void setName(String name)
	{
		this.name = name;
	}
	public void setEmail(String email)
	{
		this.email=email;
	}
	public void setPass(String pass)
	{
		this.pass=pass;
	}
	public void setPhone(String phone)
	{
		this.phone=phone;
	}
	public String getEmail()
	{
		return email;
	}
	public String getPass()
	{
		return pass;
	}
	public String getName()
	{
		return name;
	}
	public String getPhone()
	{
		return phone;
	}
	public boolean getUser()
	{
		try
		{
			con=ConnectDatabase.getConnect();
			ps=con.prepareStatement("select email from user");
			rs=ps.executeQuery();
			while(rs.next())
			{
				if(email.equals(rs.getString(1)))
				{
					valid=true;
				}
			}
		
			if(!valid)
			{
				ps=con.prepareStatement("insert into user (name,email,password,phone,logout) values(?,?,?,?,?)");
				ps.setString(1,name);
				ps.setString(2,email);
				ps.setString(3,pass);
				ps.setInt(4,Integer.parseInt(phone));
				ps.setString(5,"logout");
				ps.executeUpdate();				
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return valid;
	}
	public boolean getLogin()
	{
		try
		{
			con=ConnectDatabase.getConnect();
			
			ps=con.prepareStatement("select email,password from user");
			rs=ps.executeQuery();
			while(rs.next())
			{
				if(email.equals(rs.getString(1)) && pass.equals(rs.getString(2)))
				{
					valid=true;
				}
			}
		}catch(SQLException e){
			System.out.println("Something went wrong");
			try {
				DatabaseMetaData check = con.getMetaData();
				ResultSet res = check.getTables(null, null, "messageDetail",new String[] {"TABLE"});
				if(res.getFetchSize()==0)
					CreateTables.create();
				
			} catch (SQLException e1) {
				e1.printStackTrace();
				System.out.println("Could not Connect To Database");
			}
			
		}
		return valid;
	}
	
}
