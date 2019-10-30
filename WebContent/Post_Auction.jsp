<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String id = request.getParameter("id");
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
				<h2>Post Auction Information</h2>
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
			<form method="post" action="Auction_Check.jsp?id=<%=id%>">
			<table class = "QA" style="width:100%;">
			<% java.util.Date date=new java.util.Date();
			SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd hh:mm");
			String min = ft.format(date);
			min = min.substring(0,10)+"T"+min.substring(11,16);
			%>
			<tbody>
			<tr>
				<th><label for="ExpirationDate">*ExpirationDate:</label>
				<br>
				<input type="datetime-local" name="ExpirationDate" id="ExpirationDate" required min="<%=min%>"></th>
				<th><label for="InitialPrice">*InitialPrice:</label>
				<br>
				<input type="number" name="InitialPrice" id="InitialPrice"required oninput="value=value.replace(/[^\d]/g,'')"></th>
			</tr>
			<tr>
				<th><label for="Increment_for_bid">*Increment_for_bid:</label>
				<br>
				<input type="number" name="Increment_for_bids" id="Increment_for_bid" required oninput="value=value.replace(/[^\d]/g,'')"></th>
				<th><label for="ImmPurchasePrice">ImmPurchasePrice:</label>
				<br>
				<input type="number" name="ImmPurchasePrice" id="ImmPurchasePrice" oninput="value=value.replace(/[^\d]/g,'')">
				</th>
			</tr>
			<tr>
			<th>
			<label for="PriceLimit">PriceLimit:</label>
				<br>
			<input type="number" name="PriceLimit" id="PriceLimit">
			</th>
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
