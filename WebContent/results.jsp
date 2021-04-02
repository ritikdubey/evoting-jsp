<%@page import="java.sql.ResultSet"%>
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
<link rel="stylesheet" href="voter.css">
</head>
<body>
<%
Connection con = null;
int ncount=0, rcount=0;

try{
	Class.forName("com.mysql.jdbc.Driver");
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evote?characterEncoding=utf8", "root", "root123");
	
	PreparedStatement ps = con.prepareStatement("select * from votes");
	
	ResultSet rs = ps.executeQuery();
	
	while(rs.next())
	{
		String name = rs.getString("voteto");
		if(name.equals("Narendra"))
			ncount++;
		if(name.equals("Rahul"))
			rcount++;
	}
	
}
catch(Exception e)
{
	System.out.println(e);
}

%>

<h1> Narendra Modi has <%=ncount%> votes </h1>
<br>
<br>
<h1> Rahul Gandhi has <%=rcount%> votes </h1>


</body>
</html>