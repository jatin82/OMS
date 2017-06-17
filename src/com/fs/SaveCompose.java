package com.fs;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SaveCompose extends HttpServlet {
 	
    private static final String sql1 = "insert into draft (";//) values(?)";
    private static final String sql2 = "select messId from draft where from1=? and status='current'";
    private static final String sql3 = "update draft set ";//+data+"=? where messId=?";
    
    Connection con = ConnectDatabase.getConnect();
    PreparedStatement ps;
    ResultSet rs;
    public SaveCompose() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		int messId=0;
		boolean newDraft = true;
		String dataContent=null,from1=null,data=null,updateDraft=null,id=null;
		if(request.getParameter("updateDraft")!=null)
			updateDraft = "yes";
		if(request.getParameter("messId")!=null&&!request.getParameter("messId").equals("null"))
			id = request.getParameter("messId");
		if(request.getParameter("to1")!=null)
			data = "to1";
		else if(request.getParameter("subject")!=null)
			data = "subject";
		else if(request.getParameter("message")!=null)
			data ="message";
		if(data!=null||updateDraft!=null)
		{
			try 
			{
				from1 = (String)request.getSession().getAttribute("email");
				if(updateDraft!=null&&updateDraft.equals("yes"))
				{
					ps = con.prepareStatement("select count(*) from draft where from1=?");
					ps.setString(1, from1);
					rs = ps.executeQuery();
					rs.next();
					int cnt = rs.getInt(1);
					out.print("Draft ("+cnt+")");
					return;
				}
				dataContent = request.getParameter(data);
				if(id!=null)
				{
					ps = con.prepareStatement(sql3+data+"=? where messId="+id);
					ps.setString(1, dataContent);
					ps.executeUpdate();
					out.print("Saved");
					return;
				}
				ps = con.prepareStatement(sql2);
				ps.setString(1, from1);
				rs = ps.executeQuery();
				if(rs.first())
				{
					messId = rs.getInt(1);
					newDraft = false;
				}
				if(newDraft)
				{
					ps = con.prepareStatement(sql1+data+",status,from1) values(?,?,?)");
					ps.setString(1, dataContent);
					ps.setString(2,"current");
					ps.setString(3, from1);
					ps.executeUpdate();
				}
				else
				{
					ps = con.prepareStatement(sql3+data+"=? where messId=?");
					ps.setString(1, dataContent);
					ps.setInt(2, messId);
					ps.executeUpdate();
				}
				out.print("Saved");
				return;
			} 
			catch (Exception e) {
				out.print(e);
			}
		}
		out.print("Not Saved from server");
	}
}
