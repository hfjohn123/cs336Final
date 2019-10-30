<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>BuyMe About</title>
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
						%><a href="login.jsp" title="Login/Register">Login/Register</a>
					<%}else{%>
					<a href="login.jsp" title="MyAcount">MyAccount</a><a href="Logout.jsp" title="Logout">Log out</a><%} %>
				</div>
			</header>
			<section id="banner">
				<h2>Thank you!</h2>
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
			<p class="text">Tool used for HTML and CSS design: Adobe Dreamweaver.
			<a href = https://www.adobe.com/products/dreamweaver.html>https://www.adobe.com/products/dreamweaver.html </a> </p>
			<br>
			<p class="text">Font used for this project: Montserrat   and    source-sans-pro </p>
			<br>
			<p class="text">CSS and Font color inspired by 
			<a href = http://www.w3school.com.cn/>http://www.w3school.com.cn/ </a></p>
			<br>
			<p class="text">Picture of Earphones as Example from
			<a href =https://www.jd.com//>https://www.jd.com/</a></p>
			<br>
			<p class="text">Thanks to all of them! <br>
			And <font size = 20>YOU</font> who is now look at this!</p>
            </section>
			</div>
			<footer>
            <div>
               <p>CSS designed by Qi Song (group 2). Please open this website on a PC, but not other mobile devices.</p>
            </div>
            <div>
               <p>All the font and plug-in used in this project belongs to their original owner and designer. </p>
            </div>
            <div>
               <p>You are already at here!</p> 
            </div>
         </footer>
		</div>
	</body>
</html>