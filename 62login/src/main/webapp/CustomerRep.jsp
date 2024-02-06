<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Representative</title>

<style>
    table {
        border-collapse: separate; 
        vertical-border-spacing: 35px; 
    }
    td {
        padding: 3px;
    }
</style>

</head>
<body>

	<%!PreparedStatement p; ResultSet rs; Connection con;%>
	
	<% try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con =DriverManager.getConnection("jdbc:mysql://localhost:3306/travelsite", "root", "#Neshanic2850");
		p = con.prepareStatement("select username, question, answer from questionsandanswers");
		rs=p.executeQuery();
		//rs.close();
		//p.close();
		//con.close();
		
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	} 
	
	%>
		
		<table>
		<tr>    
			<td>User</td>
			<td>Question </td>
			<td>Answer </td>			
		</tr>
					<%
			while (rs.next()) { %>
				<tr>  
					<td><form action=AnswerQuestion.jsp method=post>
							<input type=text input value=<% out.println(rs.getString("Username")); %>name=username value=<% out.println(rs.getString("Username")); %> readonly>
							
					</td>
					<td>
							<input type=text input value=<% out.println(rs.getString("Question")); %> name=password value=<% out.println(rs.getString("Question")); %> readonly>
							
					</td>
					<td>	
							<input value=<% out.println(rs.getString("Answer")); %> name=password value=<% out.println(rs.getString("Answer")); %> readonly>
							<input type=submit name=val value="Answer">
					</td>
					</form>
			<% } %>
			</tr>
	</table>
	
</body>
</html>