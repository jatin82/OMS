<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,java.util.Date"%>
<%!
ResultSet rs1;
%>
<jsp:useBean id="md" class="com.fs.Model"></jsp:useBean>
<%
request.setAttribute("compose", "grid");
request.setAttribute("draft", "grid");
request.setAttribute("starred", "grid");
request.setAttribute("sent", "grid");
String messId = request.getParameter("messId");
String back;
String type;
if(request.getParameter("page").equals("inbox"))
{
	request.setAttribute("inbox", "active");
	request.setAttribute("sent", "grid");
	rs1 = md.readInbox(messId);
	back="mainInbox.jsp";
	type="DeleteInboxController";
}
else
{
	request.setAttribute("sent", "active");
	request.setAttribute("inbox", "grid");
	rs1 = md.readSent(messId);
	back="sent.jsp";
	type="DeleteSentController";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Read Mail</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="style/myStyle.css" />
</head>
<%
rs1.next();
String name = md.getTo1Name(rs1.getString(1));
md.updateStatus(messId);
%>
<body class="mailBody">
<div><jsp:include page="top.jsp"></jsp:include></div>
<div class="container">
	<div class="row">
		<div class="col-sm-push-1 col-sm-3 col-lg-2"><jsp:include page="left.jsp"></jsp:include></div>
		<div class="col-sm-push-1 col-sm-7 col-lg-8">
			<div class="row inboxMail">
				<div class="row">
					<div class="col-sm-8 head"><%=rs1.getString(2) %></div>
					<div class="col-sm-push-2 col-sm-2" style="text-align:right">
						<a href="<%=type %>?messId=<%=messId%>"><img alt="delete" src="style/bin.jpg" class="iconImage"></a>
						<a href=<%=back%>><img alt="back" src="style/back.png" class="iconImage"></a>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-sm-4"><strong><%=name %> </strong><i>&lt;<%=rs1.getString(1) %>l&gt;</i></div>
					<div class="col-sm-push-4 col-sm-4" style="text-align:right">-<b>
					<%String date = rs1.getString(3);%>
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
					</b>
					<%
					if(rs1.getString(6).equals("golden"))
					{
					%>
					 <img class="iconImage" src="style/goldenStar.png"></div>
					<%
					}
					else
					{
					%>
					<img class="iconImage" src="style/transparentStar.png"></div>
					<%
					}
					%>
				</div>
				<div class="row">
					<div class="inboxMail"><pre><%=rs1.getString(5) %></pre></div>
				</div>
			</div>
			<div class="row inboxMail">
				<form action="sendMessage.jsp" method="post">
					<input style="display:none" type="email" name="to1" value="<%=rs1.getString(1) %>">
					<input style="display:none" type="text" name="subject" value="<%=rs1.getString(2) %>">
					<div class="row formGap">
						<textarea rows="5" class="form-control" name="message" placeholder="click here to Reply &lt;<%=rs1.getString(1) %>&gt;" required></textarea>
					</div>
					<div class="row formGap">
						<input class="btn btn-primary col-sm-2" type="submit" value="Send">
						<button class="btn btn-success col-sm-5 col-lg-3" type="button"><a href="compose.jsp?forwardEmail=<%=rs1.getString(1) %>">Create New Reply</a></button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>