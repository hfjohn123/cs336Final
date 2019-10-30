<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.ParseException,java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String id = request.getParameter("id");
String test = (String) session.getAttribute("email");
if (test == null) {
%>
<script>
alert("You do not have access to this page")
location.href = "login.jsp";
</script>
<%
}
if (id==null){%>
	<script>location.href = "MyAccount.jsp?mode=My_Earphone";</script>
<%}
int eid = Integer.parseInt(id);

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
				<h2>Earphone <%=id %></h2>
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
			<section class="mainContent"><%
			String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "root", "12345678");
			Statement stmt = con.createStatement();
			String select = "SELECT *,current_timestamp as now FROM project.Earphone left join IEM using (EarphoneID) left join OnEar using (EarphoneID) left join OverEar using (EarphoneID) left join Auction using (EarphoneID) where EarphoneID  = ? order by ExpirationDate desc limit 0,1";
			PreparedStatement ps = con.prepareStatement(select);
			ps.setInt(1,eid);
			ps.executeQuery();
			ResultSet re = ps.getResultSet();
			if (re.next()){
				String email = re.getString("Email");
				String name = re.getString("Name");
				String type =  re.getString("type");
				String Pic =  re.getString("Pic");
				String brand =  re.getString("Brand");
				String model =  re.getString("Model");
				java.util.Date edate = re.getTimestamp("ExpirationDate");
				java.util.Date date=re.getTimestamp("now");
				int wire = re.getInt("isWireless");
				String unit = re.getString("DriveUnit");
				String des =  re.getString("Description");
				int resistance = re.getInt("Resistance");
				String EarTip="";
				int Noise = 0;
				String Wearingway = "";
				String Earpad = "";
				int fold = 0;
				int noise = 0;
				if (!(test.equals(email))) {
					%>
					<script>
					alert("You do not have access to this page")
					location.href = "MyAccount.jsp?mode=My_Earphone";
					</script>
					<%
					}
				if("in ear".equals(type)){
					EarTip = re.getString("EarTip");
					Noise = re.getInt("NoiseCancel");
					Wearingway = re.getString("Wearingway");
				}else if("on ear".equals(type)){
					 Earpad = re.getString("Earpad");
					 fold = re.getInt("Foldable");
				}else{
					Earpad = re.getString("Earpad");
					noise = re.getInt("NoiseCancel");
				}
				long diff = 0;
				if(edate != null){
					long nd = 1000 * 24 * 60 * 60;
			   	 	long nh = 1000 * 60 * 60;
					long nm = 1000 * 60;
					long ns = 1000;
					diff = edate.getTime() - date.getTime();
			   	}%>
				<form method="post" action="EarphoneMod.jsp?mode=0&id=<%=id%>">
				<table class = "QA" style="width:100%;">
				<tbody>
				<tr>
					<th><label for="name">Name:</label>
					<br>
					<input type="text" name="Name" id="name" value=<%=name %> required></th>
					<th><label for="brand">Brand:</label>
					<br>
					<input type="text" name="Brand" id="brand" value=<%=brand %>></th>
				</tr>
				<tr>
					<th><label for="model">Model:</label>
					<br>
					<input type="text" name="Model" id="model" value=<%=model %>></th>
					<th><label for="resistance">Resistance:</label>
					<br>
					<input type="number" name="Resistance" id="resistance" oninput="value=value.replace(/[^\d]/g,'')" value=<%=resistance %>>
					</th>
				</tr>
				<tr>
				<th><label for="unit">Drive Unit:</label>
					<br>
					<input type="text" name="Unit" id="unit" value=<%=unit %>></th>
					<th><label for="pic">Picture:</label>
					<br>
					<input type="text" name="Pic" id="pic" value=<%=Pic %>></th>
				</tr>
				<tr>
				<th><label for="type">*Type:</label>
					<br>
					<select name="type" size=1 >
					<option value="in ear" <%if("in ear".equals(type)){%>selected = "selected"<%}%>>in ear</option>
					<option value="on ear"<%if("on ear".equals(type)){%>selected = "selected"<%}%>>on ear</option>
					<option value="over ear"<%if("over ear".equals(type)){%>selected = "selected"<%}%>>over ear</option></th>
					<th><label for="wire">*Wireless:</label>
					<br>
					<select name="wire" size=1 value=<%=wire %>>
					<option value="1"<%if(1==wire){%>selected = "selected"<%}%>>Yes</option>
					<option value="0"<%if(0==wire){%>selected = "selected"<%}%>>No</option></th>
				</tr>
				<%if("in ear".equals(type)){%>
					<tr>
					<th><label for="EarTip" value=<%=EarTip %>>EarTip:</label>
					<br>
					<input type="text" name="EarTip" id="EarTip"value=<%=EarTip %>></th>
					<th>
					<label for="NoiseCancel">*NoiseCancel:</label>
					<br>
					<select name="NoiseCancel" size=1 >
					<option value="1" <%if(1==Noise){%>selected = "selected"<%}%>>Yes</option>
					<option value="0" <%if(0==Noise){%>selected = "selected"<%}%>>No</option></th>
				</tr>
				<tr>
				<th><label for="Wearingway" >Wearingway:</label>
				<br>
					<input type="text" name="Wearingway" id="Wearingway" value=<%=Wearingway %>></th>
				</tr>
				<%}else if("on ear".equals(type)){%>
					<tr>
				<th><label for="Earpad">Earpad:</label>
				<br>
				<input type="text" name="Earpad" id="Earpad" value=<%=Earpad %> ></th>
				<th>
				<label for="Foldable">*Foldable:</label>
				<br>
				<select name="Foldable" size=1>
				<option value="1"<%if(1==fold){%>selected = "selected"<%}%>>Yes</option>
				<option value="0"<%if(0==fold){%>selected = "selected"<%}%>>No</option></th>
			</tr>
				<% }else{%>
					<tr>
				<th><label for="Earpad">Earpad:</label>
				<br>
				<input type="text" name="Earpad" id="Earpad" value=<%=Earpad %>></th>
				<th>
				<label for="NoiseCancel">*NoiseCancel:</label>
				<br>
				<select name="NoiseCancel" size=1>
				<option value="1"<%if(1==Noise){%>selected = "selected"<%}%>>Yes</option>
				<option value="0"<%if(0==Noise){%>selected = "selected"<%}%>>No</option></th>
			</tr>
				<%}
				%>
				<tr>
				<th><label for="Des">*Description:</label>
					<br>
					<textarea name="Des" cols="40" rows="4" id="textarea" required ><%=des %></textarea>
				</tr>
				
				
				
				<%if(diff<0 || edate == null){%>
					<tr><th>
			<input name="confirm" type="submit" class="button" id="confirm" value="confirm" style="width:100px;height:40px;float:left;">
			<input name="sell" class="button" id="sell" value="sell" style="width:100px;height:40px;float:right; text-align: center;" onclick="location.href= 'Post_Auction.jsp?id=<%=id%>'"></th>
			<th><input name="delete" type="delete" class="button" id="delet" value="delete" style="width:100px;height:40px;float:right;"onclick="location.href='EarphoneMod.jsp?mode=1&id=<%=id%>'"></th>
			</tr>
				<%}else{%>
					<tr><h2>There is an on going auction of this item!</h2></tr>
				<% }%>
				</tbody>
				</table>
				</form>
			<%}
	%>
			<input name="submit" type="submit" class="button" id="submit" value="back" style="width:20%;height:40px;" onclick="location.href= 'MyAccount.jsp?mode=My_Earphone'">
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
