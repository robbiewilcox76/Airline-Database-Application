<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Center</title>
</head>
<body>

<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/travelsite", "root", "#Neshanic2850");
		PreparedStatement p;
		String userName = request.getParameter("username");
		String passWord = request.getParameter("password");

		
		if(request.getParameter("val").equals("Edit username")) {
			String newUser = request.getParameter("newUser");
			p = con.prepareStatement(
				"update customer set username=? where username =? and password =?"
			); 
			p.setString(1, newUser);
			p.setString(2, userName);
			p.setString(3, passWord);
			p.executeUpdate();
		}
		
		else {
			String newPass = request.getParameter("newPass");
			p = con.prepareStatement(
				"update customer set password=? where username =? and password =?"
			); 
			p.setString(1, newPass);
			p.setString(2, userName);
			p.setString(3, passWord);
			p.executeUpdate();
		}
		p.close();
		con.close();
		
		
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	} 

%>
	<%out.println("Success");%>
	<br><br><form action=home.jsp method=post>
		<input type="submit" value="Log out">
	</form>

</body>
</html>