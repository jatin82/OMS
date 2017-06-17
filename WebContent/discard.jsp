<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<jsp:useBean id="md" class="com.fs.Model"></jsp:useBean>
<% 
	md.discardDraft(request.getParameter("messId"));
	response.sendRedirect("mainInbox.jsp");
%>