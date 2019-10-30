<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String type = (String) session.getAttribute("type");
String email = (String) session.getAttribute("email");
if("admin".equals(type)||"CR".equals(type)){
	email = (String) request.getParameter("target");
	if (email == null){
		email = (String) session.getAttribute("email");
		type = "enduser"; 
	}
}
String cpw = (String) session.getAttribute("pw");
String nemail = request.getParameter("Email");
String pw = request.getParameter("Password");
String name = request.getParameter("Nickname");
String add = request.getParameter("Address");
if (add==null){
	add ="";
}
String phone = request.getParameter("Phone");
if (phone==null){
	phone ="";
}
String opw = request.getParameter("O_Password");
if (email==null){%>
	<script>alert("ileagal access!");
	location.href = "index.jsp";
	</script>
<%}
if("enduser".equals(type)){
	if(!(cpw.equals(opw))){%>
	<script>alert("Wrong Password");
	location.href = "MyAccount.jsp?mode=Account_Info1";
	</script>
<% }
}%>
<html>
	<head>
		<title>BuyMe Check</title>
		<link href="Assets/styles/CSS.css" rel="stylesheet" type="text/css">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	</head>
	<body>
		<div id="mainWrapper">
			<header>
				<div id="logo"> <a href=index.jsp>
					<img src="Assets/images/logoImage.png" width="139" height="56" alt=""/></a>
				</div>
			</header>
			<section id="banner">
				<h2>Checking...</h2>
			</section>
			<section id="nav">
				<div class = "ul">
						<div class = "li"><a href="index.jsp">Home</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=inear">In Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=onear">On Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=overear">Over Ear</a></div>
					<div class = "li"><a href="Support.jsp">Support</a></div>
				</div>
			</section>
			<div id="content">
				<%
					try {
						String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection(url,"root","12345678");
						Statement stmt = con.createStatement();
						if (nemail=="" && nemail != null ){
							nemail ="Email= '"+email +"'";
						}else{
							nemail= "Email= '"+nemail +"'";
						}
						if(pw != null && pw != ""){
							pw = ",Password= '"+pw+"'";
						}
						if(name != "" && name != null ){
							name = ",Name= '"+name+"'";
						}
						if(add != ""){
							add = ",Address= '"+add+"'";
						}
						if(phone != ""){
							phone = ",Phone= '"+phone+"'";
						}
						String insert = "Update Account set "+nemail+pw+name+add+phone+ " where Email=?";%>
						<script>console.log("<%=insert%>");</script>
						<%PreparedStatement ps = con.prepareStatement(insert);
						ps.setString(1, email);
						ps.executeUpdate();
						out.println("Modify success!");
						if ("enduser".equals(type)){%>
				<script>
					onload=function(){
					    setInterval(go, 1000);};
					var x=3;
					function go(){
					    x--;
					    if(x>0){
					        document.getElementById("timer").innerHTML=x;
						   }else{
									location.href = "Logout.jsp";
							}
					   }   
				</script><%}else{%>
					<script>
					onload=function(){
					    setInterval(go, 1000);};
					var x=3;
					function go(){
					    x--;
					    if(x>0){
					        document.getElementById("timer").innerHTML=x;
						   }else{
									location.href = "Management.jsp";
							}
					   }   
				</script>
				<% }%>
				This page would auto log you out in <span id="timer">3</span> seconds.
				
				<%
				session.removeAttribute("pw");
					con.close();
					}
					catch (Exception ex) {
					out.print(ex);
					session.removeAttribute("pw");
					out.println("Oops Something goes wrong.");%>
				<br>
				<%if ("enduser".equals(type)){ %>
				<form method="post" action="MyAccount.jsp?mode=Account_Info1">
					<input type="submit" class = "button" value="back">
				</form>
				<%}else{%>
				<form method="post" action="Management.jsp">
					<input type="submit" class = "button" value="back">
				</form>
				<%}
				}
					%>
			</div>
			<footer>
				<div>
					<p>CSS designed by Qi Song (group 2). Please open this website on a PC, but not other mobile devices.</p>
				</div>
				<div>
					<p>All the font and plug-ins used in this project belongs to their original owner and designer. </p>
				</div>
				<div>
					<p><a href = "about.jsp">For the detail reference please click me!</a></p>
				</div>
			</footer>
		</div>
	</body>
</html>