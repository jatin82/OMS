<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<jsp:useBean id="md" class="com.fs.Model"></jsp:useBean>
<%
md.deleteDraft(request.getParameter("messId"),request.getParameterValues("cbox"));
response.sendRedirect("draft.jsp");
%>