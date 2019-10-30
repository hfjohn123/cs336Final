<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String burl =request.getRequestURI();%>
<html>
<%
	String str = request.getParameter("page");
	int pagenum;
	if (("null").equals(str)){
		str = null;
	}
	if (str == null) {
		pagenum = 0;
	} else {
		pagenum = Integer.parseInt(str);
	}
	String nr = request.getParameter("NR");
	if (("null").equals(nr)){
		nr = null;
	}
	String me = request.getParameter("Me");
	if (("null").equals(me)){
		me = null;
	}
	String search = request.getParameter("Search");
	if(("null").equals(search)){
		search = null;
	}
	String temp = null;
	String temp1 = null;
	if (search == "") {
		search = null;
	}
	if (search != null) {
		search = search.trim();
		temp = search;
		temp1 = search.replaceAll("\\s+", "%' or Subject like '%");
		temp1 = "'%"+temp1+"%'";
	}
	String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "root", "12345678");
	Statement stmt = con.createStatement();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe Q&A</title>
<link href="Assets/styles/CSS.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="Assets/styles/jquery1.42.min.js"></script>
<script language="javascript">
			function refresh(id,str,max,se,m,n){
				if(str==""){
			
				}else{
					 var x = Number(str)-1;
					 if (x<=max && x>-1){
						self.location.href="QA.jsp?page="+x+"&Search="+se+"&Me="+m+"&NR="+n;
					 }else{
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
			<%
				String test = (String) session.getAttribute("email");
				if (test == null) {
			%><a href="login.jsp?burl=<%=burl %>" title="Login/Register">Login/Register</a>
			<%
				} else {
			%>
			<a href="MyAccount.jsp" title="MyAccount">MyAccount</a><a
				href="Logout.jsp" title="Logout">Log out</a>
			<%
				}
			%>
		</div>
		</header>
		<section id="banner">
		<h2>Question & Answer</h2>
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
			<form action="QA.jsp?page=0" method="post" name = "myform" id="myform">
				<p>
					<input type="text" Name="Search" id="search"
						placeholder="Your Question" <%if (search != null) {%>
						value="<%=search%>" <%}%>>
				</p>
				<p>
					<%
					String type = (String)session.getAttribute("type");
						if (test != null && ("enduser").equals(type)) {
					%>
					<label> <input type="checkbox" name="Me" value="Multiple"
						id="Checkbox" <%if (me != null) {%> checked="checked" <%}%>>
						My question Only
					</label>
					<%
						}
						
						if("admin".equals(type)||"CR".equals(type)){%>
					<label> <input type="checkbox" name="NR" value="Multiple"
						id="Checkbox1" <%if (nr != null) {%> checked="checked" <%}%>>
						Non-reply Only
						</label>
					<%	}
					%>
				</p>
				<input name="submit" type="submit" class="button"
					id="submit" value="Search"><br> <input type="submit"
					class="button" value="rest"
					onclick="$(':input','#myform').not(':button, :submit, :reset, :hidden').val('').removeAttr('checked').removeAttr('selected');">
			</form>
			</section>
			<section class="mainContent">
			<table class="QA">
				<tbody>
					<%
						String select = null;
						PreparedStatement ps = null;
						if (search != null  && nr!=null) {
							select = "Select count(*) as num from (Select * from Account_QA where `ReFrom` is null and ( Content like '%"+temp+"%' or Subject like "+temp1+"))t1";
							ps = con.prepareStatement(select);
						}else if (search != null && me != null) {
							select = "Select count(*) as num from (Select * from Account_QA where `From`=? and ( Content like '%"+temp+"%' or Subject like "+temp1+"))t1";
							ps = con.prepareStatement(select);
							ps.setString(1, test);
						} else if (search != null) {
							select = "Select count(*) as num from (Select * from Account_QA where ( Content like '%"+temp+"%' or Subject like "+temp1+"))t1";
							ps = con.prepareStatement(select);
						} else if (me != null) {
							select = "Select count(*) as num from (Select * from Account_QA where `From`=?)t1";
							ps = con.prepareStatement(select);
							ps.setString(1, test);
						} else if(nr!=null){
							select = "Select count(*) as num from (Select * from Account_QA where `ReFrom` is null)t1";
							ps = con.prepareStatement(select);
						}
						else {
							select = "Select count(*) as num from Account_QA";
							ps = con.prepareStatement(select);
						}
						ps.executeQuery();
						ResultSet re = ps.getResultSet();
						String t = "";
						if (re.next()) {
							t = re.getString("num");
							int max = Integer.parseInt(t);
							int maxpage = max / 10;
							if (max%10 == 0){
								maxpage--;
							}
							String select1 = null;
							PreparedStatement ps1 = null;
							int id_min = pagenum*10;
							if (search != null  && nr!=null) {
								select1 = "Select * from Account_QA where `ReFrom` is null and Content like '%"+temp+"%' or Subject like "+temp1+" order by QAID desc limit ?,10";
								ps1 = con.prepareStatement(select1);
								ps1.setInt(1, id_min);
							}else if (search != null && me != null) {
								select1 = "Select * from Account_QA where `From`=? and Content like '%"+temp+"%' or Subject like "+temp1+" order by QAID desc limit ?,10";
								ps1 = con.prepareStatement(select1);
								ps1.setString(1, test);
								ps1.setInt(2, id_min);
							} else if (search != null) {
								select1 = "Select * from Account_QA where Content like '%"+temp+"%' or Subject like "+temp1+" order by QAID desc limit ?,10";
								ps1 = con.prepareStatement(select1);
								ps1.setInt(1, id_min);
							} else if (me != null) {
								select1 = "Select * from Account_QA where `From`=? order by QAID desc limit ?,10";
								ps1 = con.prepareStatement(select1);
								ps1.setString(1, test);
								ps1.setInt(2, id_min);
							} else if(nr != null){
								select1 = "Select * from Account_QA where `ReFrom` is null order by QAID desc limit ?,10";
								ps1 = con.prepareStatement(select1);
								ps1.setInt(1, id_min);
							}
							else {
								select1 = "Select * from Account_QA order by QAID desc limit ?,10";
								ps1 = con.prepareStatement(select1);
								ps1.setInt(1, id_min);
							}
							ps1.executeQuery();
							ResultSet re1 = ps1.getResultSet();
							for (int i = 0; i < 10; i++) {
								if (re1.next()) {
									String subject = re1.getString("subject");
									int id = re1.getInt("QAID");
					%>
					<tr>
						<th style="cursor: pointer;"
							onclick="location.href= 'QAsub.jsp?id=<%=id%>&page=<%=pagenum%>&Search=<%=search%>&Me=<%=me%>&NR=<%=nr%>'">
							<p>
								Q:
								<%
								out.print(subject);
							%>
							</p>
						</th>
					</tr>
					<%
						}
							}
					%>
				</tbody>
			</table>
			<table class="changepage">
				<tr>
					<th>
						<%
							if (pagenum > 0) {
						%><a href="QA.jsp?page=<%=pagenum - 1%>&Search=<%=search %>&Me=<%=me %>&NR=<%=nr %>" title="Last"><--Last</a>
						<%
							}
						%>
					</th>
					<th><input type="text" name="pagenum" id="pagenum"
						placeholder="<%=pagenum+1 %>"
						oninput="value=value.replace(/[^\d]/g,'')"
						onKeyPress="if(window.event.keyCode==13) this.blur();"
						onblur="refresh(this.id,this.value,<%=maxpage%>,'<%=search%>','<%=me%>','<%=nr%>');"><label
						for="pagenum">/<%=maxpage+1%></label></th>
					<th>
						<%
							if (maxpage > pagenum) {
						%><a href="QA.jsp?page=<%=pagenum + 1%>&Search=<%=search %>&Me=<%=me %>&NR=<%=nr %>" title="Next">Next--></a>
						<%
							}
						%>
					</th>
				</tr>
			</table>
			<br>
			<%
				}if (test != null && "enduser".equals(type)){
			%>
			<div class="text" >
				<h2>Not Finding what you want?</h2>
				<form method="post" action="New_Q.jsp?burl=<%=burl%>">
					<p>
						<label for="textfield">Subject:</label> <input type="text"
							name="Subject" id="textfield" required>
					</p>
					<p>
						<label for="textarea" style="vertical-align: middle;">Content:</label>
						<textarea name="Context" cols="40" rows="4" id="textarea" required></textarea>
					</p>
					<br>
					<p>
						<input name="submit" type="submit" class="button" id="submit"
							value="Help!!!" style="width: 20%; height: 40px; left: 60px">
					</p>
				</form>
			</div>
			<br><br>
			<%} %>
			</section>
			<%con.close(); %>
			
		</div>
		<footer>
			<div>
				<p>CSS designed by Qi Song (group 2). Please open this website
					on a PC, but not other mobile devices.</p>
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
</html>