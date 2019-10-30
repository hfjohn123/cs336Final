<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String keyword = request.getParameter("keyword");
String test = (String)session.getAttribute("email");
String search = request.getParameter("Search");

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
					<div class = "li"><a href="Support.jsp">Support</a></div>
				</div>
			</section>
			<div id="content">
				<%
					try {
						String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection(url,"root","12345678");
						String insert = "DELETE FROM `WishList` WHERE Email=? and Keyword=?"; 
						PreparedStatement ps = con.prepareStatement(insert);
						ps.setString(1, test);
						ps.setString(2, keyword);
						ps.executeUpdate();
						out.println("Modify success!");%>
					<script>
					onload=function(){
					    setInterval(go, 1000);};
					var x=3;
					function go(){
					    x--;
					    if(x>0){
					        document.getElementById("timer").innerHTML=x;
						   }else{
									location.href = "MyAccount.jsp?mode=WishList&Sear="+"<%=search%>";
							}
					   }   
				</script>
				<br><br>
				This page would auto get you back in <span id="timer">3</span> seconds.
				
				<%
					con.close();
					}
					catch (Exception ex) {
					out.println("Oops Something goes wrong.");%>
				<br>
				<form method="post" action="MyAccount.jsp?mode=WishList&Sear=<%=search%>">
					<input type="submit" class = "button" value="back">
				</form>
				<%}
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