<% 
		String email=request.getParameter("email");
		String pass=request.getParameter("pass");
		String name=request.getParameter("name");
		String phone=request.getParameter("phone");
%>
<jsp:useBean id="db" class="com.fs.Login">
	<jsp:setProperty name="db" property="email" value="<%= email %>" />
	<jsp:setProperty name="db" property="name" value="<%= name %>" />
	<jsp:setProperty name="db" property="phone" value="<%= phone %>" />
	<jsp:setProperty name="db" property="pass" value="<%= pass %>" />
</jsp:useBean>
<%
			if(db.getUser())
			{
%>
			<div class="alert alert-danger" style="position:absolute;top:430px;left:150px;">
				<b>Email already exist!!</b>
			</div>
			<jsp:include page="NewUser.html" />
<%
			}
			else
			{
				response.sendRedirect("index.html");
			}
%>