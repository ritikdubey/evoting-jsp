<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
Connection con = null;
int i=-1;
String email = (String) session.getAttribute("email");
String voteto = request.getParameter("vote");

try{
Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evote?characterEncoding=utf8", "root", "root123");

PreparedStatement ps1 = con.prepareStatement("insert into votes values(?, ?)");
ps1.setString(1, email);
ps1.setString(2, voteto);

i = ps1.executeUpdate();

}
catch(Exception e){
	System.out.println(e);
}

if(i>0)
{
%>
<h1>You have successfully cast your vote!</h1>
<h2><%=voteto %></h2>
<%}
else {
%>
<h1>We couldn't register your vote</h1>
<% } %>

</body>
</html>
