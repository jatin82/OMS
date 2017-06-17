package com.fs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class updateStar extends HttpServlet {
    private static final String sql1 = "update messageDetail set star=? where messId=";
    
    String gold = "goldenStar.png";
    
    Connection con = ConnectDatabase.getConnect();
    PreparedStatement ps;
    ResultSet rs;
	public updateStar() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		out.print("working");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String messId =  request.getParameter("messId");
		String type =  request.getParameter("type");
		String updateStar=null;
		if(request.getParameter("updateStar")!=null)
			updateStar = "yes";
		try {
			if(updateStar!=null&&updateStar.equals("yes"))
			{
				ps = con.prepareStatement("select count(*) from messageDetail where to1=? and star='golden'");
				ps.setString(1, (String)request.getSession().getAttribute("email"));
				rs = ps.executeQuery();
				rs.next();
				int cnt = rs.getInt(1);
				out.print("Starred ("+cnt+")");
				return;
			}
			ps = con.prepareStatement(sql1+messId);

			String [] result = type.split("/");
			
			if(result[result.length-1].equals(gold)){ // here url used
				ps.setString(1, "transparent");
				ps.executeUpdate();
				out.print("style/transparentStar.png");
			}
			else{
				ps.setString(1, "golden");
				ps.executeUpdate();
				out.print("style/goldenStar.png");
			}
		} 
		catch (Exception e) {
			out.print(e);
		}
	}

}
