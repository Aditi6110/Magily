<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head> 
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Registration</title>
	</head>
	<body>
		<h2>Registration</h2>
		<%@ page language="java" %>
		<%@ page import="java.sql.*" %>
		<%@ page import="java.sql.DriverManager.*" %>
		
		<%
			String s1=request.getParameter("name");
			String s2=request.getParameter("email");
			String s3=request.getParameter("phone");
			String s4=request.getParameter("uname");
			String s5=request.getParameter("pass");
			PreparedStatement ps;
			Connection con=null;
			ResultSet re=null;
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con=DriverManager.getConnection("jdbc:mySql//localhost:3306/mydb1","root","root");
			Statement stmt=con.createStatement();
			ps=con.prepareStatement("insert into mybd1 values(?,?,?,?,?)");
			ps.setString(1,s1);
			ps.setString(1,s2);
			ps.setString(1,s3);
			ps.setString(1,s4);
			ps.setString(1,s5);
			
			int insertResult=ps.ExecuteUpdate();
			if(insertResult!=0){
				System.out.println("Successfully Registered");
			}
			
		%>
	</body>
</html>
