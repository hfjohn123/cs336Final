<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String burl =request.getRequestURI();
String pagenum = request.getParameter("page");
String nr = request.getParameter("NR");
String me = request.getParameter("Me");
String search = request.getParameter("Search");
%>
<html>
<%
	String str=request.getParameter("id");
	if(str == null){%>
		<script>
		location.href = "QA.jsp?page=0";
		</script>
	<% }else{
		String subject = "";
		String content ="";
		String recontent = "";
		int id = Integer.parseInt(str);
		String url = "jdbc:mysql://cool.clyqhrxhl416.us-east-2.rds.amazonaws.com:3306/project";
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "root", "12345678");
		Statement stmt = con.createStatement();
		String select = "Select * from Account_QA where QAID=?";
		PreparedStatement ps = con.prepareStatement(select);
		ps.setInt(1,id);
		ps.executeQuery();
		ResultSet re = ps.getResultSet();
		if (re.next()){
			subject = re.getString("Subject");
			content = re.getString("Content");
			recontent = re.getString("ReContent");
		}else{%>
			<script>alert("ileagal access!");
		location.href = "index.jsp";
		</script>
<%}
%>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>BuyMe Q&A<%=id%></title>
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
					String type = (String)session.getAttribute("type");
						if (test == null){
						%><a href="login.jsp?burl=<%=burl %>" title="Login/Register">Login/Register</a>
					<%}else{%>
					<a href="MyAccount.jsp" title="MyAccount">MyAccount</a><a href="Logout.jsp" title="Logout">Log out</a><%} %>
				</div>
			</header>
			<section id="banner">
				<h2>Q: <%=subject %></h2>
			</section>
			<section id="nav">
				<div class = "ul">
						<div class = "li"><a href="index.jsp">Home</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=inear">In Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=onear">On Ear</a></div>
					<div class = "li"><a href="sort&select.jsp?RadioGroup1=overear">Over Ear</a></div>
					<div class = "li"><a class="active" href="Support.jsp">Support</a></div>
				</div>
			</section>
			<div id="content">
			<section class="mainContent">
			<div class ="text">
				<p><%=content %></p>
				<br><br><br>
			<%if(recontent!=null) {%>
				<h2>Answer:</h2>
				<p><%=recontent %></p>
			<%}
			%>
			<br>
			<br>	
			<input name="submit" type="submit" class="button" id="submit" value="back" style="width:20%;height:40px;left:50%;" onclick="location.href= 'QA.jsp?page=<%=pagenum%>&Search=<%=search%>&Me=<%=me%>&NR=<%=nr%>'">
			</div>
			<%if (test != null){if(recontent==null&&(("admin").equals(type)||("CR").equals(type))){ %>
				<div class ="text">
				<h2>You can answer this one?</h2>	
				<form method="post" action="New_A.jsp?id=<%=id%>">
				<p><label for="textarea"  style="vertical-align:middle;">Reply:</label>
					<textarea name="Context" cols="40" rows="4" id="textarea"></textarea>
				</p>
				<br>
				<p>
				<input name="submit" type="submit" class="button" id="submit" value="Here you go!" style="width:20%;height:40px;left:60px">
				</p>
				</form>
				</div>
			<%	}else if(("admin").equals(type)||("CR").equals(type)){%>
				<div class ="text">
				<h2>Have a better Answer?</h2>	
				<form method="post" action="New_A.jsp?id=<%=id%>">
				<p><label for="textarea"  style="vertical-align:middle;">Reply:</label>
					<textarea name="Context" cols="40" rows="4" id="textarea" required></textarea>
				</p>
				<br>
				<p>
				<input name="submit" type="submit" class="button" id="submit" value="Here you go!" style="width:20%;height:40px;left:60px">
				</p>
				</form>
				</div>
			<%}}
					%> 
			
				<br>
				
				
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
	<%} %>
</html>
