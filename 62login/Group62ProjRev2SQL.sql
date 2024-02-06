Create database travelsite;
use travelsite;
CREATE TABLE Airline (
    AirlineID CHAR(2) PRIMARY KEY
);
CREATE TABLE Customer (
    SSN CHAR(11),
    CustomerName VARCHAR(125),
    Username VARCHAR(100) PRIMARY KEY,
    Password VARCHAR(100)
);
CREATE TABLE Aircraft (
    Seats INT,
    AirlineID CHAR(2),
    PRIMARY KEY (Seats , AirlineID),
    FOREIGN KEY (AirlineID)
        REFERENCES Airline (AirlineID)
);
CREATE TABLE Flight (
    OperationDays VARCHAR(100),
    DomesticOrInternational VARCHAR(13),
    Seats INT,
    AirlineID CHAR(2),
    FlightNumber INT,
    DepartureAirport VARCHAR(100),
    DestinationAirport VARCHAR(100),
    DepartureTime TIMESTAMP,
    ArrivalTime TIMESTAMP,
    PRIMARY KEY (FlightNumber , Seats , AirlineID),
    FOREIGN KEY (Seats , AirlineID)
        REFERENCES Aircraft (Seats , AirlineID)
);
CREATE TABLE Ticket (
    TicketNumber INT PRIMARY KEY,
    SeatNumber VARCHAR(5),
    class VARCHAR(9),
    TotalFare FLOAT,
    PurchaseDate TIMESTAMP,
    BookingFee FLOAT,
    Usernamee VARCHAR(100),
    RoundTripOrOneWay varchar(25),
    RemainingSeats int,
    FOREIGN KEY (Usernamee)
        REFERENCES Customer (Username)
);
CREATE TABLE FlightsForTicket (
    TicketNumber INT,
    Seats INT,
    AirlineID CHAR(2),
    FlightNumber INT,
    PRIMARY KEY (TicketNumber , Seats , AirlineID , FlightNumber),
    FOREIGN KEY (TicketNumber)
        REFERENCES Ticket (TicketNumber),
    FOREIGN KEY (Seats , AirlineID , FlightNumber)
        REFERENCES flight (Seats , AirlineID , FlightNumber)
);
CREATE TABLE TicketHistory (
    TicketNumber INT,
    Username VARCHAR(100),
    PRIMARY KEY (TicketNumber , Username),
    FOREIGN KEY (TicketNumber)
        REFERENCES ticket (TicketNumber),
    FOREIGN KEY (Username)
        REFERENCES customer (Username)
);
CREATE TABLE CustomersForTicket (
    Username VARCHAR(100),
    TicketNumber INT,
    PRIMARY KEY (Username , TicketNumber),
    FOREIGN KEY (Username)
        REFERENCES customer (Username),
    FOREIGN KEY (TicketNumber)
        REFERENCES ticket (TicketNumber)
);
CREATE TABLE WaitingListForTicket (
    Username VARCHAR(100),
    TicketNumber INT,
    PRIMARY KEY (Username , TicketNumber),
    FOREIGN KEY (Username)
        REFERENCES customer (Username),
    FOREIGN KEY (TicketNumber)
        REFERENCES ticket (TicketNumber)
);

CREATE TABLE Admin (
    Username VARCHAR(100) PRIMARY KEY,
    Password VARCHAR(100)
);

insert into customer value ("64537846271", "Bob Fitzgerald", "bobfitz1966", "password1234");
insert into customer value ("11122233344", "Mary Smith", "msmith221", "password55");
insert into customer value ("64646464646", "Benjamin O'Connor", "bennyoconnor74", "password777");
insert into customer value ("07968574635", "Joe Schmidt", "joeyschmidt26", "password123123");
insert into customer value ("33322244455", "Alice Andrews", "allieandrews22", "password5432");

insert into Airline values ("AA"), ("SA"), ("DA"), ("FA"), ("JA");
insert into Aircraft values (150, "AA"), (200, "AA"), (175, "SA"), (190, "SA"), (140, "DA"), (130, "DA"), (155, "FA"), (145, "FA"), (135, "JA"), (150, "JA");

