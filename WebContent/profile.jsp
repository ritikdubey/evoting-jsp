<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="voter.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Insert title here</title>
</head>


<body>

<%

String email=session.getAttribute("email");


try{
email = request.getParameter("email");
String password = request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evote?characterEncoding=utf8", "root", "root123");

PreparedStatement ps = con.prepareStatement("select * from voter where email=? and password=?");
ps.setString(1, email);
ps.setString(2, password);

ResultSet i = ps.executeQuery();

	

}
else{ 
	
	RequestDispatcher rd = request.getRequestDispatcher("voter.html");
	rd.include(request, response);
	
}


PreparedStatement ps2 = con.prepareStatement("select name from voter where email=?");
ps2.setString(1, email);

ResultSet j = ps2.executeQuery();

while(j.next()){
	name = j.getString("name");
}


}
catch(Exception e)
{
System.out.println(e);	
}



%>


</body>
</html>