<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String mode = request.getParameter("mode");
String str = request.getParameter("aid");
int aid = Integer.parseInt(str);
String edate = request.getParameter("edate");
if (edate==null){
	edate ="";
}
String incre = request.getParameter("incre");
if (incre==null){
	incre ="";
}
String imm = request.getParameter("imm");
if (imm==null){
	imm ="";
}
String pl = request.getParameter("pl");
if (pl==null){
	pl ="";
}

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
					<div class = "li"><a href="">In Ear Monitor</a></div>
					<div class = "li"><a href="">On Ear</a></div>
					<div class = "li"><a href="">Over Ear</a></div>
					<div class = "li"><a href="Support.jsp">Support</a></div>
				</div>
			</section>
			<div id="content">
				<%
					try {
						String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection(url,"root","12345678");
						if(edate != ""){
							edate = edate.substring(0,10)+" "+edate.substring(11,19);
							edate = ",ExpirationDate= '"+edate+"'";
						}
						if(incre != ""){
							incre = ",Increment_for_bids= "+incre;
						}
						if(imm != ""){
							imm = ",ImmPurchasePrice= "+imm;
						}
						if(pl != ""){
							pl = ",PriceLimit= "+pl;
						}
						String insert = "Update Auction set AuctionID= "+aid+edate+incre+imm+pl+" where AuctionID=?";
						if ("1".equals(mode)){
							insert = "DELETE FROM `Auction` WHERE AuctionID=?";
						}
						PreparedStatement ps = con.prepareStatement(insert);
						ps.setInt(1, aid);
						ps.executeUpdate();
						out.println("Modify success!");%>
					<script>
					onload=function(){
					    setInterval(go, 1000);};
					var x=3;
					function go(){
					    x--;
					    if(x>0){
					        document.getElementById("timer").innerHTML=x;
						   }else{
									location.href = "Management.jsp?mode=Auctions";
							}
					   }   
				</script>
				<br>
				This page would auto get you back in <span id="timer">3</span> seconds.
				
				<%
					con.close();
					}
					catch (Exception ex) {
					out.println("Oops Something goes wrong.");%>
				<br>
				<form method="post" action="Management.jsp?mode=Auctions">
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