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
			PreparedStatement p0 = con.prepareStatement("drop table if exists rt");
			p0.executeUpdate();
			PreparedStatement pa = con.prepareStatement("drop table if exists rt2");
			pa.executeUpdate();
			PreparedStatement p1=con.prepareStatement("Create table rt select t.TicketNumber as TicketNumber, t.SeatNumber, t.class, t.TotalFare, t.BookingFee, t.RoundTripOrOneWay, ft.TicketNumber as TicketNum, ft.Seats as Seatsft, ft.AirlineID as AirlineIDft, ft.FlightNumber as FlightNumberft, f.OperationDays, f.DomesticOrInternational, f.Seats as Seats, f.AirlineID as AirlineID, f.FlightNumber as FlightNumber, f.DepartureAirport, f.DestinationAirport, f.DepartureTime, f.ArrivalTime from ticket t join flightsforticket ft on t.TicketNumber=ft.TicketNumber join flight f on f.FlightNumber = ft.FlightNumber where t.TicketNumber in (Select TicketNumber from CustomersForTicket where Username = ?) ");
			p1.setString(1, un);
			p1.executeUpdate();
			if (!(date==null) && !(tense==null) && tense.equals("past")){
				PreparedStatement p2=con.prepareStatement("Create table rt2 SELECT * FROM rt where DATE(DepartureTime)< ?");
				p2.setString(1, date);
				p2.executeUpdate();
				PreparedStatement p3=con.prepareStatement("Drop table rt");
				p3.executeUpdate();
				PreparedStatement p4=con.prepareStatement("alter table rt2 rename to rt");
				p4.executeUpdate();	
			}
			if (!(date==null) && !(tense==null) && tense.equals("future")){
				PreparedStatement p2=con.prepareStatement("Create table rt2 SELECT * FROM rt where DATE(DepartureTime)> ?");
				p2.setString(1, date);
				p2.executeUpdate();
				PreparedStatement p3=con.prepareStatement("Drop table rt");
				p3.executeUpdate();
				PreparedStatement p4=con.prepareStatement("alter table rt2 rename to rt");
				p4.executeUpdate();	
			}
			PreparedStatement pfinal = con.prepareStatement("Select * from rt group by TicketNumber");
			ResultSet rs=pfinal.executeQuery();
			%>
			
			<br>Back to full reservaiton list<br>
			<form action=CustomerReservations.jsp method=post>
			<input type=submit value=Back>
			</form><br>
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

						while (rs.next()) { %>
						<% String t = rs.getString("TicketNumber"); %>
						<tr>
							
							<td><form action=Buy.jsp method=post>
							<input value=<% out.println(t); %> name=DeleteTicketNumber>
							<input type=submit value=Delete>
							</form></td>
							
							<td><%= rs.getString("TicketNumber") %></td>    
							<td><%= rs.getString("SeatNumber") %></td>
							<td><%= rs.getString("Class") %></td>
							<td><%= rs.getString("TotalFare") %></td>
							<td><%= rs.getString("BookingFee") %></td>
							<% 
							//String flightsforticket = "SELECT ft.Seats, ft.AirlineID, ft.FlightNumber FROM FlightsForTicket ft, Ticket t WHERE ft.TicketNumber = t.TicketNumber"; 
							//ResultSet flightset = stmt.executeQuery(flightsforticket);
							//String fftable = "Select f.DepartureAirport, f.DestinationAirport, f.DepartureTime FROM flight f join FlightsForTicket ft USING (Seats, AirlineID, FlightNumber) WHERE ft.TicketNumber = ?";
							
							//PreparedStatement p=con.prepareStatement("Select f.DepartureAirport, f.DestinationAirport, f.DepartureTime FROM flight f join FlightsForTicket ft USING (Seats, AirlineID, FlightNumber) WHERE ft.TicketNumber = ?");
							PreparedStatement p=con.prepareStatement("Select f.* FROM flight f join FlightsForTicket ft USING (Seats, AirlineID, FlightNumber) WHERE ft.TicketNumber = ?");
							String tn = rs.getString("TicketNumber");
							p.setString(1, tn);
							ResultSet flighttable=p.executeQuery();
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
						</tr>

		</table>
				<%
				rs.close();
				con.close();
					
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				} 
				%>
		</body>
		</html>

