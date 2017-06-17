<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%!
/* private static final String jdbc = "com.mysql.jdbc.Driver";
private static final String db_url = "jdbc:mysql://localhost/oms";
private static final String user = "root";
private static final String db_pass = "mysql@2016";
Connection con;
PreparedStatement ps;
ResultSet rs;
 */%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Compose</title>
<link rel="stylesheet" type="text/css" href="style/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="style/myStyle.css" />
</head>

<%
request.setAttribute("compose", "active");
request.setAttribute("inbox", "grid");
request.setAttribute("starred", "grid");
request.setAttribute("draft", "grid");
request.setAttribute("sent", "grid");
/* try{
	Class.forName(jdbc);
	con = DriverManager.getConnection(db_url,user,db_pass);
	ps = con.prepareStatement("update draft set status='no' where from1=? and status='current'");
	ps.setString(1, (String)request.getSession().getAttribute("email"));
	ps.executeUpdate();
}
catch(Exception e)
{
	out.print(e);
}
 */%>
<script type="text/javascript">

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

function ajaxFunction(a)
{
	//var getdate = new Date(); //Used to prevent caching during ajax call
	if(a.value.length >0)
	{
		console.log(a.name+"="+a.value+"&messId="+<%=request.getParameter("messId")%>);
		if(xmlhttp) { 
			xmlhttp.open("POST","SaveCompose",true); //gettime will be the servlet name
			xmlhttp.onreadystatechange = handleServerResponse;
			xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xmlhttp.send(a.name+"="+a.value+"&messId="+<%=request.getParameter("messId")%> );
		}
	}
	else
	{
		document.getElementById("saveStatus").innerHTML="Not Saved";
	}
}
function updateDraftValue()
{
	if(xmlhttp) { 
		xmlhttp.open("POST","SaveCompose",true); //gettime will be the servlet name
		xmlhttp.onreadystatechange = handleServerResponse_1;
		xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xmlhttp.send("updateDraft=yes");
	}
}
function handleServerResponse_1()
{
	if (xmlhttp.readyState == 4) {
		if(xmlhttp.status == 200) {
			//document.getElementById("disp").innerHTML=xmlhttp.responseText; //Update the HTML Form element 
			document.getElementById("draft").innerHTML=xmlhttp.responseText;
		}		
	}
}

function wait()
{
	document.getElementById("saveStatus").innerHTML="Not Saved";
}
function handleServerResponse() {
	if (xmlhttp.readyState == 4) {
		if(xmlhttp.status == 200) {
			//document.getElementById("disp").innerHTML=xmlhttp.responseText; //Update the HTML Form element 
			document.getElementById("saveStatus").innerHTML=xmlhttp.responseText;
			updateDraftValue();
		}
		else {
			alert("Error during AJAX call. Please try again");
		}
	}
}
function focus()
{
	document.f1.to1.focus();
}
</script>
<body class="mailBody" onload="focus()">
	<div><jsp:include page="top.jsp"></jsp:include></div>
	<div class="container">
		<div class="row">
			<div class="col-sm-push-1 col-sm-3 col-lg-2"><jsp:include page="left.jsp"></jsp:include></div>
			<div class="col-sm-push-1 col-sm-7 col-lg-8 blockHead"><jsp:include page="composeBody.jsp"></jsp:include></div>
		</div>
	</div>
</body>
</html>