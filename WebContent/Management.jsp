<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String type = (String) session.getAttribute("type");
	String test = (String) session.getAttribute("email");
	if (test == null || !("admin".equals(type)||"CR".equals(type))) {
%>
<script>
	alert("You do not have access to this page")
	location.href = "login.jsp";
</script>
<%
	}
	String mode = request.getParameter("mode");
	if(!("Accounts".equals(mode)||"Bids".equals(mode)||"Auctions".equals(mode)||"Sales".equals(mode))){
		mode = "Accounts";
	}
	String str = request.getParameter("page");
	int pagenum;
	if("null".equals(str)){
		str = null;
	}
	if(str != null){
		pagenum = Integer.parseInt(str);
	}else{
		pagenum = 0;
	}
	String search = request.getParameter("Sear");
	if ("null".equals(search) || search ==""){
		search = null;
	}
	String temp = "";
	String temp1 = "";
	String temp2 = "";
	if (search != null){
		search = search.trim();
		if ("Accounts".equals(mode)){
		temp = "'%"+search+"%'";
		temp1 = search.replaceAll("\\s+", "%' or Email like '%");
		temp1 = "'%"+temp1+"%'";
		}else if("Bids".equals(mode)){
			temp = search.replaceAll("\\s+", "%' or Name like '%");
			temp = "'%"+temp+"%'";
			temp1 = search.replaceAll("\\s+", "%' or Account_Bid_Auction.Email like '%");
			temp1 = "'%"+temp1+"%'";
			temp2 = search.replaceAll("\\s+", "%' or AuctionID like '%");
			temp2 = "'%"+temp2+"%'";
		}else if("Auctions".equals(mode)){
			temp = search.replaceAll("\\s+", "%' or Name like '%");
			temp = "'%"+temp+"%'";
			temp1 = search.replaceAll("\\s+", "%' or Email like '%");
			temp1 = "'%"+temp1+"%'";
			temp2 = search.replaceAll("\\s+", "%' or AuctionID like '%");
			temp2 = "'%"+temp2+"%'";
		}
	}
	String auto = request.getParameter("Auto");
	if (("null").equals(auto)){
		auto = null;
	}
	String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "root", "12345678");
	Statement stmt = con.createStatement();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe Management</title>
<link href="Assets/styles/CSS.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="Assets/styles/jquery1.42.min.js"></script>
<script language="javascript">
	function refresh(id, str, max,mode, se) {
		if (str == "") {

		} else {
			var x = Number(str) - 1;
			if (x <= max &&x >-1) {
				self.location.href = "Management.jsp?mode="+mode+"&page=" + x + "&Sear=" + se;
			} else {
				alert("Out of the range!");
			}
		}
	}
