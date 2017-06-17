<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="java.sql.*,java.util.Date" %>
<%!
ResultSet rs;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inbox</title>
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
request.setAttribute("draft", "grid");
request.setAttribute("sent", "active");
%>
<body class="mailBody">
<div><jsp:include page="top.jsp"></jsp:include></div>
<div class="container">
	<div class="row">
		<div class="col-sm-push-1 col-sm-3 col-lg-2"><jsp:include page="left.jsp"></jsp:include></div>
		<div class="col-sm-push-1 col-sm-7 col-lg-8">
		<form method="get" action="DeleteSentController" name="deleteItem" onsubmit ="return finalCheck()">
			<div class="row inboxMail">
				<div class="row">
					<button class="col-sm-2 buttonImage" type="submit" ><img src="style/bin.jpg" alt="delete" class="iconImage" /></button>
				</div>
			</div>
<jsp:useBean id="md" class="com.fs.Model" ></jsp:useBean>
<%
	boolean valid =false;
	String email =md.getEmail() ;
	rs = md.getSent();
	while(rs.next())
	{
		if(rs.getString(4).equals(email))
		{
			String to = rs.getString(1);
			String subject = rs.getString(2);
			String date = rs.getString(3);
			String message = rs.getString(5);
			String star = rs.getString(6);
			int messId= rs.getInt(7);
			valid = true;
%>
		<div class=" row inboxMail">
			<div class="row">
				<span class="col-md-3 col-sm-2 col-xs-12"><span><input type="checkbox" name="cbox" value="<%=messId%>"></span>&nbsp;&nbsp;<b><%= subject %></b></span>
				<div class="col-md-6 col-sm-5 col-xs-12" style="text-align:left">Send: <u><%= to %></u></div>
				<div class="col-md-3 col-sm-4 hidden-xs" style="text-align:right">-<b>
				<%
				Date d = new Date();
				String dd = d.getDate()+"/"+(d.getMonth()+1)+"/"+(d.getYear()+1900);
				String tok[];
				int time=0;
				if(dd.equals(date.substring(0,date.indexOf(','))))
				{
					tok = date.substring(date.indexOf(",")+1,date.length()).split(":");
					time = Integer.parseInt(tok[0]);
					if(time>12)
					{
						time = time-12;
						tok[2] +=" P.M.";	
					}
					else
						tok[2]+=" A.M.";
				%>
				<%= time+":"+tok[1]+":"+tok[2]%>
				<%
				}
				else
				{
				%>
				<%=date.substring(0,date.indexOf(",")) %>
				<%	
				}
				%>
				</b></div>
				<div class="col-xs-12 visible-xs">-<b><%= date %></b></div>
			</div>
			<div class="row" style="padding-top:10px;">
			<%
				int messlen = message.length();
				while(messlen>15)
					messlen = messlen/2;
			%>
				<div class="col-md-6"><b>Message:</b><%= message.substring(0, messlen) %>...</div>
				<div class="col-md-push-3 col-md-3" style="text-align:right">
					<a href="messageRead.jsp?page=sent&messId=<%=messId%>"><img class="iconImage" alt="read" src="style/read.png" align="middle"></a>
					<%
				if(star.equals("yes"))
				{
				%>
						<a href="#"><img src="style/goldenStar.png" alt="star" class="iconImage"></a>
				<%
				}
				else
				{
				%>
					<a href="#"><img src="style/transparentStar.png" alt="star" class="iconImage"></a>
				<%
				}
				%>
					<a href="DeleteSentController?messId=<%=messId%>"><img src="style/bin2.png" alt="delete" class="iconImage"></a>
				</div>
			</div>
		</div>
<%
		}
	}
	if(!valid){
	%>
	<div class="row inboxMail">
		<div class="col-sm-12"><center><b>No sent messages! Send one now!</b></center></div>
	</div>
	<%	
	}
%>
		</form>
		</div>
	</div>
</div>
</body>
</html>