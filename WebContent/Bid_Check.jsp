<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String str = request.getParameter("id");
if (str==null||"null".equals(str)){%>
	<script>alert("ileagal access!");
	location.href = "index.jsp";
	</script>
<% }else{
	int aid = Integer.parseInt(str);
	String pir = request.getParameter("Price");
	int price = Integer.parseInt(pir);
	String str1 = request.getParameter("Auto_Price");
	int a_p = 0; 
			if(str1 != ""){
				a_p=Integer.parseInt(str1);
			}
	String test =  request.getParameter("target");
	if(test == null||"null".equals(test)){
			test = (String) session.getAttribute("email");
	}
	if (test == null){%>
		<script>alert("ileagal access!");
		location.href = "index.jsp";
		</script>
<%	}else{
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
						String content = request.getParameter("Context");
						String select = "select * from `Account_Bid_Auction` right join Auction using (AuctionID) where AuctionID =? order by Price desc";
							PreparedStatement ps = con.prepareStatement(select);
							ps.setInt(1, aid);
							ps.executeQuery();
							ResultSet re = ps.getResultSet();
							String Email = null;
							int a_Price = 0;
							int incre =0;
							int imm = 0;
							if (re.next()){
								Email = re.getString("Email");
								a_Price = re.getInt("Auto_price");
								incre = re.getInt("Increment_for_bids");
								imm = re.getInt("ImmPurchasePrice");
							}
							String insert = "INSERT INTO `Account_Bid_Auction`(Email,AuctionID,Price,Auto_price)"
									+ "VALUES (?,?,?,?)";
							ps = con.prepareStatement(insert);
							ps.setString(1, test);
							ps.setInt(2, aid);
							ps.setInt(3, price);
							ps.setInt(4, a_p);
							ps.executeUpdate();
							if (imm>0 && price >= imm){
									insert = "Update Auction set ExpirationDate = current_timestamp() where AuctionID=?";
									ps = con.prepareStatement(insert);
									ps.setInt(1, aid);
									ps.executeUpdate();
							}else{
								if (a_Price>price+incre){%>
									<script>
										location.href = "Bid_Check.jsp?id=<%=aid%>&target=<%=Email%>&Price=<%=price+incre%>&Auto_Price=<%=a_Price%>";
									</script>
								<%}else{
									String insert1 = "INSERT INTO `Account_Use_Email`(`From`,`To`, Subject,Content,isAlert)"
											+ "VALUES (?,?, ?, ?,?)";
									%>
						    		<script>console.log("<%=insert1%>")</script>
						    		<%
						    		if (Email!=null){
									ps = con.prepareStatement(insert1);
									ps.setString(1, "CR@buyme.com");
									ps.setString(2, Email);
									ps.setString(3, "You are losing in an Auction!");
									ps.setString(4, "Hi There, there is someone just bid over yours. Check it now! <a href='Auctions.jsp?aid="+aid+"'>Link</a>");
									ps.setInt(5, 1);
									ps.executeUpdate();
						    		}
								}
							}
							out.println("Bid success");%>
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
							
					<%con.close();
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