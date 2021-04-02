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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>


<%

try{
String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String constituency = request.getParameter("constituency");
String mobile = request.getParameter("mobile");
String password = request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/evote?characterEncoding=utf8", "root", "root123");

PreparedStatement ps = con.prepareStatement("insert into voter values(?, ?, ?, ?, ?, ?)");
ps.setString(1, name);
ps.setString(2, email);
ps.setString(3, address);
ps.setString(4, constituency);
ps.setString(5, mobile);
ps.setString(6, password);

System.out.println(name);


int i = ps.executeUpdate();




if(i>0){%>

<h1> Following data is recorded: </h1>

<table class="table table-bordered">
  <thead>
    <tr>
      <th scope="col">Name</th>
      <th scope="col">Email</th>
      <th scope="col">Address</th>
      <th scope="col">Constituency</th>
      <th scope="col">Mobile</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td> <%= name %> </td>
      <td> <%= email %> </td>
      <td> <%= address %> </td>
      <td> <%= constituency %> </td>
      <td> <%= mobile %> </td>
    </tr>
    
    
  </tbody>
</table>
	


<%}
else{%> 
	<h1>Cannot Insert Record</h1>
<%}

}

catch(Exception e)
{
	out.println(e);
}


%>


<button class="btn btn-outline-primary btn-md" onClick="window.location.href='voter.html'" style="margin-top: 8%; left: 40%;"> Back to Homepage </button>




</body>
</html>