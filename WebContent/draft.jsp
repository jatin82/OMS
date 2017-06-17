<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%!
ResultSet rs;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Draft</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="style/myStyle.css" />
</head>
<script type="text/javascript">
function finalCheck()
{
	if(document.deleteItem.cbox!=null) //when there are no messages
	{
		if(document.deleteItem.cbox.checked==true)
			return true;
		for(var i=0;i<document.deleteItem.cbox.length;i++)
		if(document.deleteItem.cbox[i].checked==true) //does any checkbox have checked or not
			return true;
	}
	return false; 
}
</script>
<%
request.setAttribute("compose", "grid");
request.setAttribute("inbox", "grid");
request.setAttribute("starred", "grid");
request.setAttribute("draft", "active");
request.setAttribute("sent", "grid");
%>
<body class="mailBody">
	<div><jsp:include page="top.jsp"></jsp:include></div>
	<div class="container">
		<div class="row">
			<div class="col-sm-push-1 col-sm-3 col-lg-2"><jsp:include page="left.jsp"></jsp:include></div>
			<div class="col-sm-push-1 col-sm-7 col-lg-8">
			<form method="post" action="deleteDraft.jsp" name="deleteItem" onsubmit ="return finalCheck()">
			<div class="row inboxMail">
				<div class="row"><button class="col-sm-2 buttonImage" type="submit"><img src="style/bin.jpg" alt="delete" class="iconImage" /></button></div>
			</div>
<jsp:useBean id="md" class="com.fs.Model"></jsp:useBean>
<%

	boolean valid = false;
	rs= md.getDraft();
	while(rs.next())
	{
		String subject = "No subject";
		String to1 = "Not Specified";
		String message = "Empty message";
		if(rs.getString(3)!=null)
			subject = rs.getString(3);
		if(rs.getString(2)!=null)
			to1 = rs.getString(2);
		if(rs.getString(4)!=null)
			message = rs.getString(4);
		
%>
				<div class=" row inboxMail">
					<div class="row">
						<span class="col-md-3 col-sm-2 col-xs-12"><span><input type="checkbox" name="cbox" value="<%=rs.getString(5)%>"></span>&nbsp;&nbsp;<b><%= subject %></b></span>
						<div class="col-md-6 col-sm-5 col-xs-12" style="text-align:left">To: <u><%= to1 %></u></div>
					</div>
			<%
				int messlen = message.length();
				while(messlen>15)
					messlen = messlen/2;
			%>
					<div class="row" style="padding-top:10px;">
						<div class="col-md-6"><b>Message:</b><%= message.substring(0,messlen) %>...</div>
						<div class="col-md-push-3 col-md-3" style="text-align:right">
							<a href="compose.jsp?messId=<%=rs.getString(5)%>"><img class="iconImage" alt="read" src="style/read.png"></a>
							<a href="deleteDraft.jsp?messId=<%=rs.getString(5)%>"><img src="style/bin2.png" alt="delete" class="iconImage" align="right"></a>
						</div>
					</div>
				</div>
<%
	valid =true;
	}
	if(!valid)
	{
		%>
				<div class="row inboxMail">
					<div class="col-sm-12">
						<center>
							<b>You don't have any saved drafts.<br>Saving a draft allows you to keep a message you aren't ready to send yet.</b>
						</center>
					</div>
				</div>
<%	
	}
%>			
			</form>
			</div>
		</div>
	</body>
</html>