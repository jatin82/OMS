package com.fs;

import com.fs.Model;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class DeleteSentController extends HttpServlet {
    public DeleteSentController() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println(request.getParameterValues("cbox")+"cbox in get");
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("Entered");
		Model md = new Model();
		//System.out.println(request.getParameterValues("cbox")+"cbox in post");
		md.deleteSentMessage(request.getParameter("messId"),request.getParameterValues("cbox"));
		response.sendRedirect("sent.jsp");
	}

}
