<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String burl = request.getParameter("burl");
String test = (String) session.getAttribute("email");
if (test != null){%>
	<script>alert("ileagal access!");
	location.href = "index.jsp";
	</script>
<%}else{
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>BuyMe Login/Sign up</title>
		<link href="Assets/styles/CSS.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div id="mainWrapper">
			<header>
				<div id="logo"> 
					<a href=index.jsp><img src="Assets/images/logoImage.png"/></a>
				</div>
			</header>
			<section id="banner">
				<h2>Login or Register Here</h2>
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
				<table width="90%" border="0" align="center">
					<tbody>
						<tr>
							<th scope="col" style="border-right: 2px dotted #bbb;">
								<h2>Login
								</h2>
								<form method="post" action="LoginCheck.jsp?burl=<%=burl%>">
									<p>
										<label for="email">Email:</label>
										<input type="email" name="Email" id="email" required>
									</p>
									<p>
										<label for="password">Password:</label>
										<input type="password" name="Password" id="password" required>
									</p>
									<p>
										<input name="submit2" type="submit" class="button" id="submit2" value="Log me IN!">
									</p>
								</form>
							</th>
							<th scope="col">
								<h2 >Sign up</h2>
								<form method="post" action="SignupCheck.jsp">
									<p>
										<label for="email2">Email:</label>
										<input type="email" name="Email" id="email2" required>
									</p>
									<p>
										<label for="password2">Password:</label>
										<input type="text" name="Password" id="password2" required>
									</p>
									<p>
										<label for="textfield">Nick Name:</label>
										<input type="text" name="Nickname" id="textfield" required>
									</p>
									<p>
										<input name="submit" type="submit" class="button" id="submit" value="Sign me up!">
									</p>
								</form>
							</th>
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
<% }%>