<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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
String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url, "root", "12345678");
Statement stmt = con.createStatement();
String select = "SELECT max(Price) as num, InitialPrice,Increment_for_bids FROM `Account_Bid_Auction` right join Auction using(AuctionID) where AuctionID = "+id;
PreparedStatement ps = con.prepareStatement(select);
ps.executeQuery();
ResultSet re = ps.getResultSet();
int price = 0;
if (re.next()) {
	String num = re.getString("num");
	if(num==null){
		price = re.getInt("InitialPrice");
	}else{
		price = re.getInt("num")+re.getInt("Increment_for_bids");
	}
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
				<h2>Information of Your Bid</h2>
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
			<form method="post" action="Bid_Check.jsp?id=<%=id%>">
			<table class = "QA" style="width:100%;">
			<tbody>
			<tr>
				
				<th><label for="Price">Price</label>
				<br>
				<input type="number" name="Price" id="Price" oninput="value=value.replace(/[^\d]/g,'')" min="<%=price%>" placeholder=">=<%=price%>"></th>
				<th><label for="Auto_Price">Auto_Price</label>
				<br>
				<input type="number" name="Auto_Price" oninput="value=value.replace(/[^\d]/g,'')" id="Auto_Price" placeholder="Leave it blank or any value lower than ur bid would disable it"></th>
			<tr>
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