</script>
</head>
<body>
	<div id="mainWrapper">
		<header>
		<div id="logo">
			<a href=index.jsp> <img src="Assets/images/logoImage.png" />
			</a>
		</div>
		<div id="headerLinks">
			<a href="MyAccount.jsp" title="MyAccount">MyAccount</a>
			<a href="Logout.jsp" title="Logout">Log out</a>
		</div>
		</header>
		<section id="banner">
		<h2>Management</h2>
		</section>
		<section id="nav">
		<div class="ul">
				<div class = "li"><a href="index.jsp">Home</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=inear">In Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=onear">On Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=overear">Over Ear</a></div>
					<div class = "li"><a calss="active" href="Support.jsp">Support</a></div>
		</div>
		</section>
		<div id="content">
			<section class="sidebar">
			<table>
				<tr>
					<%
						if ("Accounts".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='Management.jsp?mode=Accounts'">Accounts</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='Management.jsp?mode=Accounts'">Accounts</th>
					<%
						}
					%>
				</tr>
				<tr>
					<%
						if ("Bids".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='Management.jsp?mode=Bids'">Bids</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='Management.jsp?mode=Bids'">Bids</th>
					<%
						}
					%>
				</tr>
				<tr>
					<%
						if ("Auctions".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='Management.jsp?mode=Auctions'">Auctions</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='Management.jsp?mode=Auctions'">Auctions</th>
					<%
						}
					%>
				</tr>
				<%if ("admin".equals(type)){ %>
				<tr>
					<%
						if ("Sales".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='Management.jsp?mode=Sales'">Sales Report</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='Management.jsp?mode=Sales'">Sales Report</th>
					<%
						}
					%>
				</tr>
				<%} %>
			</table>
			<%if (!("Sales".equals(mode))){ %>
			<form action="Management.jsp?mode=<%=mode %>&page=0" method="post"
				id="myform">
				<p>
					<input type="text" Name="Sear" id="search" placeholder="Search"<%if (search != null) {%>
						value="<%=search%>" <%}%>>
				</p>
				<%if("Bids".equals(mode)){%>
				<label> <input type="checkbox" name="Auto" value="Multiple"
						id="Checkbox" <%if (auto != null) {%> checked="checked" <%}%>>
						Auto-Bid Only
				</label>
				<%} %>
					 <br><input name="submit" type="submit"
					class="button" id="submit" value="Search"> 
					<input type="submit" class="button" value="rest" onclick="$(':input','#myform').not(':button, :submit, :reset, :hidden').val('').removeAttr('checked').removeAttr('selected');">
					<%} %>
			</form>
			</section>
			<section class="mainContent">
			
			<%int maxpage = 0;
			if ("Accounts".equals(mode)){
				String add =  "type = 'enduser'";
				if ("admin".equals(type)){
					add = "type = 'enduser' or type= 'CR'";
				}
				String select = "Select count(*) as num from(Select * from Account where ("+add+") order by Email asc)t1";
				if(search != null){
					select = "Select count(*) as num from (Select * from Account where ("+add+") and (Name like "+temp+" or Email like "+temp1+" )order by Email asc)t1";
				}
				
				PreparedStatement ps = con.prepareStatement(select);
				ps.executeQuery();
				ResultSet re = ps.getResultSet();
				String t = "";
				if (re.next()) {
					t = re.getString("num");
					int max = Integer.parseInt(t);
					%>
					<script>console.log("<%=max%>")</script>
					<%
					maxpage = max / 10;
					if (max%10 == 0){
					maxpage--;
					}
					int i_min = pagenum*10;
					
					select = "Select * from Account where ("+add+") order by Email asc limit ?,10";
					if(search != null){
						select = "Select * from Account where ("+add+") and (Name like "+temp+" or Email like "+temp1+" )order by Email asc limit ?,10";
						
					}
					ps = con.prepareStatement(select);
					ps.setInt(1,i_min);
					ps.executeQuery();
					re = ps.getResultSet();%>
					<table class="QA">
				<tbody>
				<tr>
				<th>
				<h2>Email:</h2>
				</th>
				<th style="border-left: 2px dotted #bbb;">
				<h2>Name:</h2>
				</th>
				</tr>
					<%for(int i=0;i<10;i++){
						if (re.next()) {
							String email = re.getString("Email");
							String name = re.getString("Name");
							%>
							<tr>
							<th style="cursor: pointer;"
								onclick="location.href= 'Accountsub.jsp?email=<%=email%>&page=<%=pagenum%>&Sear=<%=search%>'">
							<p><%=email%></p>
						</th>
						<th style="cursor: pointer;"
								onclick="location.href= 'Accountsub.jsp?email=<%=email%>&page=<%=pagenum%>&Sear=<%=search%>'">
						<p><%=name %></p>
						</th>
					</tr>
					<%}
					}%>
					</tbody>
			</table>
			<%}}else if("Bids".equals(mode)){
				String tem = "";
				if (auto!=null){
					tem += "where (Auto_price is not null) ";
				}else{
					tem += "where (Auto_price is not null or Auto_price is null) ";
				}
				
				if (search != null){
					tem += "and (`Account_Bid_Auction`.Email like "+temp+" or Name like "+temp1+" or AuctionID like "+temp2+") ";
				}
				String select = "Select count(*) as num from(Select `Account_Bid_Auction`.Email,Name,Datetime,price,Auto_Price from `Account_Bid_Auction` join Auction using (AuctionID) join Earphone using (EarphoneID) "+tem+"group by `Account_Bid_Auction`.Email,AuctionID,Datetime order by Datetime desc)t1";
				%>
				<script>console.log("<%=select%>");</script>
				<%
				PreparedStatement ps = con.prepareStatement(select);
				ps.executeQuery();
				ResultSet re = ps.getResultSet();
				String t = "";
				if (re.next()) {
					t = re.getString("num");
					int max = Integer.parseInt(t);
					maxpage = max / 10;
					if (max%10 == 0){
					maxpage--;
					}
					int i_min = pagenum*10;
					select = "Select `Account_Bid_Auction`.Email,AuctionID,Name,Datetime,price,Auto_Price from `Account_Bid_Auction` join Auction using (AuctionID) join Earphone using (EarphoneID) "+tem+" group by `Account_Bid_Auction`.Email,AuctionID,Datetime  order by Datetime desc limit ?,10";
					ps = con.prepareStatement(select);
					ps.setInt(1,i_min);
					ps.executeQuery();
					re = ps.getResultSet();%>
					<table class="Bids">
					<tbody>
					<tr>
					<th>
					<h3>Email:</h3>
					</th>
					<th >
					<h3>AuctionID:</h3>
					</th>
					<th >
					<h2>Name:</h2>
					</th>
					<th >
					<h3>Time:</h3>
					</th>
					<th >
					<h3>Price:</h3>
					</th>
					<th>
					<h3>Auto Price:</h3>
					</th>
					</tr>
						<%for(int i=0;i<10;i++){
							if (re.next()) {
								String email = re.getString("Email");
								String aid = re.getString("AuctionID");
								String name = re.getString("Name");
								String time = re.getString("Datetime");
								time=time.substring(0,19);
								String price = re.getString("price");
								String auto_p = re.getString("Auto_Price");
								%>
								<tr>
								<th style="cursor: pointer;"
									onclick="location.href= 'Bidsub.jsp?email=<%=email%>&aid=<%=aid %>&name=<%=name %>&time=<%=time %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
								<p><%=email%></p>
								<th style="cursor: pointer;"
									onclick="location.href= 'Bidsub.jsp?email=<%=email%>&aid=<%=aid %>&name=<%=name %>&time=<%=time %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
								<p><%=aid%></p>
								</th>
								<th style="cursor: pointer;"
									onclick="location.href= 'Bidsub.jsp?email=<%=email%>&aid=<%=aid %>&name=<%=name %>&time=<%=time %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
								<p><%=name %></p>
								</th>
								<th style="cursor: pointer;"
									onclick="location.href= 'Bidsub.jsp?email=<%=email%>&aid=<%=aid %>&name=<%=name %>&time=<%=time %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
									<p><%=time%></p>
								</th>
								<th style="cursor: pointer;"
									onclick="location.href= 'Bidsub.jsp?email=<%=email%>&aid=<%=aid %>&name=<%=name %>&time=<%=time %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
									<p><%=price%></p>
								</th>
								<th style="cursor: pointer;"
									onclick="location.href= 'Bidsub.jsp?email=<%=email%>&aid=<%=aid %>&name=<%=name %>&time=<%=time %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
								<p><%=auto_p%></p>
								</th>
							</tr>
							<%}
						}%>
					</tbody>
			</table>
			<%}
			}else if("Auctions".equals(mode)){
				String tem = "";
				if (auto!=null){
					tem += "where PriceLimit is not null ";
				}else{
					tem += "where PriceLimit is not null or PriceLimit is null ";
				}
				if (search != null){
					tem += "and (Email like "+temp+" or Name like "+temp1+" or AuctionID like "+temp2+") ";
				}
				String select = "Select count(*) as num from(SELECT * FROM project.Auction join Earphone using (EarphoneID) "+tem+" group by AuctionID order by AuctionID desc)t1";
				PreparedStatement ps = con.prepareStatement(select);
				ps.executeQuery();
				ResultSet re = ps.getResultSet();
				String t = "";
				if (re.next()) {
					t = re.getString("num");
					int max = Integer.parseInt(t);
					maxpage = max / 10;
					if (max%10 == 0){
					maxpage--;
					}
					int i_min = pagenum*10;
					select = "SELECT * FROM project.Auction join Earphone using (EarphoneID) "+tem+" group by AuctionID order by AuctionID desc limit ?,10";
					ps = con.prepareStatement(select);
					ps.setInt(1,i_min);
					ps.executeQuery();
					re = ps.getResultSet();%>
					<table class="Bids">
					<tbody>
					<tr>
					<th>
					<h3>AuctionID:</h3>
					</th>
					<th >
					<h3>Email:</h3>
					</th>
					<th >
					<h2>Name:</h2>
					</th>
					<th >
					<h3>End Time:</h3>
					</th>
					<th >
					<h3>Immediate Price:</h3>
					</th>
					<th>
					<h3>Price Limit:</h3>
					</th>
					</tr>
					<%for(int i=0;i<10;i++){
							if (re.next()) {
								String email = re.getString("Email");
								String aid = re.getString("AuctionID");
								String name = re.getString("Name");
								String time = re.getString("ExpirationDate");
								time = time.substring(0,19);
								String imm_p = re.getString("ImmPurchasePrice");
								String auto_p = re.getString("PriceLimit");
								%>
								<tr>
								<th style="cursor: pointer;"
									onclick="location.href= 'Auctionsub.jsp?aid=<%=aid %>&name=<%=name %>&email=<%=email %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
								<p><%=aid%></p>
								<th style="cursor: pointer;"
									onclick="location.href= 'Auctionsub.jsp?aid=<%=aid %>&name=<%=name %>&email=<%=email %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
								<p><%=email%></p>
								</th>
								<th style="cursor: pointer;"
									onclick="location.href= 'Auctionsub.jsp?aid=<%=aid %>&name=<%=name %>&email=<%=email %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
								<p><%=name %></p>
								</th>
								<th style="cursor: pointer;"
									onclick="location.href= 'Auctionsub.jsp?aid=<%=aid %>&name=<%=name %>&email=<%=email %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
									<p><%=time%></p>
								</th>
								<th style="cursor: pointer;"
									onclick="location.href= 'Auctionsub.jsp?aid=<%=aid %>&name=<%=name %>&email=<%=email %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
									<p><%=imm_p%></p>
								</th>
								<th style="cursor: pointer;"
									onclick="location.href= 'Auctionsub.jsp?aid=<%=aid %>&name=<%=name %>&email=<%=email %>&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
								<p><%=auto_p%></p>
								</th>
							</tr>
							<%}
						}%>
					</tbody>
			</table>
			
			<%
			}}else{
				String select = "Select sum(res) as total from(SELECT AuctionID,max(price) as res FROM project.Auction join `Account_Bid_Auction` using (AuctionID) join Earphone using (EarphoneID)  where current_timestamp()>ExpirationDate and Price>PriceLimit group by AuctionID)t1";
				PreparedStatement ps = con.prepareStatement(select);
				ps = con.prepareStatement(select);
				ps.executeQuery();
				ResultSet re = ps.getResultSet();
				String total = "";
				if (re.next()) {
					 total = re.getString("total");
				}else{
					total = "0";
				}
				%>
				<table class="Bids">
				<tbody>
				<tr>
				<th><h3>Totoal Earning:</h3></th>
				<th><p><%=total %></p></th>
				</tr>
				<%select = "select total from (Select sum(res) as total,type from(SELECT AuctionID,max(price)as res ,type FROM project.Auction join `Account_Bid_Auction` using (AuctionID) join Earphone using (EarphoneID)  where current_timestamp()>ExpirationDate and Price>PriceLimit group by AuctionID,type)t1 group by type)t2 where type = 'in ear'";
				 ps = con.prepareStatement(select);
					ps = con.prepareStatement(select);
					ps.executeQuery();
					re = ps.getResultSet();
					if (re.next()) {
						 total = re.getString("total");
					}else{
						total = "0";
					}
				%>
				<tr>
				<th><h3>Earning for IEM:</h3></th>
				<th><p><%=total %></p></th>
				</tr>
				<%select = "select total from (Select sum(res) as total,type from(SELECT AuctionID,max(price)as res ,type FROM project.Auction join `Account_Bid_Auction` using (AuctionID) join Earphone using (EarphoneID)  where current_timestamp()>ExpirationDate and Price>PriceLimit group by AuctionID,type)t1 group by type)t2 where type = 'over ear'";
				 ps = con.prepareStatement(select);
					ps = con.prepareStatement(select);
					ps.executeQuery();
					re = ps.getResultSet();
					if (re.next()) {
						 total = re.getString("total");
					}else{
						total = "0";
					}
				%>
				<tr>
				<th><h3>Earning for Over-Ear Earphone:</h3></th>
				<th><p><%=total %></p></th>
				</tr>
				<%select = "select total from (Select sum(res) as total,type from(SELECT AuctionID,max(price)as res ,type FROM project.Auction join `Account_Bid_Auction` using (AuctionID) join Earphone using (EarphoneID)  where current_timestamp()>ExpirationDate and Price>PriceLimit group by AuctionID,type)t1 group by type)t2 where type = 'on ear'";
				 ps = con.prepareStatement(select);
					ps = con.prepareStatement(select);
					ps.executeQuery();
					re = ps.getResultSet();
					if (re.next()) {
						 total = re.getString("total");
					}else{
						total = "0";
					}
				%>
				<tr>
				<th><h3>Earning for On-Ear Earphone:</h3></th>
				<th><p><%=total %></p></th>
				</tr>
				<%select = "Select EarphoneID,Name from (SELECT max(price) as res,Name,EarphoneID FROM project.Auction join `Account_Bid_Auction` using (AuctionID) join Earphone using (EarphoneID)  where current_timestamp()>ExpirationDate and Price>PriceLimit group by AuctionID)t1 order by res desc limit 0,5";
				 ps = con.prepareStatement(select);
					ps = con.prepareStatement(select);
					ps.executeQuery();
					re = ps.getResultSet();
				%>
				<tr>
				<th><h3>Top 5 Selling Item:</h3></th>
				<th><%while(re.next()){
				String id = re.getString("EarphoneID");
				String name = re.getString("Name");%>
					<p>EarphoneID:<%=id %> &nbsp;&nbsp; Name:<%=name %></p>
				<%} %>
				</th>
				</tr>
				<%select = "select sum(t) as res,Email from (SELECT AuctionID,Earphone.Email,max(Price)as t FROM project.Auction join `Account_Bid_Auction` using (AuctionID) join Earphone using (EarphoneID)  where current_timestamp()>ExpirationDate and Price>PriceLimit group by Earphone.Email,AuctionID)t1 group by Email order by res desc limit 0,5";
				 ps = con.prepareStatement(select);
					ps = con.prepareStatement(select);
					ps.executeQuery();
					re = ps.getResultSet();
				%>
				<tr>
				<th><h3>Top 5 Seller:</h3></th>
				<th><%while(re.next()){
				String id = re.getString("Email");
				String name = re.getString("res");%>
					<p>Email:<%=id %> &nbsp;&nbsp; Total Sale:<%=name %></p>
				<%} %></th>
				</tr>
					<%select = "select sum(t) as res,Email from (SELECT AuctionID,`Account_Bid_Auction`.Email,max(Price)as t FROM project.Auction join `Account_Bid_Auction` using (AuctionID) join Earphone using (EarphoneID)  where current_timestamp()>ExpirationDate and Price>PriceLimit group by AuctionID)t1 group by Email order by res desc limit 0,5";
				 ps = con.prepareStatement(select);
					ps = con.prepareStatement(select);
					ps.executeQuery();
					re = ps.getResultSet();
				%>
				<tr>
				<th><h3>Top 5 Buyer:</h3></th>
				<th><%while(re.next()){
				String id = re.getString("Email");
				String name = re.getString("res");%>
					<p>Email:<%=id %> &nbsp;&nbsp; Total amount:<%=name %></p>
				<%} %></th>
				</tr>
				</tbody>
				</table>
			<% }if (!("Sales".equals(mode))){%>
			<table class="changepage">
				<tr>
					<th>
						<%
							if (pagenum > 0) {
						%><a href="Management.jsp?mode=<%=mode %>&page=<%=pagenum - 1%>&Sear=<%=search %>" title="Last"><--Last</a>
						<%
							}
						%>
					</th>
					<th><input type="text" name = "pagenum" id="pagenum" placeholder="<%=pagenum+1 %>"
						oninput="value=value.replace(/[^\d]/g,'')"
						onKeyPress="if(window.event.keyCode==13) this.blur();"
						onblur="refresh(this.id,this.value,<%=maxpage%>,'<%=mode %>','<%=search%>');"><label
						for="pagenum">/<%=maxpage+1%></label></th>
					<th>
						<%
							if (maxpage > pagenum) {
						%><a href="Management.jsp?mode=<%=mode %>&page=<%=pagenum + 1%>&Sear=<%=search %>" title="Next">Next--></a>
						<%
							}
						%>
					</th>
				</tr>
			</table>
				<% }
				if("admin".equals(type)&&"Accounts".equals(mode)){%>
				<table width="90%" style="text-align: center;" >
				<tbody>
				<tr>
				<th>
					<h2 >Create a new Customer Representative</h2>
					<form method="post" action="SignupCheck.jsp?CR=1">
						<p>
							<label for="email2">Email:</label>
							<input type="email" name="Email" id="email2">
						</p>
						<p>
							<label for="password2">Password:</label>
							<input type="text" name="Password" id="password2">
						</p>
						<p>
							<label for="textfield">Nick Name:</label>
							<input type="text" name="Nickname" id="textfield">
						</p>
						<p>
							<input name="submit" type="submit" class="button" id="submit" value="Create!">
						</p>
					</form>
					</th>
					</tr>
					</tbody>
					</table>
				<%}%>
		</section>
		</div>
		<footer>
		<div>
			<p>CSS designed by Qi Song (group 2). Please open this website on
				a PC, but not other mobile devices.</p>
		</div>
		<div>
			<p>All the font and plug-ins used in this project belongs to
				their original owner and designer.</p>
		</div>
		<div>
			<p>
				<a href="about.jsp">For the detail reference please click me!</a>
			</p>
		</div>
		</footer>
	</div>
</body>
<%con.close(); %>
</html>