insert into Flight value ("Monday, Wednesday", "Domestic", 150, "AA", 1, "Newark", "Detroit", '2023-11-22 05:30:00', '2023-11-22 20:10:00');
insert into Flight value ("Monday, Wednesday", "Domestic", 200, "AA", 2, "Detroit", "Los Angeles", '2023-11-22 21:00:00', '2023-11-23 07:15:00');
insert into ticket value(11, "23", "Economy", 140.50, null, 20.00, null, "OneWay", 2);
insert into FlightsForTicket value(11, 150, "AA", 1);
insert into FlightsForTicket value(11, 200, "AA", 2);

insert into Flight value ("Tuesday, Thursday", "International", 130, "DA", 3, "Orlando", "Heathrow", '2023-12-5 09:30:00', '2023-12-5 22:20:00');
insert into Flight value ("Tuesday, Thursday", "International", 140, "DA", 4, "Heathrow", "Orlando", '2023-12-12 07:30:00', '2023-12-12 20:20:00');
insert into ticket value (12, "44", "Business", 155.25, null, 18.95, null, "RoundTrip", 5);
insert into FlightsForTicket value(12, 130, "DA", 3);
insert into FlightsForTicket value(12, 140, "DA", 4);

insert into flight value ("Monday, Wednesday, Friday", "Domestic", 145, "FA", 5, "San Francisco", "Seattle", "2023-11-28 08:30:00", "2023-11-28 14:30:00");
insert into ticket value (13, 20, "First", 85.00, null, 13.30, null, "OneWay", 3);
insert into flightsforticket value (13, 145, "FA", 5);

insert into admin value("admin", "admin");



#alter table ticket add RemainingSeats int;
#update ticket set RemainingSeats = 2 where TicketNumber = 11;
#update ticket set RemainingSeats = 5 where TicketNumber = 12;
#update ticket set RemainingSeats = 3 where TicketNumber = 13;



#Alter table customer add primary key (Username);
#Alter table customer drop constraint SSN;
#select count(*) from CustomersForTicket where TicketNumber = 11;Cus
#select * from customersforticket;

/*create database Travel;


CREATE TABLE Airline (
    AirlineID CHAR(2) PRIMARY KEY
);
CREATE TABLE Customer (
    SSN CHAR(11) PRIMARY KEY,
    CustomerName VARCHAR(125),
    Username VARCHAR(100),
    Password VARCHAR(100)
);
CREATE TABLE Aircraft (
    Seats INT,
    AirlineID CHAR(2),
    PRIMARY KEY (Seats , AirlineID),
    FOREIGN KEY (AirlineID)
        REFERENCES Airline (AirlineID)
);
CREATE TABLE Flight (
    OperationDays VARCHAR(100),
    DomesticOrInternational VARCHAR(13),
    Seats INT,
    AirlineID CHAR(2),
    FlightNumber INT,
    DepartureAirport VARCHAR(100),
    DestinationAirport VARCHAR(100),
    DepartureTime TIMESTAMP,
    ArrivalTime TIMESTAMP,
    PRIMARY KEY (FlightNumber , Seats , AirlineID),
    FOREIGN KEY (Seats , AirlineID)
        REFERENCES Aircraft (Seats , AirlineID)
);
CREATE TABLE Ticket (
    TicketNumber INT,
    SeatNumber VARCHAR(5),
    class VARCHAR(9),
    TotalFare FLOAT,
    PurchaseDate TIMESTAMP,
    BookingFee FLOAT,
    SSN CHAR(11),
    RoundTripOrOneWay varchar(25);
    PRIMARY KEY (TicketNumber),
    FOREIGN KEY (SSN)
        REFERENCES Customer (SSN)
);

CREATE TABLE FlightsForTicket (
    TicketNumber INT,
    Seats INT,
    AirlineID CHAR(2),
    FlightNumber INT,
    PRIMARY KEY (TicketNumber , Seats , AirlineID , FlightNumber),
    FOREIGN KEY (TicketNumber)
        REFERENCES Ticket (TicketNumber),
    FOREIGN KEY (Seats , AirlineID , FlightNumber)
        REFERENCES flight (Seats , AirlineID , FlightNumber)
);
*/

/*select * from Airline;
select * from Customer;
select * from Aircraft;
select * from Flight;
select * from ticket;
select * from FlightsForTicket;*/




#select * from FlightsForTicket;
#select * from ticket;
#on f.Seats=ft.Seats AND f.AirlineID = ft.AirlineID AND f.FlightNumber = ft.FlightNumber;

