<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<% try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/travelsite", "root", "#Neshanic2850");
			String un = (String)session.getAttribute("user");
			String date = request.getParameter("date");
			String tense = request.getParameter("tense");
			PreparedStatement p=con.prepareStatement("select TicketNumber from CustomersForTicket where Username = ?");
			p.setString(1, un);
			ResultSet rs0 = p.executeQuery();
			out.println("Filter past and future reservations: ");
			%>
			<form action=ReservationsFilter.jsp method=post>
			<br>Today's date: <input type=date name=date>
			<br><br>Past reservations: <input type=radio name=tense value=past>
			<br><br>Future reservations: <input type=radio name=tense value=future>
			<br><br><input type=submit value=Filter><br><br>
</form>
			<table>
					<tr>    
						<td>Cancel </td>
						<td>Ticket Number </td>
						<td>Seat Number </td>
						<td>Class </td>
						<td>Total Fare </td>
						<td>Booking Fee </td>
						<td>Departure Airport </td>
						<td>Destination Airport </td>
						<td>Departure Time </td>
						<td>Arrival Time </td>
						<td>Airline </td>
						<td>Operation Days </td>
						<td>Domestic or International </td>
						<td>Seats </td>
					</tr>
						<%

						while (rs0.next()) { %>
							<% String t = rs0.getString("TicketNumber"); 
							ResultSet rs;
							if(!(date==null) && !(tense==null) && tense.equals("past")){
								//PreparedStatement pReal=con.prepareStatement("Select t.* FROM ticket t join FlightsForTicket ft USING (TicketNumber) join flight f using (Seats, AirlineID, FlightNumber) WHERE ft.TicketNumber = ? && f.DepartureTime in (select first from (select min(DepartureTime) first, FlightNumber from flight group by FlightNumber) a ) && DATE(f.DepartureTime) < ?");
								//PreparedStatement pReal=con.prepareStatement("Select t.* FROM ticket t join FlightsForTicket ft USING (TicketNumber) join flight f using (Seats, AirlineID, FlightNumber) WHERE ft.TicketNumber = ? && DATE(f.DepartureTime) < ?");
								PreparedStatement pReal=con.prepareStatement("SELECT t.* FROM ticket t JOIN FlightsForTicket ft USING (TicketNumber) JOIN flight f USING (Seats , AirlineID , FlightNumber) WHERE ft.TicketNumber = ? && f.DepartureTime IN (select first from (SELECT  MIN(DepartureTime) first, FlightNumber FROM flight GROUP BY FlightNumber) a ) && DATE(f.DepartureTime) < ?");
								pReal.setString(1, t);
								pReal.setString(2, date);
								rs = pReal.executeQuery();
							}
							if(!(date==null) && !(tense==null) && tense.equals("future")){
								PreparedStatement pReal=con.prepareStatement("select * from ticket where TicketNumber = ?");
								pReal.setString(1, t);
								rs = pReal.executeQuery();
							}
							else{
								PreparedStatement pReal=con.prepareStatement("select * from ticket where TicketNumber = ?");
								pReal.setString(1, t);
								rs = pReal.executeQuery();
							}
							
							
							while(rs.next()){
								
							%>
							
									<tr>
										<% if (rs.getString("Class").equals("Economy")){
											%> <td>Economy: Can't cancel</td> <%
										}
										else{
										%>
											<td><form action=Buy.jsp method=post>
											<input value=<% out.println(t); %> name=DeleteTicketNumber>
											<input type=submit value=Delete>
											</form></td>
										<% } %>
										
										<td><%= rs.getString("TicketNumber") %></td>    
										<td><%= rs.getString("SeatNumber") %></td>
										<td><%= rs.getString("Class") %></td>
										<td><%= rs.getString("TotalFare") %></td>
										<td><%= rs.getString("BookingFee") %></td>
									<% 
									
										PreparedStatement p1=con.prepareStatement("Select f.* FROM flight f join FlightsForTicket ft USING (Seats, AirlineID, FlightNumber) WHERE ft.TicketNumber = ?");
										String tn = rs.getString("TicketNumber");
										p1.setString(1, tn);
										ResultSet flighttable=p1.executeQuery();
										while(flighttable.next()){ %>
											<td><%= flighttable.getString("DepartureAirport") %></td>
											<td><%= flighttable.getString("DestinationAirport") %></td>
											<td><%= flighttable.getString("DepartureTime") %>
											<td><%= flighttable.getString("ArrivalTime") %>
											<td><%= flighttable.getString("AirlineID") %>
											<td><%= flighttable.getString("OperationDays") %>
											<td><%= flighttable.getString("DomesticOrInternational") %>
											<td><%= flighttable.getString("Seats") %></td> <tr><td><td><td><td><td><td>
										<% } %>
								<% } %>
							<% } %>
							</tr>

			</table>
			
		<%
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		
		%>
</body>
</html>


