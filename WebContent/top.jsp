<% 
	String email = (String)session.getAttribute("email");
%>
<div class="row navHead" style="background-color:rgba(250,250,250,0.9);color:#1b4f72">
		<script type="text/javascript">
function srch()
{
	var ser = document.topForm.search.value;
	document.location.assign("http://www.google.com/search?q="+ser);
}
</script>
	<div class="col-lg-4 col-xs-12" style="text-align:center;margin-top:12px;">
		<form name="topForm">
		<input type="text" name="search" placeholder="Search Web">
		<button class="btn btn-primary" type="button" onclick ="srch()">Search Web</button>
		</form>
	</div>
	<div class="col-lg-4 col-xs-12" style="text-align:center"><span class="headContent">ONLINE MAILING SYSTEM</span></div>
	<span class="col-lg-2 col-xs-12" style="text-align:center;padding-top:5px"><h4><%= email %></h4></span>
	<span class="col-lg-2 hidden-xs" style="text-align:center;"><h4><span class="btn btn-primary" style="padding:6px 40px 6px 40px"><a href="logout.jsp" style="color:white">SignOut</a></span></h4></span>
	<span class="visible-xs col-xs-12" style="text-align:center;"><h4><span class="btn btn-primary" style="padding:6px 40px 6px 40px"><a href="logout.jsp" style="color:white">SignOut</a></span></h4></span>
</div>