#select * from ticket;
#update ticket set RoundTripOrOneWay = "OneWay" where TicketNumber = 11;
#update ticket set RoundTripOrOneWay = "RoundTrip" where TicketNumber = 12;
#select * from ticket where TicketNumber in
#(select TicketNumer from ticket joi
#select * from ticket t join flightsforticket ft on t.TicketNumber=ft.TicketNumber join flight f on f.FlightNumber = ft.FlightNumber;
#where DepartureTime - interval '1' day like '%2023-12-04%';
#select * from ticket t join flightsforticket ft on t.TicketNumber=ft.TicketNumber join flight f on f.FlightNumber = ft.FlightNumber where DepartureTime like '%2023-12-05%';
#select * from ticket t join flightsforticket ft on t.TicketNumber=ft.TicketNumber join flight f on f.FlightNumber = ft.FlightNumber;
#Select * from flight;
#SELECT count(*) quantity, TicketNumber from rt group by TicketNumber;
#SELECT t.* FROM rt t, stopquantity sq where sq.TicketNumber=t.TicketNumber AND sq.quantity = 2
#SELECT * FROM rt where (AirlineID LIKE "%AA%" OR "%DA%" OR "%FA%" OR "%JA%" OR "%SA%");
#Select * from rt;
#SELECT * FROM rt where (AirlineID LIKE "%DA%" OR AirlineID LIke "%AA%");
#SELECT * FROM rt where (AirlineID LIKE "%AA%" OR "%ZE%");
#select min(DepartureTime), TicketNumber from rt group by TicketNumber;
#select * from rt
#order by TotalFare DESC;
#select * from rt;
#select * from rt
#order by extract(hour_minute from (select dt from (select max(ArrivalTime) dt, TicketNumber from rt group by TicketNumber) a where a.TicketNumber = rt.TicketNumber)) DESC;
#order by extract(hour_minute from (select dt from (select min(DepartureTime) dt, TicketNumber from rt group by TicketNumber) a where a.TicketNumber = rt.TicketNumber));

#order by ArrivalTime-DepartureTime;

#select * from flight;
#select * from ticket;
##select * from flightsforticket;
#select * from Aircraft;
#select * from rt group by (select duration from(select sum(ArrivalTime-DepartureTime) duration, TicketNumber from rt group by TicketNumber) b where b.TicketNumber = rt.TicketNumber);
#select duration from(select sum(ArrivalTime-DepartureTime) duration, TicketNumber from rt group by TicketNumber) b where b.TicketNumber = rt.TicketNumber;
#select sum(ArrivalTime-DepartureTime) duration, TicketNumber from rt group by TicketNumber order by duration;

#select rt.* from rt, (select sum(ArrivalTime-DepartureTime) duration, TicketNumber from rt) a where a.TicketNumber = rt.TicketNumber order by duration );

#select sum(ArrivalTime)-sum(DepartureTime) duration, TicketNumber from rt group by TicketNumber order by duration;
#select sum(timestampdiff(SECOND, DepartureTime, ArrivalTime)) duration, TicketNumber from rt group by TicketNumber order by duration;

#SELECT * FROM rt order by (select duration from (select sum(timestampdiff(SECOND, DepartureTime, ArrivalTime)) duration, TicketNumber from rt group by TicketNumber) a where a.TicketNumber = rt.TicketNumber);
#select sum(ArrivalTime-DepartureTime) duration, TicketNumber from rt group by TicketNumber order by duration;
/*select * from customer;
select * from customersforticket;
select * from waitinglistforticket;
select * from ticket;
select * from flight;
select * from flightsforticket;
#select TicketNumber from WaitingListForTicket where Username = "bennyoconnor74";
select RemainingSeats from ticket where TicketNumber = 11;
select count(*) from CustomersForTicket where TicketNumber = 11;
#delete from waitinglistforticket where TicketNumber = 11;
#delete from customersforticket where TicketNumber = 11;
#delete from WaitingListForTicket where Username = "A" AND TicketNumber = 11;
Select t.* FROM ticket t join FlightsForTicket ft USING (TicketNumber) join flight f using (Seats, AirlineID, FlightNumber);
SELECT t.* FROM ticket t JOIN FlightsForTicket ft USING (TicketNumber) JOIN flight f USING (Seats , AirlineID , FlightNumber) WHERE ft.TicketNumber = 11 && f.DepartureTime IN (select first from (SELECT  MIN(DepartureTime) first, FlightNumber
        FROM flight GROUP BY FlightNumber) a )&& DATE(f.DepartureTime) < '2023-11-28';*/