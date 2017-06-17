package com.fs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

public class Model {
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	boolean valid=false;
	static private String email;
	private String name;
	public void setName(String name)
	{
		this.name = name;
	}
	public void setEmail(String email)
	{
		this.email=email;
	}
	public String getEmail()
	{
		return email;
	}
	public String getName()
	{
		return name;
	}
	public ResultSet getMessage()
	{
		String sql = "select from1,subject,date,to1,message,star,messId,status from messageDetail where to1=? order by messId desc";
		
		try
		{
			con=ConnectDatabase.getConnect();
			ps=con.prepareStatement(sql);
			ps.setString(1, email);
			rs=ps.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN GETMESSAGE    "+e);
		}
		return rs;
	}
	public ResultSet getSent()
	{
		String sql = "select to1,subject,date,from1,message,star,messId from sentDetail where from1=? order by messId desc";
		try
		{
			con=ConnectDatabase.getConnect();
			ps=con.prepareStatement(sql);
			ps.setString(1, email);
			rs=ps.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN GETSENT    "+e);
		}
		return rs;
	}
	public boolean userExist(String to1)
	{
		String sql = "Select email from user";
		try{
			con=ConnectDatabase.getConnect();
			ps=con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
			{
				if(rs.getString(1).equals(to1))
					return true;
			}
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN USEREXIST    "+e);
		}		
		return false;
	}
	public boolean sendMessage(String to1,String from1,String subject,String message)
	{

		String sql1 = "insert into messageDetail(to1,from1,subject,message,date,status,star) values(?,?,?,?,?,?,?)";
		String sql2 = "insert into sentDetail(to1,from1,subject,message,date,status,star) values(?,?,?,?,?,?,?)";
		try{
			con=ConnectDatabase.getConnect();
			Date d= new Date();
			String dd=d.getDate()+"/"+(d.getMonth()+1)+"/"+(d.getYear()+1900)+","+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
			ps=con.prepareStatement(sql1);
			ps.setString(1,to1);
			ps.setString(2,from1);
			ps.setString(3,subject);
			ps.setString(4,message);
			ps.setString(5,dd);
			ps.setString(6,"unread");
			ps.setString(7,"no");
			ps.executeUpdate();
			
			ps=con.prepareStatement(sql2);
			ps.setString(1,to1);
			ps.setString(2,from1);
			ps.setString(3,subject);
			ps.setString(4,message);
			ps.setString(5,dd);
			ps.setString(6,"unread");
			ps.setString(7,"no");
			ps.executeUpdate();
			return true;
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN SENTMESSAGE    "+e);
		}		
		return false;
	}
	public ResultSet getStar()
	{
		String sql = "select from1,subject,date,to1,message,messId from messageDetail where to1=? and star='golden' order by messId desc";
		try
		{
			con=ConnectDatabase.getConnect();
			ps = con.prepareStatement(sql);
			ps.setString(1, getEmail());
			rs = ps.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN GETSTAR    "+e);
		}
		return rs;
	}
	public ResultSet getDraft()
	{
		String sql = "select from1,to1,subject,message,messId,status from draft where from1=?";
		try
		{
			con=ConnectDatabase.getConnect();
			ps = con.prepareStatement(sql);
			ps.setString(1, getEmail());
			rs = ps.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN GETDRAFT    "+e);
		}
		return rs;
	}
	public ResultSet countInbox()
	{
		String sql = "select count(*) from messageDetail where to1=? and status=?";
		try
		{
			con=ConnectDatabase.getConnect();
			ps=con.prepareStatement(sql);
			ps.setString(1,email);
			ps.setString(2,"unread");
			rs=ps.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN COUNTINBOX    "+e);
		}
		return rs;
	}
	public ResultSet countStarred()
	{
		String sql = "select count(*) from messageDetail where to1=? and star='golden'";
		try
		{
			con=ConnectDatabase.getConnect();
			ps=con.prepareStatement(sql);
			ps.setString(1,email);
			rs=ps.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN COUNTSTARRED    "+e);
		}
		return rs;
	}
	public ResultSet countDraft()
	{
		String sql = "select count(*) from draft where from1=?";
		try
		{
			con=ConnectDatabase.getConnect();
			ps=con.prepareStatement(sql);
			ps.setString(1,email);
			rs=ps.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN COUNTSTARRED    "+e);
		}
		return rs;
	}
	public String getTo1Name(String s)
	{
		String query="";
		String sql = "select name from user where email='";
		try
		{
			con=ConnectDatabase.getConnect();
			ps=con.prepareStatement(sql);
			ps = con.prepareStatement(sql+s+"'");
			rs = ps.executeQuery();
			rs.next();
			query =rs.getString(1);
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN COUNTDRAFT    "+e);
		}
		return query;
	}
	public ResultSet readInbox(String messId)
	{
		String sql = "select from1,subject,date,to1,message,star from messageDetail where messId=";
		try
		{
			con=ConnectDatabase.getConnect();
			ps = con.prepareStatement(sql+messId);
			rs = ps.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN READMESSAGE    "+e);
		}
		return rs;
	}
	public ResultSet readSent(String messId)
	{
		String sql = "select to1,subject,date,from1,message,star from sentDetail where messId=";
		try
		{
			con=ConnectDatabase.getConnect();
			ps = con.prepareStatement(sql+messId);
			rs = ps.executeQuery();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN READMESSAGE    "+e);
		}
		return rs;
	}
	public ResultSet updateStatus(String messId)
	{
		String sql = "update messageDetail set status='read' where messId=";
		try
		{
			con=ConnectDatabase.getConnect();
			ps = con.prepareStatement(sql+messId);
			ps.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN UPDATESTATUS   "+e);
		}
		return rs;
	}
	
