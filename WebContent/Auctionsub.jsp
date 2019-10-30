<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String str = request.getParameter("aid");
String pagenum = request.getParameter("page");
String name = request.getParameter("name");
String email = request.getParameter("email");
String search = request.getParameter("Sear");
String auto = request.getParameter("Auto");
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
if (str==null){%>
	<script>location.href = "Management.jsp?mode=Auctions";</script>
<%}
int aid = Integer.parseInt(str);
String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url, "root", "12345678");
Statement stmt = con.createStatement();
String select = "select * from Auction where AuctionID =? ";
PreparedStatement ps = con.prepareStatement(select);
ps.setInt(1,aid);
ps.executeQuery();
ResultSet re = ps.getResultSet();
String sdate = "";
String edate = "";
String iprice ="";
String incre = "";
String imm = "";
String pl = "";
String stmp = "";
if (re.next()){
	sdate = re.getString("StartDate");
	sdate = sdate.substring(0,19);
	 stmp = sdate.substring(0,10)+"T"+sdate.substring(11,19);
	edate = re.getString("ExpirationDate");
	edate = edate.substring(0,19);
	iprice = re.getString("InitialPrice");
	incre = re.getString("Increment_for_bids");
	imm = re.getString("ImmPurchasePrice");
	pl = re.getString("PriceLimit");
}else{%>
	<script>alert("ileagal access!");
location.href = "index.jsp";
</script>
<%}
%><html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>BuyMe Auction <%=str%></title>
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
				<h2>Auction <%=str%></h2>
			</section>
			<section id="nav">
				<div class = "ul">
					<div class = "li"><a href="index.jsp">Home</a></div>
					<div class = "li"><a href="">In Ear Monitor</a></div>
					<div class = "li"><a href="">On Ear</a></div>
					<div class = "li"><a href="">Over Ear</a></div>
					<div class = "li"><a class="active" href="Support.jsp">Support</a></div>
				</div>
			</section>
			<div id="content">
			<section class="mainContent">
			<form method="post" action="AuctionsMod.jsp?aid=<%=aid%>">
			<table class = "QA" style="width:100%;">
			<tbody>
			<tr>
				<th><p>Auction ID:
				<br>
				<%=aid %></p></th>
				<th><p>Email:
				<br>
				<%=email %></p></th>
			</tr>
			<tr>
				<th><p>Earphone Name:
				<br>
				<%=name %></p></th>
				<th><p>Start Time:
				<br>
				<%=sdate %></p></th>
			</tr>
			<tr>
			<th><p>Initial Price:
				<br>
				<%=iprice %></p></th>
				<th><label for="edate">End Time: <%=edate %>(current)</label>
				<br>
				<input type="datetime-local" name="edate" id="edate" min=<%=stmp %> ></th>
			</tr>
			<tr>
				<th><label for="incre">Increment Bid:</label>
				<br>
				<input type="text" name="incre" id="incre" placeholder="<%=incre%>"  oninput="value=value.replace(/[^\d]/g,'')"></th>
				<th><label for="imm">Immediate purchase price:</label>
				<br>
				<input type="text" name="imm" id="imm" placeholder="<%=imm%>"  oninput="value=value.replace(/[^\d]/g,'')"></th>
			</tr>
			<tr>
				<th><label for="pl">Price Limit:</label>
				<br>
				<input type="text" name="pl" id="pl" placeholder="<%=pl%>"  oninput="value=value.replace(/[^\d]/g,'')"></th>
				<%if("admin".equals(type)){ 
				select = "select max(price) from Auction join `Account_Bid_Auction` using (AuctionID) where Price>PriceLimit and current_timestamp()>ExpirationDate and AuctionID =?";
				ps = con.prepareStatement(select);
				ps.setInt(1,aid);
				ps.executeQuery();
				re = ps.getResultSet();
				String res = "No Winner!";
				if (re.next()){
					res = re.getString("max(Price)");
					if (res==null){
						res = "No Winner!";
					}
				}%>
				<th><p>Auction Result:
				<br>
				<%=res %></p></th>
				<%} %>
			</tr>
			<tr><th>
			<input name="confirm" type="submit" class="button" id="confirm" value="confirm" style="width:100px;height:40px;float:left;">
			<input name="delet" class="button" id="delet" value="delet" style="width:100px;height:40px;float:right; text-align: center;" onclick="location.href= 'AuctionsMod.jsp?mode=1&aid=<%=aid%>'"></th>
			<th><input name="reset" type="reset" class="button" id="reset" value="reset" style="width:100px;height:40px;float:right;"></th>
			</tr>
			</tbody>
			</table>
			</form>
			<br>
			<br>	
			<br>
			<input name="submit" type="submit" class="button" id="submit" value="back" style="width:20%;height:40px;" onclick="location.href= 'Management.jsp?mode=Auctions&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
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
	<%con.close(); %>
</html>
