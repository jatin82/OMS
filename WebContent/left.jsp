<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<jsp:useBean id="md" class="com.fs.Model"></jsp:useBean>
<div class="gridOut">
	<div class=<%= (String)request.getAttribute("compose")%> id="compose"><a href="ComposeController">Compose</a></div>
	<div class=<%= (String)request.getAttribute("inbox")%> id="inbox"><a href="MainInbox">Inbox
<%!
	ResultSet rs;
%>
<%
		rs = md.countInbox();
		rs.next();
%>
(<%= rs.getString(1) %>)
	</a></div>
	<div class=<%= (String)request.getAttribute("starred")%> ><a href="StarredController" id="starred">Starred
<%
			rs = md.countStarred();
			rs.next();
%>
			(<%= rs.getString(1) %>)	
	</a></div>
	
	<div class=<%= (String)request.getAttribute("draft")%>><a href="DraftController" id="draft">Draft
<%
			rs = md.countDraft();
			rs.next();
%>
			(<%= rs.getString(1) %>)	
</a></div>
	<div class=<%= (String)request.getAttribute("sent")%> id="sent"><a href="SentController">Sent</a></div>
</div>
