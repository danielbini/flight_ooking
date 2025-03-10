import 'package:flight_booking/mvc/model/flight_search_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FlightDetailPage.dart';

class FlightListPage extends StatefulWidget {
  final SearchResponse flightData;

  const FlightListPage({Key? key, required this.flightData}) : super(key: key);

  @override
  State<FlightListPage> createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight List'),
      ),
      body:  SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: FlightCard(flight: widget.flightData.data),
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  final List<Datum> flight;

  const FlightCard({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: flight.map((flight) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlightDetailPage(flight:flight),
              ),
            );
          },
          child: Card(
            elevation: 4.0,
            margin: EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display carrier code and price per itinerary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        flight.itineraries.first.segments.first.carrierCode,
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Price: ${flight.price.total} ${flight.price.currency}',
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  Column(
                    children: flight.itineraries.map((itinerary) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${itinerary.segments.first.departure.at.hour}:${itinerary.segments.first.departure.at.minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    itinerary.segments.first.departure.iataCode,
                                    style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.airplane_ticket,
                                    size: 32,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${itinerary.segments.length - 1} Stops',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${itinerary.segments.last.arrival.at.hour}:${itinerary.segments.last.arrival.at.minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    itinerary.segments.last.arrival.iataCode,
                                    style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class FlightHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dhaka - New Delhi',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('Thu 6 Jan | 1 Adult, 0 Child, 0 Infant'),
        SizedBox(height: 16),
        Text(
          'Flight to New Delhi',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text('Filter'),
            SizedBox(width: 16),
            Text('Non Stop'),
            SizedBox(width: 16),
            Text('1 Stop'),
          ],
        ),
        Divider(),
      ],
    );
  }
}
