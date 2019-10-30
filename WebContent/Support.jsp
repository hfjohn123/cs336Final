<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String burl =request.getRequestURI();%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>BuyMe Support</title>
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
						if (test == null){
						%><a href="login.jsp?burl=<%=burl %>" title="Login/Register">Login/Register</a>
					<%}else{%>
					<a href="MyAccount.jsp" title="MyAccount">MyAccount</a><a href="Logout.jsp" title="Logout">Log out</a><%} %>
				</div>
			</header>
		<section id="banner">
				<h2>Help&Support Center</h2>
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
				<table class="choice"width="100%" border="0" align="center"	>
					<tbody>
						<tr >
							<th scope="col" style="cursor:pointer; border-right: 2px dotted #bbb;" onclick="location.href='QA.jsp?page=0';">
								<h2>Q&A</h2>
								<p>Common problems here.
									<br>
									See if there is one that similar to yours.
									<br>
									You can even post a new one!
								</p>
							</th>
							<%if("enduser".equals(type)){ %>
							<th scope="col" style="cursor:pointer;" onclick="location.href='MyAccount.jsp?mode=Mailbox&To=CR@buyme.com';">
								<h2>Contact</h2>
								<p>Problem that not convenient to ask in Q&A?
									<br>
									Or have other concern?
									<br>
									Or even just want to chat with someone?
									</p>
							</th>
							<%}else if("admin".equals(type)||"CR".equals(type)){%>
								<th scope="col" style="cursor:pointer;" onclick="location.href='Management.jsp';">
								<h2>Management</h2>
								<p>Used for Modify Accounts,
								<br>Bids, and Auctions
								</p>
							</th>
							<%}%>
						</tr>
					</tbody>
				</table>
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