import 'package:flight_booking/mvc/model/flight_search_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: ListView.builder(
          itemCount: widget.flightData.data.length,
          itemBuilder: (context, index) {
            final flight = widget.flightData.data[index];

            return FlightCard(flight: flight);
          }),
    );
  }
}

class FlightCard extends StatelessWidget {
  final Datum flight;

  const FlightCard({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${flight.itineraries.first.segments.first.carrierCode}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Price: ${flight.price.total} ${flight.price.currency}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.swap_horiz),
                SizedBox(width: 8),
                Text(
                  '${flight.itineraries.first.duration} ${flight.itineraries
                      .first.segments.first.numberOfStops} Stops',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${flight.itineraries.first.segments.first.departure.at
                          .hour}:${flight.itineraries.first.segments.first
                          .departure.at.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      flight.itineraries.first.segments.first.departure
                          .iataCode, // Departure airport code
                      style: TextStyle(fontSize: 16, color: Colors.grey),
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
                    Text(
                      '${flight.itineraries.first.segments.length - 1} Stops',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${flight.itineraries.first.segments.first.arrival.at
                          .hour}:${flight.itineraries.first.segments.first.arrival
                          .at.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      flight.itineraries.first.segments.first.arrival.iataCode, // Arrival airport code
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                // Centered icon


                // Right-aligned arrival time

              ],
            ),

          ],
        ),
      ),
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
