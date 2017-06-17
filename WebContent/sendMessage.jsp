<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="md" class="com.fs.Model"></jsp:useBean>
<%
String from1=(String)session.getAttribute("email");
String to1=request.getParameter("to1");
String subject=request.getParameter("subject");
String message=request.getParameter("message");
String messId = request.getParameter("messId");
boolean valid=false;
	if(md.userExist(to1))
	{
		if(md.sendMessage(to1, from1, subject, message))
		{
			md.discardDraft(messId);
			response.sendRedirect("SentController");
		}
		else
			response.sendRedirect("ComposeController");
	}
	else
	{
%>
	<div class="alert alert-danger" style="position:absolute;top:500px;left:600px;"><strong>Error!! </strong><i><%=to1 %></i> does not exist</div>
	<jsp:include page="compose.jsp"></jsp:include>
<%
	}
%>