<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String mode = request.getParameter("mode");
String from = request.getParameter("from");
String date = request.getParameter("date");
String search = request.getParameter("Sear");
String alert = request.getParameter("alert");
String unread = request.getParameter("unread");
String price = request.getParameter("price");
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
						String insert = "Update Account_Use_Email set isUnread = 0 where `From`=? and DateTime=?";
						if ("1".equals(mode)){
							insert = "Update Account_Use_Email set isUnread = 0, isDel=1 where `From`=? and DateTime=?";
						}
						PreparedStatement ps = con.prepareStatement(insert);
						ps.setString(1, from);
						ps.setString(2, date);
						ps.executeUpdate();
						if("2".equals(mode)){%>
						<script>
						location.href = "MyAccount.jsp?mode=Mailbox&Sear="+"<%=search%>"+"&alert="+"<%=alert%>"+"&unread="+"<%=unread%>"+"&To="+"<%=from%>";
						</script>
						<%}else{ %>
						<script>
						location.href = "MyAccount.jsp?mode=Mailbox&Sear="+"<%=search%>"+"&alert="+"<%=alert%>"+"&unread="+"<%=unread%>";
						</script>
				<%}
					con.close();
					}
					catch (Exception ex) {
					out.println("Oops Something goes wrong.");%>
				<br>
				<br>
				<br>
				<br>
				<form method="post" action="Management.jsp?mode=Bids">
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