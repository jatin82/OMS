<%@ page import="java.sql.*"%>
<%!
ResultSet rs;
%>
<jsp:useBean id="md" class="com.fs.Model"></jsp:useBean>
<%
String to1="";
String subject="";
String message="";
String messId="";
if(request.getParameter("forwardEmail")!=null){
	to1 = (String)request.getParameter("forwardEmail");
}
if(request.getParameter("messId")!=null)
{
	messId = request.getParameter("messId");
	rs = md.getComposeMessage(messId);
	if(rs.next())
	{
		if(rs.getString(1)!=null)
			to1 = rs.getString(1);
		if(rs.getString(2)!=null)
			subject = rs.getString(2);
		if(rs.getString(3)!=null)
			message = rs.getString(3);
	}
}
%>
<form class="form-horizontal" style="margin:0px 10px 0px 10px" method="post" action="sendMessage.jsp" name="f1">
	<div class="form-group">
		<label class="col-sm-2 control-label col-xs-12">To:</label>
		<input class="col-sm-9 col-xs-12" type="email" name="to1" placeholder="Sender Email" value="<%= to1 %>" onblur="ajaxFunction(this)" onfocus="wait()" required>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label col-xs-12">Subject:</label>
		<input class="col-sm-9 col-xs-12" type="text" name="subject" placeholder="Email Subject" onblur="ajaxFunction(this)" onfocus="wait()" value="<%= subject %>" required>
	</div>
	<div class="form-group">
		<label class="col-sm-2 control-label col-xs-12">Message:</label>
		<div class="col-sm-10 col-xs-12" style="padding-left:0px;"><textarea class="form-control"  rows="10" name="message" placeholder="Message Description" onblur="ajaxFunction(this)" onfocus="wait()" value="" required><%= message %></textarea></div>
	</div>
	<div style="display:none;"><input type="text" name="messId" value="<%=messId%>"></div>
	<div class="form-group">
		<input type="submit" class="btn btn-primary col-sm-push-2 col-sm-2" value="Send">
		<button class="btn btn-success col-sm-push-2 col-sm-2" type="button"><a href="">Save</a></button>
		<button class="btn btn-danger col-sm-push-2 col-sm-2" type="button"><a href="discard.jsp?messId=<%=messId%>">Discard</a></button>
		<span id="saveStatus" class="col-sm-push-2 col-sm-2">Not Saved</span>
	</div>
</form>