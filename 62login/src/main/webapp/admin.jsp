<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
</head>
<body>

<%!String maxUserName = "", customerName = ""; double max; LinkedList<String> maxSold; int size; PreparedStatement p; ResultSet rs; Connection con;%>

	<%
		out.println("Logged in as admin");
	%>
	<br><br>
	Select Month For Sales Report
	<form method=get>
		<input type="date" name="date" min="2023-01-01" max="2024-12-31" />
		<input type="submit" formaction=SalesReport.jsp value = "Go"><br><br>
	</form>
		
	Search Reservations By: <br>
	<form action=ResList.jsp method=get>
		<input type="radio" name="sortBy" value="flightNumber"/>Flight Number
		<input type="radio" name="sortBy" value="customerName"/>Customer Username
		<br>
		
		Value: <input type=text name="value">
		<br>
		<input type="submit" value="Search">
	</form>
	
	
	<%
	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con =DriverManager.getConnection("jdbc:mysql://localhost:3306/travelsite", "root", "#Neshanic2850");
			p = con.prepareStatement(
			" select username, format(sum(totalfare),2) total from customersforticket join ticket using (ticketnumber) group by username "
				); 
			rs=p.executeQuery();
			while (rs.next()) {
        		double rev = rs.getDouble("total");
        		String userName = rs.getString("username");
        		if(rev > max) {
        			max = rev;
        			maxUserName = userName;
        		}
        	}
			p = con.prepareStatement("select CustomerName from Customer where Username = ?");
			p.setString(1, maxUserName);
			rs = p.executeQuery();
			while(rs.next()) {
				customerName = rs.getString("CustomerName");
			}
			p = con.prepareStatement("drop table if exists temp");
			p.executeUpdate();
			p = con.prepareStatement(
				"create table temp as select ticketnumber, count(*) numSold from customersforticket join ticket using (ticketnumber) group by ticketnumber"
			);
			p.executeUpdate();
			p = con.prepareStatement("select ticketnumber maxTickets from temp where numSold = (select max(numSold) from temp);");
			rs = p.executeQuery();
			maxSold = new LinkedList<>();
			while(rs.next()) {
				maxSold.add(rs.getString("maxTickets"));
			}
			size = maxSold.size();
			rs.close();
			p = con.prepareStatement("drop table temp");
			p.executeUpdate();
			p.close();
			con.close();
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	
	%>

	
	<br><br>
	Filter Revenue By: <br>
	<form action=RevenueFilter.jsp method=get>
		<input type="radio" name="filter" value="Ticket Number"/>Ticket Number
		<input type="radio" name="filter" value="Name"/>Customer Name
		<input type="radio" name="filter" value="Airline"/>Airline
		<br>
		<input type="submit" value="Filter">
	</form>
	
	<%! 
		String name, username, password;
	%>
	
	<%
	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con =DriverManager.getConnection("jdbc:mysql://localhost:3306/travelsite", "root", "#Neshanic2850");
			p = con.prepareStatement(
				"select customername name, Username, password from customer"
			); 
			rs=p.executeQuery();
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
	
	%>
	<br><% out.println(customerName + " brought in the most revenue at $" + max); %>
	<br><br><% out.println("Best selling ticket numbers: "); 
		for(int i=0; i<size; i++) {
			out.print(maxSold.get(i));
			if(i != size-1) out.println(", ");
		}
	%>
	
	<br><br>
	
	<table>
	<tr>    
		<td>Name</td>
		<td>Username </td>
		<td>Password </td>			
	</tr>
				<%
		while (rs.next()) { %>
			<tr>
				<td><%= rs.getString("name") %></td>    
				<td><form action=EditAccounts.jsp method=post>
						<input value=<% out.println(rs.getString("Username")); %> name=username value=<% out.println(rs.getString("Username")); %> readonly>
						<input type=text name=newUser>
						
						<input type=submit name=val value="Edit username">
				</td>
				<td>
						<input value=<% out.println(rs.getString("Password")); %> name=password value=<% out.println(rs.getString("Password")); %> readonly>
						<input type=text name=newPass>
						
						<input type=submit name=val value="Edit password">
				</td>
				</form>
		<% } %>
			</tr>
	</table>
	
	<br><br><form action=home.jsp method=post>
		<input type="submit" value="Log out">
	</form>
	
	<%		
		rs.close();
		p.close();
		con.close();
	%>
	
</body>
</html>