	public boolean deleteInboxMessage(String messId,String cbox[])
	{
		try
		{
			con=ConnectDatabase.getConnect();
			if(messId==null){
				System.out.println(cbox);
				for(String s :cbox)
				{
					ps = con.prepareStatement("delete from messageDetail where messId=?");
					ps.setString(1, s);
					ps.executeUpdate();
				}
			}
			else
			{
				ps = con.prepareStatement("delete from messageDetail where messId=?");
				ps.setString(1, messId);
				ps.executeUpdate();
			}
			return true;

		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN DELETEINBOXMESSAGE   "+e);
		}
		return false;
	}
	public boolean deleteSentMessage(String messId,String cbox[])
	{
		try
		{
			con=ConnectDatabase.getConnect();
			if(messId==null){
				for(String s :cbox)
				{
					ps = con.prepareStatement("delete from sentDetail where messId=?");
					ps.setString(1, s);
					ps.executeUpdate();
				}
			}
			else
			{
				ps = con.prepareStatement("delete from sentDetail where messId=?");
				ps.setString(1, messId);
				ps.executeUpdate();
			}
			return true;

		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN DELETESENTMESSAGE   "+e);
		}
		return false;
	}
	public boolean deleteDraft(String messId,String cbox[])
	{
		try
		{
			con=ConnectDatabase.getConnect();
			if(messId==null){
				for(String s :cbox)
				{
					ps = con.prepareStatement("delete from draft where messid=?");
					ps.setString(1, s);
					ps.executeUpdate();
				}
			}
			else
			{
				ps = con.prepareStatement("delete from draft where messid=?");
				ps.setString(1, messId);
				ps.executeUpdate();
			}
			return true;

		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN DELETEDRAFT   "+e);
		}
		return false;
	}
	public boolean discardDraft(String messId)
	{
		String sql1 = "delete from draft where from1=? and status='current'";
		String sql2 = "delete from draft where messId=";
		try
		{
			con=ConnectDatabase.getConnect();
			if(messId!="")
			{
				ps = con.prepareStatement(sql2+messId);
				ps.executeUpdate();
			}
			else
			{
				ps = con.prepareStatement(sql1);
				ps.setString(1, email);
				ps.executeUpdate();
			}
			return true;

		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN DiscardDRAFT   "+e);
		}
		return false;
	}
	public ResultSet getComposeMessage(String messId)
	{
		try
		{
			con = ConnectDatabase.getConnect();
			ps = con.prepareStatement("select to1,subject,message from draft where messId=?");
			ps.setString(1, messId);
			rs = ps.executeQuery();
			return rs;
		}
		catch(Exception e)
		{
			System.out.println("            ERROR IN ComposeMessage   "+e);
		}
		return null;
	}
}
