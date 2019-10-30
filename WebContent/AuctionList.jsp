<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String burl =request.getRequestURI();%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>BuyMe.com</title>
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
						if (test == null){
						%><a href="login.jsp?burl=<%=burl %>" title="Login/Register">Login/Register</a>
					<%}else{%>
					<a href="MyAccount.jsp" title="MyAccount">MyAccount</a><a href="Logout.jsp" title="Logout">Log out</a><%} %>
				</div>
			</header>
			<section id="banner">
				<h2>WANNA SELL ?!</h2>
				<p>CLICK ME!!!!</p>
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
					<div class="productRow">
						
						<%
						
						
						try {
				
							String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
							Class.forName("com.mysql.jdbc.Driver");
							Connection con = DriverManager.getConnection(url, "root", "12345678");	
							
							//Create a SQL statement
							Statement stmt = con.createStatement();
							String Email = request.getParameter("Email");
							String str = new String();
							//out.print(entity);
							//
							if (Email == null) {
								str = "SELECT * FROM Earphone JOIN Auction USING (EarphoneID) ORDER BY AuctionID";
							} else {
								str = "SELECT * FROM (Earphone JOIN Auction USING (EarphoneID)) JOIN (`Account_Bid_Auction` JOIN Account USING (Email)) USING (AuctionID) WHERE Account.Email = '" + Email + "' ORDER BY AuctionID";
							}
							//Run the query against the database.
							ResultSet result = stmt.executeQuery(str);
							//out.print(str);
							
				
							//Make an HTML table to show the results in:
							out.print("<table>");
							//make a row
							out.print("<tr>");
							//make a column
							out.print("<td>");
							//print out column header
							out.print("AuctionID");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("Name");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("Description");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("Brand");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("Model");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("Resistance");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("StartDate");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("ExpirationDate");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("InitialPrice");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("Increment_for_bids");
							out.print("</td>");
							//make a column
							out.print("<td>");
							out.print("ImmPurchasePrice");
							out.print("</td>");
							
							out.print("</tr>");

							//parse out the results
							String aid = new String();
							while (result.next()) {
								aid = result.getString("AuctionID");
								//make a row
								out.print("<tr>");
								//make a column
								out.print("<td>");
								//Print out %>
								
								<a href="Auctions.jsp?aid=<%=aid %>">
									<%=aid%>
								</a>
								<%
								out.print("</td>");
								out.print("<td>");
								//Print out
								out.print(result.getString("Name"));
								out.print("</td>");
								out.print("<td>");
								//Print out
								out.print(result.getString("Description"));
								out.print("</td>");
								out.print("<td>");
								//Print out 
								out.print(result.getString("Brand"));
								out.print("</td>");
								out.print("<td>");
								//Print out 
								out.print(result.getString("Model"));
								out.print("</td>");
								out.print("<td>");
								//Print out 
								out.print(result.getString("Resistance"));
								out.print("</td>");
								out.print("<td>");
								//Print out 
								out.print(result.getString("StartDate"));
								out.print("</td>");
								out.print("<td>");
								//Print out 
								out.print(result.getString("ExpirationDate"));
								out.print("</td>");
								out.print("<td>");
								//Print out 
								out.print(result.getString("InitialPrice"));
								out.print("</td>");
								out.print("<td>");
								out.print(result.getString("Increment_for_bids"));
								out.print("</td>");
								out.print("<td>");
								//Print out 
								out.print(result.getString("ImmPurchasePrice"));
								out.print("</td>");
								out.print("</tr>");

							}
							out.print("</table>");

							
				
							//close the connection.
							con.close();
				
						} catch (Exception e) {
						}
					%>	
						
						
					</div>
				</section>
			</div>
			<% String type = (String)session.getAttribute("type");
				if ("admin".equals(type)){%>
			<div id="left" onclick="location.href='Management.jsp'" id="right" style="cursor: pointer;">
				<p><font size = 5px>Wanna do some work as admin?</font></p>
				<br><br><br>
				<p>Click me!</p>
			</div>
			<div onclick="location.href='QA.jsp?page=0&NR=1'" id="right" style="cursor: pointer;">
				<p><font size = 5px>Wanna do some work as customer represen -tative?</font></p>
				<p>Click me!</p>
			</div>
			<%} else if("CR".equals(type)){%>
			<div onclick="location.href='QA.jsp?page=0&NR=1'" id="right" style="cursor: pointer;">
				<p><font size = 5px>Wanna do some work as customer represen -tative?</font></p>
				<p>Click me!</p>
			</div>
			<%} %>
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