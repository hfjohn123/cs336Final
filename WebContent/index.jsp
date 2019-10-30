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
			<section id="banner"  onclick="location.href='Post_Earphone.jsp'" style="cursor: pointer;">
				<h2>WANNA SELL ?!</h2>
				<p>CLICK ME!!!!</p>
			</section>
			<section id="nav">
				<div class = "ul">
					<div class = "li"><a class="active" href="index.jsp">Home</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=inear">In Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=onear">On Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=overear">Over Ear</a></div>
					<div class = "li"><a href="AuctionList.jsp">All Auctions</a></div>
					<div class = "li"><a href="Support.jsp">Support</a></div>
				</div>
			</section>
			<div id="content">
				<section class="sidebar">
					<form method="post" action="sort&select.jsp">
					<p>
						
						<input type="text"  id="search" name="Keyword" placeholder="Keyword">
						
					</p>
					<p> 
					
						<!-- choose model --> 
						<label>
						<input type="radio" name="RadioGroup2" value="under $100" id="RadioGroup2_0">
						under $100</label>
						<br>
						<label>
						<input type="radio" name="RadioGroup2" value="$100 to $1000" id="RadioGroup2_1">
						$100 to $1000</label>
						<br>
						<label>
						<input type="radio" name="RadioGroup2" value="over $1000" id="RadioGroup2_2">
						over $1000</label>
						<br>
						<!-- choose brand --> 
						<label>
						<input type="checkbox" name="CheckboxGroup1" value="Sony" id="CheckboxGroup1_0">
						Sony</label>
						<br>
						<label>
						<input type="checkbox" name="CheckboxGroup2" value="AKG" id="CheckboxGroup1_1">
						AKG</label>
						<br>
						<label>
						<input type="checkbox" name="CheckboxGroup3" value="Other" id="CheckboxGroup1_1">
						Other</label>
					</p>
					<p>
						
						
							<label for="select">sort by:</label>
							<select name="sort" size=1>
								<option value=" "> </option>
								<option value="iplh">initial price low to high</option>
								<option value="iphl">initial price high to low</option>
								<option value="n">name alphabetical order</option>
								<option value="nr">name(reverse) alphabetical order</option>
								<option value="r">resistance low to high</option>
								<option value="rr">resistance high to low</option>
								<option value="b">brand alphabetical order</option>
								<option value="br">brand(reverse) alphabetical order</option>
								<option value="plh">ImmPurchasePrice low to high</option>
								<option value="phl">ImmPurchasePrice high to low</option>
							</select>&nbsp;<br> <input class = "button" type="submit" value="search">
						
						<br>
					</p>
					</form>
				</section>
				<section class="mainContent">
					<div class="productRow">
						<br>
						<%
							
							String Name = new String();
							String Price = new String();
							String aid = new String();
							String Brand =  new String();
							String Pic =  new String();
							try {
								String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
								Class.forName("com.mysql.jdbc.Driver");
								Connection con = DriverManager.getConnection(url, "root", "12345678");	
								//Create a SQL statement
								Statement stmt = con.createStatement();
								//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
								String str = "select InitialPrice,max(price)as price,AuctionID,Name,Brand,Pic FROM Earphone join Auction using (EarphoneID) left join `Account_Bid_Auction` using(auctionID) group by AuctionID order by startdate desc";
								//Run the query against the database.
								ResultSet result = stmt.executeQuery(str);
								//parse out the results
								while (result.next()) {
									Name = result.getString("Name");
									Price = result.getString("price");
									aid = result.getString("AuctionID");
									Brand = result.getString("Brand");
									Pic = result.getString("Pic");
									if (Price == null){
										Price = result.getString("InitialPrice");
									}
									%>
									<article class="productInfo">
										<a href="Auctions.jsp?aid=<%=aid %>">	
											<div><img alt="sample" src="<%=Pic%>"></div>
											<p class="price">$<%=Price %></p>
											<p class="productContent"><%=Name %>&nbsp;(<%=Brand %>) </p>
										</a>
									</article>
					
								<% }
								
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