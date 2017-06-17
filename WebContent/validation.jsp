<%
	String email = request.getParameter("email");
	String pass = request.getParameter("pass");
%>
<jsp:useBean id="db" class="com.fs.Login" >
	<jsp:setProperty name="db" property="email" value="<%= email %>" />
	<jsp:setProperty name="db" property="pass" value="<%= pass %>" />
</jsp:useBean>
<% 
	if(db.getLogin())
	{
		session.setAttribute("email",email);
%>
	<jsp:forward page="validateSession.jsp"></jsp:forward>
<%
	}
	else
	{
%>
	<div class="alert alert-danger" style="position:absolute;top:350px;left:150px;"><b>Email or Password Incorrect</b></div>
	<jsp:include page="index.html"></jsp:include>
<%
	}
%>