<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.ParseException,java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String burl =request.getRequestURI();

%>
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
							Connection con = DriverManager.getConnection(url, "root", "12345678");	
							//Create a SQL statement
							Statement stmt = con.createStatement();
							String entity = request.getParameter("aid");
							//out.print(entity);
							String str = "SELECT *,max(Price),current_timestamp() as now FROM Earphone JOIN Auction USING (EarphoneID) join `Account_Bid_Auction` using (AuctionID)WHERE AuctionID = '" + entity+"'";
							//Run the query against the database.
							ResultSet result = stmt.executeQuery(str);
							 String time ="";
							if(result.next()){
								String id = result.getString("EarphoneID");
								String name = result.getString("Name");
								String price = result.getString("max(Price)");
								if (price == null){
									price =  result.getString("InitialPrice");
								}
								String immprice =  result.getString("ImmPurchasePrice");
								String type =  result.getString("type");
								String Pic =  result.getString("Pic");
								String brand =  result.getString("Brand");
								String model =  result.getString("Model");
								java.util.Date edate = result.getTimestamp("ExpirationDate");
								java.util.Date date=result.getTimestamp("now");
								int wire = result.getInt("isWireless");
								String unit = result.getString("DriveUnit");
								String des =  result.getString("Description");
								String winner = result.getString("Winner");
								int resistance = result.getInt("Resistance");
								long nd = 1000 * 24 * 60 * 60;
							    long nh = 1000 * 60 * 60;
								long nm = 1000 * 60;
								long ns = 1000;
								long diff = edate.getTime() - date.getTime();
							    if (diff > 0){
								long day = diff / nd;
								long hour = diff % nd / nh;
								long min = diff % nd % nh / nm;
								long sec = diff % nd % nh % nm / ns;
								 time = day + "days  " + hour + ":" + min + ":" +sec;%>
							    <%}else{
							    	time = "Oops, It has already ended!";
							    	String temp ="";
							    	if(winner==null){
							    		str = "select Email,max(price) from Auction join `Account_Bid_Auction` using (AuctionID) where AuctionID = "+entity+ " and Price > PriceLimit group by Email order by max(price) desc limit 0,1";
							    		PreparedStatement ps = con.prepareStatement(str);
							    		ps.executeQuery();
							    		ResultSet re = ps.getResultSet();
										if (re.next()){
											temp = re.getString("Email");
											str = "select Name from Account where Email = ?";
								    		ps = con.prepareStatement(str);
								    		ps.setString(1, temp);
								    		ps.executeQuery();
								    		re = ps.getResultSet();
											if (re.next()){
												winner = re.getString("Name");
												%>
									    		<script>console.log("<%=winner%>")</script>
									    		<%
											}
										}else{
											temp  = "No one wins"; 
											winner = "No one wins";
										}
										String insert = "Update Auction set Winner=? where AuctionID=?";
										ps = con.prepareStatement(insert);
										ps.setString(1, temp);
										ps.setString(2, entity);
										ps.executeUpdate();
							    	}
							    }
							%>
							<div class="Pic"><img alt="sample" src="<%=Pic%>"></div>
							<table class="Auctions">
								<tbody>
									<tr>
										<th>
										<h2><%=name %></h2>
										</th>
									</tr>
									<tr>
										<th>
										<p><a href="BidHistory.jsp?aid=<%=entity %>">Bid History</a><font size=6px>$<%=price %></font><%if(immprice != null){%>(Immediate Purchase Price:$<%=immprice %>)<%} %></p>
										</th>
									</tr>
									<tr>
										<th>
										<p>Brand: <%=brand %> &nbsp; Model: <%=model %></p>
										</th>
									</tr>
									<tr>
										<th>
										<p>Time Remain: <%=time %></p>
										</th>
									</tr>
									<tr>
										<th>
										<%if (diff>0){%><input name="submit" type="submit" class="button" id="submit" value="Place Bid" style="width:20%;height:40px;" onclick="location.href= 'Post_Bid.jsp?id=<%=entity%>'"><%}else{ %><p>Winner is:&nbsp;<%=winner %></p><%} %>
										</th>
									</tr>
								</tbody>
							</table>
							<div class="text" left="0" bottom="0">
							<br>
							<br>
							<h2>Features: </h2>
							<p>Type: <%=type %>  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;Resistance: <%if(resistance==0){out.print("unknown");}else{out.print(resistance);} %>&nbsp;Ohm&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;Drive Unit: <%=unit %>&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;Wireless: <%if (wire == 1){out.print("Yes");}else{out.print("No");} %></p>
							<%if("in ear".equals(type)){
								str = "select * from IEM where EarphoneID = "+id;
								ResultSet re = stmt.executeQuery(str);
								if (re.next()){
									String ear = re.getString("EarTip");
									int noise = re.getInt("NoiseCancel");
									String wear = re.getString("Wearingway");%>
									<p>Eartip Material: <%=ear %>  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; Noise Canceling: <%if (noise == 1){out.print("Yes");}else{out.print("No");} %> &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;Waering Style: <%=wear %></p>
							<%	}
							}else if("on ear".equals(type)){
								str = "select * from OnEar where EarphoneID = "+id;
								ResultSet re = stmt.executeQuery(str);
								if (re.next()){
									String ear = re.getString("Earpad");
									int fold = re.getInt("Foldable"); %>
									<p>Earpad Material: <%=ear %>  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; Foldable: <%if (fold == 1){out.print("Yes");}else{out.print("No");} %></p>
									
							<% }
							}else{
								str = "select * from OverEar where EarphoneID = "+id;
								ResultSet re = stmt.executeQuery(str);
								if (re.next()){
									String ear = re.getString("Earpad");
									int noise = re.getInt("NoiseCancel");%>
									<p>Earpad Material: <%=ear %>  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; Noise Canceling: <%if (noise == 1){out.print("Yes");}else{out.print("No");} %> </p>
									
								<%}
							}%>
							<h2>Description:</h2>
							<p><%=des %></p>
							<br><br><br>
							<a href="Similar.jsp?EarphoneID=<%=id%>">Similar Item</a>
							</div>
							<%}else{
								%>
								<script>
								alert("You do not have access to this page")
								location.href = "index.jsp";
								</script>
							<% }
							con.close(); %>
					<% 		} catch (Exception e) {
						}
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