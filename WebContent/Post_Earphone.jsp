<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String test = (String) session.getAttribute("email");
if (test == null) {
%>
<script>
alert("You do not have access to this page")
location.href = "login.jsp";
</script>
<%
}
%><html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>BuyMe Sell</title>
			<link href="Assets/styles/CSS.css" rel="stylesheet" type="text/css">
		</head>
	<body>
		<div id="mainWrapper">
			<header>
				<div id="logo"> 
					<a href=index.jsp> <img src="Assets/images/logoImage.png"/> </a>
				</div>
				<div id="headerLinks">
					<a href="MyAccount.jsp" title="MyAccount">MyAccount</a><a href="Logout.jsp" title="Logout">Log out</a>
				</div>
			</header>
			<section id="banner">
				<h2>Post a New Earphone</h2>
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
			<form method="post" action="Earphone_Check.jsp">
			<table class = "QA" style="width:100%;">
			<tbody>
			<tr>
				<th><label for="name">*Name:</label>
				<br>
				<input type="text" name="Name" id="name" required></th>
				<th><label for="brand">Brand:</label>
				<br>
				<input type="text" name="Brand" id="brand"></th>
			</tr>
			<tr>
				<th><label for="model">Model:</label>
				<br>
				<input type="text" name="Model" id="model"></th>
				<th><label for="resistance">Resistance:</label>
				<br>
				<input type="number" name="Resistance" id="resistance" oninput="value=value.replace(/[^\d]/g,'')">
				</th>
			</tr>
			<tr>
			<th><label for="unit">Drive Unit:</label>
				<br>
				<input type="text" name="Unit" id="unit"></th>
				<th><label for="pic">Picture:</label>
				<br>
				<input type="text" name="Pic" id="pic"></th>
			</tr>
			<tr>
			<th><label for="type">*Type:</label>
				<br>
				<select name="type" size=1>
				<option value="in ear">in ear</option>
				<option value="on ear">on ear</option>
				<option value="over ear">over ear</option></th>
				<th><label for="wire">*Wireless:</label>
				<br>
				<select name="wire" size=1>
				<option value="1">Yes</option>
				<option value="0">No</option></th>
			</tr>
			<tr>
			<th><label for="Des">*Description:</label>
				<br>
				<textarea name="Des" cols="40" rows="4" id="textarea" required></textarea>
			</tr>
			<tr><th>
			<input name="confirm" type="submit" class="button" id="confirm" value="confirm" style="width:100px;height:40px;float:left;"></th>
			<th><input name="reset" type="reset" class="button" id="reset" value="reset" style="width:25%;height:40px;float:left;"></th>
			</tbody>
			</table>
			</form>
			<br>
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
</html>
