import 'package:flight_booking/mvc/model/Response/ticket_issue_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/Response/order_create_response.dart';
import 'FlightBookingPage.dart';

class TicketPage extends StatefulWidget {
  final TicketIssueResponse? ticketIssueResponse;
  final OrderCreateRS? orderCreateRS;

  const TicketPage(
      {super.key,
      required this.ticketIssueResponse,
      required this.orderCreateRS});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Status'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ticket Information Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.flight, size: 40, color: Colors.blue),
                              SizedBox(width: 10),
                              Text(
                                'Flight Booking',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('E-Ticket',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  'Ticket Number: ${widget.ticketIssueResponse!.ticket!.ticketNumber}',
                                  style: TextStyle(fontSize: 14)),
                              Text(
                                'Booking on - ${formatDate(widget.ticketIssueResponse!.ticket!.createdAt!)}',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.first.departure!.iataCode} ${widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.first.departure!.at.hour}:${widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.first.departure!.at.minute}',
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 8),
                              Text(
                                  '${formatDate1(widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.first.departure!.at.toString())}',
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 4),
                              Text(
                                  'Terminal ${widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.first.departure!.terminal}',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 8),
                              Text('3h 40m',
                                  style: TextStyle(color: Colors.grey)),
                              Icon(Icons.swap_horiz,
                                  size: 40, color: Colors.blue),
                              Text(
                                  '${widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.first.co2Emissions!.first.cabin}',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  '${widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.last.arrival!.iataCode} ${widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.last.arrival!.at.hour}:${widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.last.arrival!.at.minute}',
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 8),
                              Text(
                                  '${formatDate1(widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.last.arrival!.at.toString())}',
                                  style: TextStyle(color: Colors.grey)),
                              SizedBox(height: 4),
                              Text(
                                  'Terminal ${widget.orderCreateRS!.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.last.arrival!.terminal}',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.luggage, color: Colors.black),
                                  SizedBox(width: 05),
                                  Text('Baggage: '),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Cabin  to Airlines',

                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Check-in: 30 Kg',

                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Divider(),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Divider(),
                      SizedBox(height: 18,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Traveler Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                      SizedBox(height: 18,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Passenger Name:'),
                          Text('Mr. Shadul Islam'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Airline PNR:'),
                          Text('AY0926'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ticket Number:'),
                          Text('99994565444'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Travel Insurance:'),
                          Text('Not Confirmed'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Class | Cabin:'),
                          Text('V | Economy'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status:'),
                          Text('Confirm',
                              style: TextStyle(color: Colors.green)),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fare Summery',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Basic Fare:'),
                          Text('\$13000'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Taxes:'),
                          Text('\$2000'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Reschedule Charges:'),
                          Text('\$0'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('K3:'),
                          Text('\$0'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Coupon Offer:'),
                          Text('-\$500', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$14500',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.book), label: 'My Booking'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: 1,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlightBookingPage()),
              );
            }
          },
        ));

  }

  String formatDate(String dateTimeString) {
    try {
      // Parse the ISO 8601 date string
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('E, MMMM d, h:mm a').format(dateTime);
    } catch (e) {
      return dateTimeString; // Return original if parsing fails
    }
  }

  String formatDate1(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('E, d yyyy').format(dateTime);
    } catch (e) {
      return dateTimeString; // Return original if parsing fails
    }
  }
}
