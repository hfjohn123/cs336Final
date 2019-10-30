<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String id = request.getParameter("id");
String str = request.getParameter("id");
if (str==null||"null".equals(str)){%>
	<script>alert("ileagal access!");
	location.href = "index.jsp";
	</script>
<% }else{
	int EarphoneID = Integer.parseInt(str);


String Earpad = request.getParameter("Earpad");
if(Earpad == ""){
	Earpad="unknown";
}
String str1 = request.getParameter("NoiseCancel");
int NoiseCancel = Integer.parseInt(str1);
String test = (String) session.getAttribute("email");
if (test == null){%>
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
						String content = request.getParameter("Context");
						String insert = "INSERT INTO `OverEar`(EarphoneID,Earpad,NoiseCancel)"
								+ "VALUES (?,?,?)";
							PreparedStatement ps = con.prepareStatement(insert);
							ps.setInt(1, EarphoneID);
							ps.setString(2, Earpad);
							ps.setInt(3, NoiseCancel);
							
							ps.executeUpdate();
							
					con.close();
					}
					catch (Exception ex) {
					out.print(ex);
					out.println("Oops Something goes wrong.");%>
				<br>
				<br>
				<br>
				<br>
				<form method="post" action="index.jsp">
					<input type="submit" class = "button" value="back">
				</form>
				<% }
					%>
			</div>
							<div >
					<div class = "li"><a href="Post_Auction.jsp?id=<%=id%>">Sell</a></div>
					<div class = "li"><a href="index.jsp">Not Sell</a></div>
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
<% }}%>