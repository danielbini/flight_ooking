import 'package:flight_booking/mvc/view/HistoryPage.dart';
import 'package:flight_booking/mvc/view/RecentBookingPages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/Response/order_create_response.dart';
import 'FlightBookingPage.dart';

class BookingDetailPage extends StatefulWidget {
  final List<FlightOffers>? flightOffers;

  const BookingDetailPage({Key? key, required this.flightOffers})
      : super(key: key);

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  @override
  Widget build(BuildContext context) {
    var iternary = widget.flightOffers!.first.itineraries!;
    return Scaffold(
        appBar: AppBar(
          title: Text('Flight Details'),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flight Route and Stops
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [

                    Image.network(
                      'https://pics.avs.io/300/300/${iternary.first.segments!.first.carrierCode}.png',
                      width: 40, // Adjust size as needed
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        // Return an empty container if the image fails to load
                        return SizedBox(width: 24, height: 24);
                      },
                    ),
                    Text(
                      '  ${iternary.first.segments!.first.carrierCode}' ,
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 18,),
                    Text(
                      '  ${formatMainDate(iternary.first.segments!.first.departure!.at.toString())}',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   '  ${ formatMainDate(
                    //       widget.flight.itineraries.first.segments.first.departure
                    //           .at.toString())}',
                    //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    // ),
                    // Text(
                    //   '${widget.flight.itineraries.first.segments.length - 1} stop | ${formatDuration(widget.flight.itineraries.first.duration)} | Economy',
                    //   style: TextStyle(color: Colors.grey),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Divider(
                // This adds the separator line
                height: 1,
                thickness: 4,
                color: Colors.grey[300],
              ),
              SizedBox(height: 16),
              // Flight Segments
              Column(
                children: iternary.expand((itinerary) {
                  return itinerary.segments!.map((segment) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itinerary.segments!.first.departure!.iataCode,
                                  style: TextStyle(
                                      fontSize: 14,fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  '${formatDate(itinerary.segments!.first.departure!.at.toString())} ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${itinerary.segments!.first.departure!.at.hour}:${itinerary.segments!.first.departure!.at.minute.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(height: 35),

                                Container(
                                  height: 2,  // Thickness of the line
                                  width: 80,  // Width of the line (customize as needed)
                                  color: Colors.blue,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '${formatDuration(itinerary.segments!.first!.duration!)}',
                                  style: TextStyle(
                                      fontSize: 14),
                                ),
                                Text(
                                  '${itinerary.segments!.length - 1} ${itinerary.segments!.length == 1 ? 'Stop' : 'Stops'}',
                                  style: TextStyle(
                                      fontSize: 14),
                                ),

                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [
                                Text(
                                  itinerary
                                      .segments!.last.arrival!.iataCode,
                                  style: TextStyle(
                                    fontSize: 14, ),
                                ),
                                Text(
                                  '${formatDate(itinerary.segments!.first.arrival!.at.toString())} ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${itinerary.segments!.last.arrival!.at.hour}:${itinerary.segments!.last.arrival!.at.minute.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 18),
                      ],
                    );
                  });
                }).toList(),
              ),

              SizedBox(height: 10,),
              Divider(  // This adds the separator line
                height: 1,
                thickness: 1,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.all(05.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Flight Details",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timeline with icons
                        Column(
                          children: [
                            Text(
                              "${widget.flightOffers!.first.itineraries!.first.segments!.first.departure!.at.hour} :${widget.flightOffers!.first.itineraries!.first!.segments!.first.departure!.at.minute.toString().padLeft(2,'0')}",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            Text(
                              "${formatCardDate(widget.flightOffers!.first.itineraries!.first!.segments!.first.departure!.at.toString())}",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 80,
                              width: 2,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${formatDuration(widget.flightOffers!.first.itineraries!.first!.segments!.first.duration!)}",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 80,
                              width: 2,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 05),
                            Text(
                              "${widget.flightOffers!.first.itineraries!.first!.segments!.first.arrival!.at.hour} :${widget.flightOffers!.first.itineraries!.first!.segments!.first.arrival!.at.minute.toString().padLeft(2,'0')}",
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "${formatCardDate(widget.flightOffers!.first.itineraries!.first!.segments!.first.arrival!.at.toString())}",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        // Flight Details Card
                        Expanded(
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Departure Information
                                  Row(
                                    children: [
                                      Icon(Icons.flight_takeoff, color: Colors.blue),
                                      SizedBox(width: 10),
                                      Text(
                                        "${widget.flightOffers!.first.itineraries!.first.segments!.first.departure!.iataCode}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        "At terminal ${widget.flightOffers!.first.itineraries!.first.segments!.first.departure!.terminal}",
                                        style:
                                        TextStyle(fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  // Airline Information
                                  Row(
                                    children: [

                                      SizedBox(width: 05),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Image.network(
                                                'https://pics.avs.io/300/300/${widget.flightOffers!.first.itineraries!.first.segments!.first.carrierCode}.png',
                                                width: 30, // Adjust size as needed
                                                height: 30,
                                                errorBuilder: (context, error, stackTrace) {
                                                  // Return an empty container if the image fails to load
                                                  return SizedBox(width: 24, height: 24);
                                                },
                                              ),
                                              SizedBox(width: 05),

                                              Text(
                                                "${widget.flightOffers!.first.itineraries!.first.segments!.first.carrierCode}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),

                                          Text(
                                            "${widget.flightOffers!.first.itineraries!.first.segments!.first.carrierCode } ${widget.flightOffers!.first.itineraries!.first.segments!.first.number}",
                                            style: TextStyle(
                                                fontSize: 12, color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  // Flight Information
                                  Row(
                                    children: [
                                      Icon(Icons.luggage, color: Colors.blue),
                                      SizedBox(width: 05),
                                      Expanded(
                                        child: Text(
                                          "Baggage: 350LB/23KG  ${widget.flightOffers!.first.travelerPricings!.first.fareDetailsBySegment!.first.includedCheckedBags!.quantity}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 05),
                                  Row(
                                    children: [
                                      Icon(Icons.business_center, color: Colors.blue),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "Cabin Baggage: 22LB/12KG AND",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 05),
                                  Row(
                                    children: [
                                      Icon(Icons.chair, color: Colors.blue),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "Class: ${widget.flightOffers!.first.travelerPricings!.first.fareDetailsBySegment!.first.cabin}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 05),
                                  Row(
                                    children: [
                                      Icon(Icons.flight, color: Colors.blue),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "Flight Number: ${widget.flightOffers!.first.itineraries!.first.segments!.first.carrierCode } ${widget.flightOffers!.first.itineraries!.first.segments!.first.number}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 05),
                                  Row(
                                    children: [
                                      Icon(Icons.map, color: Colors.blue),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "Distance: 1166.77KM",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 05),
                                  Row(
                                    children: [
                                      Icon(Icons.account_balance, color: Colors.blue),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "Terminal: 2",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              Divider(  // This adds the separator line
                height: 1,
                thickness: 1,
                color: Colors.grey[300],
              ),
              SizedBox(height: 10),
              // Price and Book Button
              Row(
                children: [
                  Spacer(),
                  Text(
                    'Total Price: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' \$${widget.flightOffers!.first.travelerPricings!.first.price!.total}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blue),
                  ),
                  SizedBox(width: 40),

                ],
              ),
              // Price and Book Button
            ],
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
            }if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingPage()),
              );
            }
            if(index==2){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            }
          },
        ));
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 15,),
          Divider(),
        ],
      ),
    );
  }

  String formatDuration(String duration) {
    final regex = RegExp(r'PT(\d+H)?(\d+M)?');
    final match = regex.firstMatch(duration);

    int hours = 0;
    int minutes = 0;

    if (match != null) {
      if (match.group(1) != null) {
        hours = int.parse(match.group(1)!.replaceAll('H', ''));
      }
      if (match.group(2) != null) {
        minutes = int.parse(match.group(2)!.replaceAll('M', ''));
      }
    }

    return '$hours hrs $minutes mins';
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('E, d MMM').format(dateTime); // "Thu, 20 Mar"
  }

  String formatMainDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('EEEE, MMM d yyyy').format(dateTime);
  }
  String formatCardDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('MMM d').format(dateTime); // "Thu, 20 Mar"
  }
}
