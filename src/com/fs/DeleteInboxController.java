package com.fs;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class DeleteInboxController extends HttpServlet {
    public DeleteInboxController() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Model md = new Model();
		md.deleteInboxMessage(request.getParameter("messId"),request.getParameterValues("cbox"));
		response.sendRedirect("mainInbox.jsp");
	}

}
