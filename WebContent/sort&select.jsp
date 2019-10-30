<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String burl =request.getRequestURI();
String RadioGroup1 = request.getParameter("RadioGroup1");%>
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
				<div class = "li"><a  href="index.jsp">Home</a></div>
					<div class = "li"><a <%if("inear".equals(RadioGroup1)){%>class="active"	<%}%>href="sort&select.jsp?RadioGroup1=inear">In Ear</a></div>
					<div class = "li"><a <%if("onear".equals(RadioGroup1)){%>class="active"	<%}%>href="sort&select.jsp?RadioGroup1=onear">On Ear</a></div>
					<div class = "li"><a <%if("overear".equals(RadioGroup1)){%>class="active"<%}%>href="sort&select.jsp?RadioGroup1=overear">Over Ear</a></div>
					<div class = "li"><a href="Support.jsp">Support</a></div>
				</div>
			</section>
			<div id="content">
				<section class="sidebar">
					<form method="post" action="sort&select.jsp?RadioGroup1=<%=RadioGroup1%>">
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
						try {

							String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
							Class.forName("com.mysql.jdbc.Driver");
							Connection con = DriverManager.getConnection(url, "root", "12345678");	
							
							//Create a SQL statement
							Statement stmt = con.createStatement();
							String Keyword = request.getParameter("Keyword");
							
							String sort = request.getParameter("sort");
							
							String RadioGroup2 = request.getParameter("RadioGroup2");
							String CheckboxGroup1 = request.getParameter("CheckboxGroup1");
							String CheckboxGroup2 = request.getParameter("CheckboxGroup2");
							String CheckboxGroup3 = request.getParameter("CheckboxGroup3");
							
							//out.print("test"+Keyword+"test");
							//out.print(RadioGroup1);
							
							String str = "select *,max(Price)as price FROM Earphone join Auction using (EarphoneID) left join `Account_Bid_Auction` using(auctionID)";
							//out.print(RadioGroup1);
							
							if (Keyword != "" || RadioGroup1 != null || RadioGroup2 != null || CheckboxGroup1 != null || CheckboxGroup2 != null || CheckboxGroup3 != null) {
								str = str + " WHERE ";
							}
							//Keyword
							if (RadioGroup1 != null && !("null".equals(RadioGroup1))) {
								if (RadioGroup1.equals("inear")) {
									str = str + "Earphone.type = 'in ear'";
								} else if (RadioGroup1.equals("onear")) {
									str = str + "Earphone.type = 'on ear'";
								} else if (RadioGroup1.equals("overear")) {
									str = str + "Earphone.type = 'over ear'";
								} else {
									//do nothing;
								}
							}
							if (Keyword != "" && Keyword != null&&RadioGroup1 != null  && !("null".equals(RadioGroup1))) {
								str = str + " AND ";
							}
							if (Keyword != "" && Keyword != null) {
								str = str + " (Earphone.type LIKE '%" + Keyword + "%' or Earphone.Name LIKE '%" + Keyword + "%' or Earphone.Brand LIKE '%" + Keyword + "%' or Earphone.Model LIKE '%" + Keyword + "%' or Earphone.Resistance LIKE '%" + Keyword + "%' or Earphone.DriveUnit LIKE '%" + Keyword + "%')";
							}
							//radiogroup1: type
							
							
							if (RadioGroup1 != null && RadioGroup2 != null) {
								str = str + " AND ";
							} 
							
							//radiogroup2: price
							if (RadioGroup2 != null) {
								if (RadioGroup2.equals("under $100")) {
									str = str + "price < 100";
								} else if (RadioGroup2.equals("$100 to $1000")) {
									str = str + "price >= 100 AND price <= 1000";
								} else if (RadioGroup2.equals("over $1000")) {
									str = str + "price > 1000";
								} else {
									//do nothing
								}
							}
							//out.print(str);
							
							if ((RadioGroup1 != null || RadioGroup2 != null) && (CheckboxGroup1 != null || CheckboxGroup2 != null || CheckboxGroup3 != null)) {
								str = str + " AND ";
							}
							if (CheckboxGroup1 != null || CheckboxGroup2 != null || CheckboxGroup3 != null) {
								str = str + "(";
							}
							
							//out.print(str);
							//checkbox
							if (CheckboxGroup1 != null) {
								if (CheckboxGroup1.equals("Sony")) {
									str = str + "Earphone.Brand = 'Sony'";
								}
							}
							if (CheckboxGroup1 != null && CheckboxGroup2 != null) {
								str = str + " OR ";
							}
							if (CheckboxGroup2 != null) {
								if (CheckboxGroup2.equals("AKG")) {
									str = str + "Earphone.Brand = 'AKG'";
								}
							}
							if ((CheckboxGroup1 != null || CheckboxGroup2 != null) && CheckboxGroup3 != null) {
								str = str + " OR ";
							}
							if (CheckboxGroup3 != null) {
								if (CheckboxGroup3.equals("Other")) {
									str = str + "(Earphone.Brand <> 'Sony' AND Earphone.Brand <> 'AKG')";
								}
							}
							if (CheckboxGroup1 != null || CheckboxGroup2 != null || CheckboxGroup3 != null) {
								str = str + ")";
							}
							str= str + " group by (AuctionID)";
							if(sort!=null){
							//sort
							if (sort.equals("iplh")) {
								str = str + " ORDER BY InitialPrice";
							} else if (sort.equals("iphl")) {
								str = str + " ORDER BY InitialPrice DESC";
							} else if (sort.equals("n")) {
								str = str + " ORDER BY Name";
							} else if (sort.equals("nr")) {
								str = str + " ORDER BY Name DESC";
							} else if (sort.equals("r")) {
								str = str + " ORDER BY Resistance";
							} else if (sort.equals("rr")) {
								str = str + " ORDER BY Resistance DESC";
							} else if (sort.equals("b")) {
								str = str + " ORDER BY Brand";
							} else if (sort.equals("br")) {
								str = str + " ORDER BY Brand DESC";
							} else if (sort.equals("plh")) {
								str = str + " ORDER BY ImmPurchasePrice";
							} else if (sort.equals("phl")) {
								str = str + " ORDER BY ImmPurchasePrice DESC";
							} 
							}
							//out.print(str);

							
							//Run the query against the database.
							ResultSet result = stmt.executeQuery(str);
							//out.print(str);
							//parse out the results
							String Name = new String();
							String Price = new String();
							String aid = new String();
							String Brand =  new String();
							while (result.next()) {
								Name = result.getString("Name");
								Price = result.getString("price");
								aid = result.getString("AuctionID");
								Brand = result.getString("Brand");
								if (Price == null){
									Price = result.getString("InitialPrice");
								}
								%>
								<article class="productInfo">
									<a href="Auctions.jsp?aid=<%=aid %>">	
										<div><img alt="sample" src="Assets/images/200x200.png"></div>
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