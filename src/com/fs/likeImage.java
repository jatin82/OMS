package com.fs;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class likeImage extends HttpServlet {
	public void init()
	{
		getServletContext().setAttribute("1", 0);
		getServletContext().setAttribute("2", 0);
		getServletContext().setAttribute("3", 0);
		getServletContext().setAttribute("4", 0);
		getServletContext().setAttribute("5", 0);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		//String update = request.getParameter("id");
		//getServletContext().setAttribute(update, (int)getServletContext().getAttribute(update)+1);
		if(request.getParameter("send").equals("yes"))
		{
			for(int i=1;i<=5;i++)
			{
				if(request.getParameter("id"+i)!=null)
				{
					getServletContext().setAttribute(i+"", (int)getServletContext().getAttribute(i+"")+1);
					break;
				}
			}
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("likeImage.html");
		String str = "<div style='position:absolute;top:40px;right:40px; width:100px;height:500px'>";
		str+="<span style='position:absolute;top:100px;left:10px'>"+getServletContext().getAttribute("1")+"</span>";
		str+="<span style='position:absolute;top:200px;left:10px'>"+getServletContext().getAttribute("2")+"</span>";
		str+="<span style='position:absolute;top:300px;left:10px'>"+getServletContext().getAttribute("3")+"</span>";
		str+="<span style='position:absolute;top:400px;left:10px'>"+getServletContext().getAttribute("4")+"</span>";
		str+="<span style='position:absolute;top:500px;left:10px'>"+getServletContext().getAttribute("5")+"</span></div>";
		out.print(str);
		//out.print("value jatin:"+name);
		rd.include(request, response);
	}
}
