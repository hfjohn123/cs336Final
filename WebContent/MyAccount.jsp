<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String test = (String) session.getAttribute("email");
	if (test==null||"null".equals(test)){
		%>
		<script>
			alert("You have not login yet!")
			location.href = "login.jsp";
		</script>
		<%
	}else{
	String type = (String) session.getAttribute("type");
	String target = (String) session.getAttribute("target");
	if(target==null){
		target = test;
	}
	session.removeAttribute("target");
	String mode = request.getParameter("mode");
	if(!("Account_Info".equals(mode)||"Account_Info1".equals(mode)||"My_Bid".equals(mode)||"Mailbox".equals(mode)||"My_Auction".equals(mode)||"My_Earphone".equals(mode)||"WishList".equals(mode))){
		mode = "Account_Info";
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
		if("Mailbox".equals(mode)){
		temp = "'%"+search+"%'";
		temp1 = search.replaceAll("\\s+", "%' or Subject like '%");
		temp1 = "'%"+temp1+"%'";
		temp2 = search.replaceAll("\\s+", "%' or `From` like '%");
		temp2 = "'%"+temp2+"%'";
		}else{
			temp = search.replaceAll("\\s+", "%' or Keyword like '%");
			temp = "'%"+temp+"%'";
		}
	}
	String unread = request.getParameter("unread");
	if ("null".equals(unread) || unread ==""){
		unread = null;
	}
	String alert = request.getParameter("alert");
	if ("null".equals(alert)|| alert ==""){
		alert = null;
	}
	String To = request.getParameter("To");
	if ("null".equals(To)|| To ==""){
		To = null;
	}
	String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "root", "12345678");
	Statement stmt = con.createStatement();
	
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe <%=target %></title>
<link href="Assets/styles/CSS.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="Assets/styles/jquery1.42.min.js"></script>
<script language="javascript">
	function refresh(id, str, max, se, m, n) {
		if (str == "") {

		} else {
			var x = Number(str) - 1;
			if (x <= max) {
				self.location.href = "QA.jsp?page=" + x + "&Search=" + se
						+ "&Me=" + m + "&NR=" + n;
			} else {
				alert("Over the max");
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
		<div id="headerLinks"><%if(target!=null){ %>
			<a href="MyAccount.jsp" title="Myaccount">MyAccount</a><%} %><a href="Logout.jsp" title="Logout">Log out</a>
		</div>
		</header>
		<section id="banner">
		<h2><%=target %>'s Account</h2>
		</section>
		<section id="nav">
		<div class="ul">
				<div class = "li"><a href="index.jsp">Home</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=inear">In Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=onear">On Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=overear">Over Ear</a></div>
					<div class = "li"><a href="Support.jsp">Support</a></div>
		</div>
		</section>
		<div id="content">
			<section class="sidebar">
			<table>
				<tr>
					<%	if(test.equals(target)){
						if ("Account_Info".equals(mode)||"Account_Info1".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='MyAccount.jsp?mode=Account_Info'">Account
						Info</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='MyAccount.jsp?mode=Account_Info'">Account
						Info</th>
					<%
						}}
					%>
				</tr>
				<tr>
					<%
						if ("My_Bid".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='User.jsp?mode=My_Bid&target=<%=target%>'">Bids</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='User.jsp?mode=My_Bid&target=<%=target%>'">Bids</th>
					<%
						}
					%>
				</tr>
				<tr>
					<%
						if ("My_Auction".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='User.jsp?mode=My_Auction&target=<%=target%>'">Auctions</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='User.jsp?mode=My_Auction&target=<%=target%>'">Auctions</th>
					<%
						}
					%>
				</tr>
					<tr>
					<%	if(test.equals(target)){
						if ("My_Earphone".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='User.jsp?mode=My_Earphone'">Earphones</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='User.jsp?mode=My_Earphone'">Earphones</th>
					<%
						}
					%>
				</tr>
				<tr>
					<%
					
						if ("Mailbox".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='MyAccount.jsp?mode=Mailbox'">Mailbox
					</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='MyAccount.jsp?mode=Mailbox'">Mailbox</th>
					<%
						}
				
					%>
				</tr>
				<tr>
					<%
						
						if ("WishList".equals(mode)) {
					%>
					<th
						style="cursor: pointer; text-align: left; background-color: rgba(208, 207, 207, 1.00)"
						onclick="location.href='MyAccount.jsp?mode=WishList'">WishList
					</th>
					<%
						} else {
					%>
					<th style="cursor: pointer;"
						onclick="location.href='MyAccount.jsp?mode=WishList'">WishList</th>
					<%
						}}
				
					%>
				</tr>
			</table>
			<%if ("Mailbox".equals(mode)||"WishList".equals(mode)) { %>
			<form action="MyAccount.jsp?mode=<%=mode %>&page=0" method="post"
				id="myform">
				<p>
					<input type="text" Name="Sear" id="search" placeholder="Search"<%if (search != null) {%>
						value="<%=search%>" <%}%>>
				</p><%
				if("Mailbox".equals(mode)){%><label> <input type="checkbox" name="unread" value="unread"
					id="Checkbox" <%if (unread != null) {%> checked="checked" <%}%>> Unread Only
				</label> <br> <label> <input type="checkbox" name="alert"
					value="Multiple" id="Checkbox" <%if (alert != null) {%> checked="checked" <%}%>> Alert Only
				</label><% }%>
				  <br><input name="submit" type="submit"
					class="button" id="submit" value="Search"> 
					<input type="submit" class="button" value="rest"
					onclick="$(':input','#myform').not(':button, :submit, :reset, :hidden').val('').removeAttr('checked').removeAttr('selected');">
			</form>
			<%} %>
			</section>
			<section class="mainContent">
		<%
			if("Account_Info".equals(mode) || "Account_Info1".equals(mode)) {
				String select = "Select * from Account where Account.Email=?";
				PreparedStatement ps = con.prepareStatement(select);
				ps.setString(1, test);
				ps.executeQuery();
				ResultSet re = ps.getResultSet();
				if (re.next()) {
					String pw = re.getString("Password");
					String name = re.getString("Name");
					String add = re.getString("Address");
					String phone = re.getString("Phone");
					if ("Account_Info".equals(mode)) {
		%>
			<table class ="QA"> 
				<tr>
					<th>Email: <%=test %></th>
					<th>Password: ***</th>
				</tr>
				<tr>
					<th>Name: <%=name %></th>
					<th>Address: <%=add %></th>
				</tr>
				<tr>
					<th>Phone: <%=phone %></th>
				</tr>
				</table>
				<input name="modify" type="submit" class="button" id="modify" value="Modify" style="width:18%;height:40px;float:left;" onclick="location.href= 'MyAccount.jsp?mode=Account_Info1'">
				<br>
			<%}else{
			session.setAttribute("pw", pw);%>
			<form method="post" action="AccountMod.jsp?">
				<table class ="QA"> 
				<tobody>
				<tr>
					<th><label for="email">Email:</label>
					<br>
					<input type="email" name="Email" id="email" placeholder="<%=test%>"></th>
					<th><label for="password">New Password:</label>
					<br>
					<input type="text" name="Password" id="password" placeholder="Leave it blank if there is no change"></th>
				</tr>
				<tr>
					<th><label for="textfield">Nick Name:</label>
					<br>
						<input type="text" name="Nickname" id="Nickname" placeholder="<%=name%>"></th>
					<th><label for="textfield">Address:</label>
					<br>
						<input type="text" name="Address" id="Address" placeholder="<%=add%>"></th>
				</tr>
				<tr>
					<th><label for="textfield">Phone:</label>
					<br>
						<input type="text" name="Phone" id="Phone" placeholder="<%=phone%>"></th>
					<th><label for="password">*Original Password:</label>
					<br>
						<input type="password" name="O_Password" id="O_Password" placeholder="required" required></th>
				</tr>
				<tr><th>
				<input name="confirm" type="submit" class="button" id="confirm" value="confirm" style="width:100px;height:40px;float:left;"></th>
				<th><input name="reset" type="reset" class="button" id="reset" value="reset" style="width:25%;height:40px;float:left;"></th>
				</tr>
				</tobody>
				</table>
				</form>
			<%	
			}
					}
				}else if("Mailbox".equals(mode)){%>
				<table class="Bids">
				<tbody>
				<tr>
					<th><h3>Subjects:</h3></th>
					<th><h3>From:</h3></th>
					<th><h3>Date:</h3></th>
				</tr>
						<%
					String tem = "";
					if(search != null){
						tem += "and (Content like "+temp+" or Subject like "+temp1+" or `From` like "+temp2+") ";
					}
					if(unread!=null){
						tem += "and isUnread = 1 ";
					}
					if(alert != null){
						tem += "and isAlert = 1";
					}
					
					String select = "Select * from Account_Use_Email where `To` =? and isDel = 0 " +tem+" order by DateTime desc";
					if(!("enduser".equals(type))){{
						select = "Select * from Account_Use_Email where (`To` =? or `To` = 'CR@buyme.com') and isDel = 0 " +tem+" order by DateTime desc";
					}
					}
					PreparedStatement ps = con.prepareStatement(select);
					ps.setString(1,test);
					ps.executeQuery();
					ResultSet re = ps.getResultSet();
					while (re.next()){
						String subject = re.getString("Subject");
						String from = re.getString("From");
						String date = re.getString("DateTime");
						String date_s=date.substring(0,19);
						str = re.getString("isAlert");
						int isAlert = Integer.parseInt(str);
						str = re.getString("isUnread");
						int isUnread = Integer.parseInt(str);
					%>
						<tr >
						<th style="cursor: pointer;" onclick="location.href= 'Email.jsp?mode=Mailbox&from=<%=from %>&date=<%=date %>&Sear=<%=search%>&alert=<%=alert%>&unread=<%=unread%>'"><%if(isUnread==1){out.print("[Unread]");}if(isAlert==1){out.print("[Alert]");} %><%=subject %></th>
						<th style="cursor: pointer;" onclick="location.href='User.jsp?target=<%=from%>&mode=My_Bid'"><%=from %></th>
						<th><%=date_s %></th>
						</tr>
					
			<%}	%>
		
						</tbody>
					</table>
						<div class="text">
				<h2>Send a New one</h2>
				<form method="post" action="New_Email.jsp">
				<p>
						<label for="textfield">Receiver:</label> <input type="email"
							name="To" id="textfield" required <%if (To != null) {%>
						value="<%=To%>" <%}%>>
					</p>
					<p>
						<label for="textfield">Subject:</label> <input type="text"
							name="Subject" id="textfield" required>
					</p>
					<p>
						<label for="textarea" style="vertical-align: middle;">Content:</label>
						<textarea name="Context" cols="40" rows="4" id="textarea" required></textarea>
					</p>
					<p>
						<input name="submit" type="submit" class="button" id="submit"
							value="Send" style="width: 20%; height: 40px; left: 60px">
					</p>
				</form>
			</div>
					<%}else if("WishList".equals(mode)){
					String tem = "";
					if(search != null){
						tem += "and (Keyword like  "+temp+") ";
					}
					String select = "Select * from WishList where Email =? "+tem+" order by Keyword asc";
					PreparedStatement ps = con.prepareStatement(select);
					ps.setString(1,test);
					ps.executeQuery();
					ResultSet re = ps.getResultSet();
					while (re.next()){
						String subject = re.getString("Keyword");
					%>
					<table class="QA">
					<tbody>
					<tr>
					<th>
					<%=subject %>
					<input name="submit" type="submit" class="button" id="submit" onclick="location.href= 'DelWish.jsp?keyword=<%=subject %>&Search=<%=search %>'" value="Delet" style="width: 20%; height: 30px; float:right;">
					</th>
					</tr>
					</tbody>
					</table>
					
					<%} %>
					<div class="text">
				<h2>Send a New one</h2>
				<form method="post" action="New_Wish.jsp?Search=<%=search%>">
					<p>
						<label for="textfield">Keyword:</label> <input type="text"
							name="Keyword" id="textfield" required>
					</p>
					<p>
						<input name="submit" type="submit" class="button" id="submit"
							value="Create" style="width: 20%; height: 40px; left: 60px">
					</p>
				</form>
			</div>
					<%}else if("My_Earphone".equals(mode)){
						String select = "Select * from Earphone where Email =? order by EarphoneID desc";
						PreparedStatement ps = con.prepareStatement(select);
						ps.setString(1,target);
						ps.executeQuery();
						ResultSet re = ps.getResultSet();
						while (re.next()){
							String subject = re.getString("Name");
							String id = re.getString("EarphoneID");
						%>
						<table class="QA">
						<tbody>
						<tr>
						<th style="cursor: pointer;" onclick="location.href= 'Earphonesub.jsp?id=<%=id%>'">
						<%=subject %>
						</th>
						</tr>
						</tbody>
						</table>
					<%}%>
					
					<input name="submit" type="submit" class="button" id="submit" onclick="location.href= 'Post_Auction.jsp'"
							value="Create New" style="width: 20%; height: 40px; float:left;">
					<%}else if("My_Auction".equals(mode)){
						String select = "SELECT * FROM project.Auction join Earphone using (EarphoneID) where Email=? order by AuctionID desc";
						PreparedStatement ps = con.prepareStatement(select);
						ps.setString(1,target);
						ps.executeQuery();
						ResultSet re = ps.getResultSet();
						while (re.next()){
							String subject = re.getString("Name");
							String id = re.getString("AuctionID");
							String date = re.getString("ExpirationDate");
							date=date.substring(0,16);
						%>
						<table class="Bids">
						<tbody>
						<tr>
						<th style="cursor: pointer;" onclick="location.href= 'Auctions.jsp?aid=<%=id%>'">
						AuctionID: <%=id %>
						</th>
						<th style="cursor: pointer;" onclick="location.href= 'Auctions.jsp?aid=<%=id%>'">
						Name: <%=subject %>
						</th>
						<th style="cursor: pointer;" onclick="location.href= 'Auctions.jsp?aid=<%=id%>'">
						End Date: <%=date %>
						</th>
						</tr>
						</tbody>
						</table>
					<%}}else if("My_Bid".equals(mode)){
						String select = "SELECT * FROM project.Account_Bid_Auction join Auction using (AuctionID) join Earphone using (EarphoneID) where Account_Bid_Auction.Email = ? group by AuctionID order by Datetime desc";
						PreparedStatement ps = con.prepareStatement(select);
						ps.setString(1,target);
						ps.executeQuery();
						ResultSet re = ps.getResultSet();
						while (re.next()){
							String subject = re.getString("Name");
							String id = re.getString("AuctionID");
							String date = re.getString("ExpirationDate");
							date=date.substring(0,16);
						%>
						<table class="Bids">
						<tbody>
						<tr>
						<th style="cursor: pointer;" onclick="location.href= 'Auctions.jsp?aid=<%=id%>'">
						AuctionID: <%=id %>
						</th>
						<th style="cursor: pointer;" onclick="location.href= 'Auctions.jsp?aid=<%=id%>'">
						Name: <%=subject %>
						</th>
						<th style="cursor: pointer;" onclick="location.href= 'Auctions.jsp?aid=<%=id%>'">
						End Date: <%=date %>
						</th>
						</tr>
						</tbody>
						</table>
					<%}} %>
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
<%con.close(); }%>
</html>
