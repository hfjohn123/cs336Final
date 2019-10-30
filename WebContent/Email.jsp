<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String from = request.getParameter("from");
String date = request.getParameter("date");
String unread = request.getParameter("unread");
String alert = request.getParameter("alert");
String search = request.getParameter("Sear");
%>
<html>
<%
	if(from == null||date==null){%>
		<script>
		location.href = "MyAccount.jsp?mode=Mailbox";
		</script>
	<% }else{
		String subject = "";
		String content ="";
		String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "root", "12345678");
		Statement stmt = con.createStatement();
		String select = "Select * from Account_Use_Email where `From`=? and DateTime=?";
		PreparedStatement ps = con.prepareStatement(select);
		ps.setString(1,from);
		ps.setString(2,date);
		ps.executeQuery();
		ResultSet re = ps.getResultSet();
		if (re.next()){
			subject = re.getString("Subject");
			content = re.getString("Content");
		}else{%>
			<script>alert("ileagal access!");
		location.href = "index.jsp";
		</script>
<%}
%>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>BuyMe Q&A Email</title>
			<link href="Assets/styles/CSS.css" rel="stylesheet" type="text/css">
		</head>
	<body>
		<div id="mainWrapper">
			<header>
				<div id="logo"> 
					<a href=index.jsp> <img src="Assets/images/logoImage.png"/> </a>
				</div>
				<div id="headerLinks">
					<% String test = (String)session.getAttribute("email");
					String type = (String)session.getAttribute("type");
						%>
					<a href="MyAccount.jsp" title="MyAccount">MyAccount</a><a href="Logout.jsp" title="Logout">Log out</a>
				</div>
			</header>
			<section id="banner">
				<h2><%=subject %></h2>
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
			<section class="mainContent">
			<div class ="text">
				<h2>From: </h2><%=from %>
				<h2>Time: </h2><%=date.substring(0,19) %>
				<h2>Content: </h2><%=content %>
				<br><br><br>
			<br>
			<br>	
			<input name="submit" type="submit" class="button" id="submit" value="Reply" style="width:100px;height:40px;" onclick="location.href= 'EmailMod.jsp?mode=2&from=<%=from %>&date=<%=date %>&Sear=<%=search%>&alert=<%=alert%>&unread=<%=unread%>'">
			<input name="submit" type="submit" class="button" id="submit" value="back" style="width:100px;height:40px;left:45%;" onclick="location.href= 'EmailMod.jsp?mode=0&from=<%=from %>&date=<%=date %>&Sear=<%=search%>&alert=<%=alert%>&unread=<%=unread%>'">
			<input name="submit" type="submit" class="button" id="submit" value="delet" style="width:100px;height:40px;left:80%;" onclick="location.href= 'EmailMod.jsp?mode=1&from=<%=from %>&date=<%=date %>&Sear=<%=search%>&alert=<%=alert%>&unread=<%=unread%>'">
			</div>
		</section>
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
	<%con.close(); %>
	<%} %>
</html>
