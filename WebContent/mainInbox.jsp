<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,java.util.Date"%>
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
<script type="text/javascript">
<%
request.setAttribute("compose", "grid");
request.setAttribute("inbox", "active");
request.setAttribute("starred", "grid");
request.setAttribute("draft", "grid");
request.setAttribute("sent", "grid");
%>
function getXMLObject() //XML OBJECT
{
	var xmlHttp = false;
	try {
		xmlHttp = new ActiveXObject("Msxml2.XMLHTTP") // For Old Microsoft Browsers
	}
	catch (e){
		try{
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP") // For Microsoft IE 6.0+
		}
		catch (e2) {
			xmlHttp = false // No Browser accepts the XMLHTTP Object then false
		}
	}
	if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
		xmlHttp = new XMLHttpRequest(); //For Mozilla, Opera Browsers
	}
return xmlHttp; // Mandatory Statement returning the ajax object created
}

var xmlhttp = new getXMLObject();	//xmlhttp holds the ajax object
var clicked;
function updateStar(a,s)
{
	console.log("type="+s+"&messId="+a);
	clicked = a;
	if(xmlhttp) { 
		xmlhttp.open("POST","updateStar",true); //gettime will be the servlet name
		xmlhttp.onreadystatechange = handleServerResponse;
		xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xmlhttp.send("type="+s+"&messId="+a);
	}
}
function handleServerResponse() {
	if (xmlhttp.readyState == 4) {
		if(xmlhttp.status == 200) {		
			//console.log(xmlhttp.responseText);
			document.getElementById(clicked).firstChild.src=xmlhttp.responseText;
			updateStarredValue(); // update side panel
		}
		else {
			alert("Error during AJAX call. Please try again");
		}
	}
}
function updateStarredValue()
{
	if(xmlhttp) { 
		xmlhttp.open("POST","updateStar",true); //gettime will be the servlet name
		xmlhttp.onreadystatechange = handleServerResponse_1;
		xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xmlhttp.send("updateStar=yes");
	}
}
function handleServerResponse_1()
{
	if (xmlhttp.readyState == 4) {
		if(xmlhttp.status == 200) {
			//document.getElementById("disp").innerHTML=xmlhttp.responseText; //Update the HTML Form element 
			document.getElementById("starred").innerHTML=xmlhttp.responseText;
		}		
	}
}

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
</head>
<body class="mailBody">
<div><jsp:include page="top.jsp" ></jsp:include></div>
<div class="container">
	<div class="row">
		<div class="col-sm-push-1 col-sm-3 col-lg-2 "><jsp:include page="left.jsp"></jsp:include></div>
		<div class="col-sm-push-1 col-sm-8 col-lg-8">
		<form method="post" action="DeleteInboxController" name="deleteItem" onsubmit ="return finalCheck()">
		<div class="row inboxMail">
			<div class="row">
				<button class="col-sm-2 buttonImage" type="submit" ><img src="style/bin.jpg" alt="delete" class="iconImage" /></button>
			</div>
		</div>
<jsp:useBean id="md" class="com.fs.Model" ></jsp:useBean>
<%
	boolean valid = false;
	rs = md.getMessage();
	while(rs.next())
	{
		if(rs.getString(4).equals(md.getEmail()))
		{
			String from = rs.getString(1);
			String subject = rs.getString(2);
			String date = rs.getString(3);
			String message = rs.getString(5);
			String star = rs.getString(6);
			int messId = rs.getInt(7);
			String status = rs.getString(8);
			valid = true;
%>
<%
if(status.equals("unread"))
{
%>
		<div class=" row inboxMail inboxMailUnread">
<%
}
else
{
%>
	<div class=" row inboxMail">
<%
}
%>
			<div class="row">
				<span class="col-md-3 col-sm-2 col-xs-12"><span><input type="checkbox" name="cbox" value="<%=messId%>"></span>&nbsp;&nbsp;<b><%= subject %></b></span>
				<div class="col-md-6 col-sm-5 col-xs-12" style="text-align:left">Received: <u><%= from %></u></div>
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
				<div class="col-xs-12 visible-xs">-<b><%=date%></b></div>
			</div>
			<%
				int messlen = message.length();
				while(messlen>15)
					messlen = messlen/2;
			%>
			<div class="row" style="padding-top:10px;">
				<div class="col-md-6"><b>Message:</b><%= message.substring(0,messlen) %>...</div>
				<div class="col-md-push-3 col-md-3" style="text-align:right">
					<a href="messageRead.jsp?page=inbox&messId=<%=messId%>"><img class="iconImage" alt="read" src="style/read.png"></a>
			<%
				if(star.equals("golden"))
				{
			%>
					<a href="#" id="<%=messId %>" ><img src="style/goldenStar.png" alt="goldenStar" class="iconImage" onclick="updateStar(<%=messId%>,this.src)"></a>
<%
				}
				else
				{
%>
					<a href="#" id="<%=messId %>"><img src="style/transparentStar.png" alt="transparentStar" class="iconImage" onclick="updateStar(<%=messId%>,this.src)"></a>
<%
				}
%>
					<a href="DeleteInboxController?messId=<%=messId%>"><img src="style/bin2.png" alt="delete" class="iconImage" align="right"></a>
				</div>
			</div>
		</div>
<%
		}
	}
	if(!valid){
%>
	<div class="row inboxMail">
		<div class="col-sm-12"><center><b>There are no mail to display.<br>Start a conversation Now click On COMPOSE tab</b></center></div>
	</div>
<%	
	}
%>
		</div>
		</form>
	</div>
</div>
</body>
</html>