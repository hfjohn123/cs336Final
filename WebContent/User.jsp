<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% String str = request.getParameter("target");
String mode = request.getParameter("mode");
session.setAttribute("target", str);%>
<script>
location.href = "MyAccount.jsp?mode=<%=mode%>";
</script>

