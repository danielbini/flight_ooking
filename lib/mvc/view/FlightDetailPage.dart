

import 'package:flutter/material.dart';

import '../model/flight_search_response.dart';

class FlightDetailPage extends StatefulWidget {
  final Datum flight;

  const FlightDetailPage({Key? key, required this.flight}) : super(key: key);
  @override
  State<FlightDetailPage> createState() => _FlightDetailPageState();
}

class _FlightDetailPageState extends State<FlightDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Airline:${widget.flight.itineraries.first.segments.first.carrierCode} ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Price: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),



          ],
        ),
      ),
    );
  }
}
