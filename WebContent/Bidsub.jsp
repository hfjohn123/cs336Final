<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String email = request.getParameter("email");
String str = request.getParameter("aid");
String name = request.getParameter("name");
String time = request.getParameter("time");
String pagenum = request.getParameter("page");
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
if (email==null || name ==null || time == null ||str==null){%>
	<script>location.href = "Management.jsp?mode=Bids";</script>
<%}
int aid = Integer.parseInt(str);
String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url, "root", "12345678");
Statement stmt = con.createStatement();
String select = "select * from `Account_Bid_Auction` where Email=? and AuctionID =? and Datetime=?";
PreparedStatement ps = con.prepareStatement(select);
ps.setString(1,email);
ps.setInt(2,aid);
ps.setString(3,time);
ps.executeQuery();
ResultSet re = ps.getResultSet();
String price = "";
String a_price = "";
if (re.next()){
	price = re.getString("price");
	a_price = re.getString("Auto_price");
}else{%>
	<script>alert("ileagal access!");
location.href = "index.jsp";
</script>
<%}
%><html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>BuyMe Bids</title>
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
				<h2><%=email %>'s Bid toward Auction <%=aid %></h2>
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
			<form method="post" action="BidsMod.jsp?email=<%=email%>&aid=<%=aid%>&time=<%=time%>&oa_price=<%=a_price%>">
			<table class = "QA" style="width:100%;">
			<tbody>
			<tr>
				<th><p>Email:
				<br>
				<%=email %></p></th>
				<th><p>Auction ID:
				<br>
				<%=aid %></p></th>
			</tr>
			<tr>
				<th><p>Earphone Name:
				<br>
				<%=name %></p></th>
				<th><p>Time:
				<br>
				<%=time %></p></th>
			</tr>
			<tr>
				<th><label for="price">Price:</label>
				<br>
				<input type="number" name="price" id="price" step = 1 placeholder="<%=price%>"  oninput="value=value.replace(/[^\d]/g,'')"></th>
				<th><label for="a_price">Auto Bid:</label>
				<br>
				<input type="number" name="a_price" id="price" placeholder="<%=a_price%>(blank:no change; null: set to null)"  oninput="value=value.replace(/[^\d]/g,'')"></th>
			</tr>
			<tr><th>
			<input name="confirm" type="submit" class="button" id="confirm" value="confirm" style="width:100px;height:40px;float:left;">
			<input name="delet" class="button" id="delet" value="delet" style="width:100px;height:40px;float:right; text-align: center;" onclick="location.href= 'BidsMod.jsp?mode=1&email=<%=email%>&aid=<%=aid%>&time=<%=time%>'"></th>
			<th><input name="reset" type="reset" class="button" id="reset" value="reset" style="width:100px;height:40px;float:right;"></th>
			</tbody>
			</table>
			</form>
			<br>
			<input name="submit" type="submit" class="button" id="submit" value="back" style="width:20%;height:40px;" onclick="location.href= 'Management.jsp?mode=Bids&page=<%=pagenum%>&Sear=<%=search%>&Auto=<%=auto%>'">
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
