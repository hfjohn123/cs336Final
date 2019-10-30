<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String burl = request.getParameter("burl");
String from = (String) session.getAttribute("email");
if (from == null || ("null").equals(burl)){%>
	<script>alert("ileagal access!");
	location.href = "index.jsp";
	</script>
<%}else{
%>
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
					<div class = "li"><a class="active" href="Support.jsp">Support</a></div>
				</div>
			</section>
			<div id="content">
				<%
					try {
						String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection(url,"root","12345678");
						Statement stmt = con.createStatement();
						String subject = request.getParameter("Subject");
						String content = request.getParameter("Context");
						if(subject !="" && content != ""){
							String insert = "INSERT INTO Account_QA(QAID,`From`,ReFrom, Subject,Content,ReContent)"
									+ "VALUES (default,?,default,?,?,default)";
							PreparedStatement ps = con.prepareStatement(insert);
							ps.setString(1, from);
							ps.setString(2, subject);
							ps.setString(3, content);
							ps.executeUpdate();
							out.println("Post success!");%>
				<script>
					onload=function(){
					    setInterval(go, 1000);};
					var x=3;
					function go(){
					    x--;
					    if(x>0){
					        document.getElementById("timer").innerHTML=x;
						   }else{
							   if (("null" == "<%=request.getParameter("burl")%>")){
									location.href = "index.jsp";
								}else{
									location.href = "<%=request.getParameter("burl")%>";
								}
					    } 
					}  
				</script>
				<br>
				<br>
				This page would auto jump back in <span id="timer">3</span> seconds.
				<%}else{
					out.println("Please make sure you input something in every blanck!");%>
				<br>
				<br>
				<br>
				<br>
				<form method="post" action="<%=burl %>">
					<input type="submit" class = "button" value="back">
				</form>
				<%}
					con.close();
					}
					catch (Exception ex) {
					out.print(ex);
					out.println("Oops Something goes wrong.");%>
				<br>
				<br>
				<br>
				<br>
				<form method="post" action="<%=burl %>">
					<input type="submit" class = "button" value="back">
				</form>
				<% }
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
<%} %>