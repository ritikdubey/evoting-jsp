<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Driver"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="voter.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>


<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">Navbar</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="voter.jsp">Home</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="profile.jsp">Your Profile</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="logout.jsp">Logout</a>
      </li>
      
    </ul>
  </div>
</nav>

<%
String email=null;
String name=null;
Connection con = null;
try{
email = request.getParameter("email");
String password = request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");
con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evote?characterEncoding=utf8", "root", "root123");

PreparedStatement ps = con.prepareStatement("select * from voter where email=? and password=?");
ps.setString(1, email);
ps.setString(2, password);

ResultSet i = ps.executeQuery();

if(i.next())
{
	
	
	if(session.isNew())
	{
		session.setAttribute("email", email);
		session.setAttribute("password", password);
	}
	else
	{
		RequestDispatcher rd = request.getRequestDispatcher("voter.html");
		rd.include(request, response);
		session.invalidate();
		response.sendRedirect("voter.html");
	}
	

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

<h1>Welcome to eVoting Portal, <%=name %></h1>

<form action="registervote.jsp" method="post" class="voterform" style="text-align: center; border: 2px solid black; box-shadow:0 0 15px 4px rgba(0,0,0,0.06);">
<p>Please select your Candidate:</p>
<%
PreparedStatement ps3 = con.prepareStatement("select * from candidate");
ResultSet rs3 = ps3.executeQuery();
while(rs3.next())
{	
%>

  <input type="radio" id="" name="vote" value=<%=rs3.getString("name") %> >
  <label for="vote"><%=rs3.getString("name") %></label>
  <br>
<%} %>
  <input type="submit" value="VOTE NOW!">
</form>


</body>
</html>