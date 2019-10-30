<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String mode = request.getParameter("mode");
String str = request.getParameter("id");
int id = Integer.parseInt(str);



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
						String insert ="";
						PreparedStatement ps= con.prepareStatement(insert);
						if(mode.equals("0")){
							String name = request.getParameter("Name");
							String brand = request.getParameter("Brand");
							if(brand == ""){
								brand="unknown";
							}
						String model = request.getParameter("Model");
						if(model == ""){
							model="unknown";
						}
						String str1 = request.getParameter("Resistance");
						int resistance = 0;
						if(str1!=""){
						resistance = Integer.parseInt(str1);
						}
						String unit = request.getParameter("Unit");
						if(unit == ""){
							unit="unknown";
						}
						String pic = request.getParameter("Pic");
						if(pic == ""){
							pic="Assets/images/200x200.png";
						}
						String type = request.getParameter("type");
						String str2 = request.getParameter("wire");
						int wireless = Integer.parseInt(str2);
						String des = request.getParameter("Des");
						insert = "Update Earphone set Name=?,type=?,Brand=?,Description=?,Model=?,Resistance=?,DriveUnit=?,isWireless=?,Pic=? where EarphoneID=?";
						ps = con.prepareStatement(insert);
						ps.setString(1, name);
						ps.setString(2, type);
						ps.setString(3, brand);
						ps.setString(4, des);
						ps.setString(5, model);
						ps.setInt(6, resistance);
						ps.setString(7, unit);
						ps.setInt(8, wireless);
						ps.setString(9, pic);
						ps.setInt(10, id);
						ps.executeUpdate();
						if("in ear".equals(type)){
							String EarTip = request.getParameter("EarTip");
							if(EarTip == ""){
								EarTip="unknown";
							}
							String str3 = request.getParameter("NoiseCancel");
							int NoiseCancel = Integer.parseInt(str3);
							String Wearingway = request.getParameter("Wearingway");
							if(Wearingway == ""){
								Wearingway="unknown";
							}
							insert = "Update IEM set EarTip=?,NoiseCancel=?,Wearingway=? where EarphoneID=?";
							ps = con.prepareStatement(insert);
							ps.setString(1, EarTip);
							ps.setInt(2, NoiseCancel);
							ps.setString(3, Wearingway);
							ps.setInt(4, id);
						}else if("on ear".equals(type)){
							String Earpad = request.getParameter("Earpad");
							if(Earpad == ""){
								Earpad="unknown";
							}
							str1 = request.getParameter("Foldable");
							int Foldable = Integer.parseInt(str1);
							insert = "Update OnEar set Earpad=?,Foldable=? where EarphoneID=?";
							ps = con.prepareStatement(insert);
							ps.setString(1, Earpad);
							ps.setInt(2, Foldable);
							ps.setInt(3, id);
						}else{
							String Earpad = request.getParameter("Earpad");
							if(Earpad == ""){
								Earpad="unknown";
							}
							str1 = request.getParameter("NoiseCancel");
							int NoiseCancel = Integer.parseInt(str1);
							insert = "Update OverEar set Earpad=?,NoiseCancel=? where EarphoneID=?";
							ps = con.prepareStatement(insert);
							ps.setString(1, Earpad);
							ps.setInt(2, NoiseCancel);
							ps.setInt(3, id);
						}
						ps.executeUpdate();
						}else if ("1".equals(mode)){
							insert = "DELETE FROM `Earphone` WHERE EarphoneID=?";
							ps = con.prepareStatement(insert);
							ps.setInt(1, id);
							ps.executeUpdate();
						}
						
						out.println("Modify success!");%>
					<script>
					onload=function(){
					    setInterval(go, 1000);};
					var x=3;
					function go(){
					    x--;
					    if(x>0){
					        document.getElementById("timer").innerHTML=x;
						   }else{
									location.href = "MyAccount.jsp?mode=My_Earphone";
							}
					   }   
				</script>
				<br>
				This page would auto get you back in <span id="timer">3</span> seconds.
				
				<%
					con.close();
					}
					catch (Exception ex) {
					out.println("Oops Something goes wrong.");%>
				<br>
				<form method="post" action="MyAccount.jsp?mode=My_Earphone">
					<input type="submit" class = "button" value="back">
				</form>
				<%}
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