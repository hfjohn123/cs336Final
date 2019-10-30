<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String str4 = request.getParameter("id");
if (str4==null||"null".equals(str4)){%>
	<script>alert("ileagal access!");
	location.href = "index.jsp";
	</script>
<% }else{	
int EarphoneID = Integer.parseInt(str4);
String temp = request.getParameter("ExpirationDate");
String ExpirationDate = temp.substring(0,10)+" "+temp.substring(11,16)+":00";
String str = request.getParameter("InitialPrice");
int InitialPrice = Integer.parseInt(str);
String str1 = request.getParameter("Increment_for_bids");
int Increment_for_bids = 0;
if(str1!=""){
	Increment_for_bids = Integer.parseInt(str1);
}
String str2 = request.getParameter("ImmPurchasePrice");
int ImmPurchasePrice = 0;
if(str2!=""){
	ImmPurchasePrice = Integer.parseInt(str2);
}
String str3 = request.getParameter("PriceLimit");
int PriceLimit = 0;
if(str3!=""){
	PriceLimit = Integer.parseInt(str3);
}
String test = (String) session.getAttribute("email");
if (test == null){%>
	<script>alert("ileagal access!");
	location.href = "index.jsp";
	</script>
<%}else{
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
						Statement stmt = con.createStatement();
						String insert = "INSERT INTO `Auction`(EarphoneID,ExpirationDate, InitialPrice,Increment_for_bids,ImmPurchasePrice,PriceLimit)"
								+ "VALUES (?,?, ?, ?,?,?)";
							PreparedStatement ps = con.prepareStatement(insert);
							ps.setInt(1, EarphoneID);
							ps.setString(2, ExpirationDate);
							ps.setInt(3, InitialPrice);
							ps.setInt(4, Increment_for_bids);
							ps.setInt(5, ImmPurchasePrice);
							if (str3==""){
								ps.setString(5, null);
							}
							ps.setInt(6, PriceLimit);
							ps.executeUpdate();
							String select = "Select @@IDENTITY as id";
							ps = con.prepareStatement(select);
							ps.executeQuery();
							ResultSet re = ps.getResultSet();
							String id = "";
							if (re.next()) {
						        id = re.getString("id");
							}
							String select1 = "Select * from Earphone where EarphoneID = ?";
							ps = con.prepareStatement(select1);
							ps.setInt(1, EarphoneID);
							ps.executeQuery();
							ResultSet re1 = ps.getResultSet();
							if (re1.next()){
								String name = re1.getString("Name");
								name = name.trim();
								name = name.replaceAll("\\s+", "%' or Keyword like '%");
								name = "'%"+name+"%'";
								String select2 = "Select * from WishList where KeyWord like "+name;
								PreparedStatement ps2 = con.prepareStatement(select2);
								ps2.executeQuery();
								ResultSet re2 = ps2.getResultSet();
								while(re2.next()){
									String email = re2.getString("Email");
									String insert1 = "INSERT INTO `Account_Use_Email`(`From`,`To`, Subject,Content,isAlert)"
											+ "VALUES (?,?, ?, ?,?)";
									%>
						    		<script>console.log("<%=insert1%>")</script>
						    		<%
									ps = con.prepareStatement(insert1);
									ps.setString(1, "CR@buyme.com");
									ps.setString(2, email);
									ps.setString(3, "There is some thing you may Interested in!");
									ps.setString(4, "Hi There, there is someone just post something fit to your wish list. Check it now! <a href='Auctions.jsp?aid="+id+"'>Link</a>");
									ps.setInt(5, 1);
									ps.executeUpdate();
								}
								out.println("Post succeeded!");
								%>
						<script>
							onload=function(){
							    setInterval(go, 1000);};
							var x=3;
							function go(){
							    x--;
							    if(x>0){
							        document.getElementById("timer").innerHTML=x;
								   }else{
							     	  location.href="index.jsp"; 
							    } 
							    
							}  
						</script>
						<br>
						<br>
						This page would auto direct to index in <span id="timer">3</span> seconds.
								<%
					
							}
					con.close();
					}
					catch (Exception ex) {
					out.print(ex);
					out.println("Oops Something goes wrong.");%>
				<br>
				<br>
				<br>
				<br>
				<form method="post" action="index.jsp">
					<input type="submit" class = "button" value="back">
				</form>
				<% }
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
<% }}%>