import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/offer_price_controller.dart';
import '../model/Response/flight_offer_response.dart';
import '../model/flight_search_response.dart';
import 'AddPassengerDetail.dart';

class FlightDetailPage extends StatefulWidget {
  final Datum flight;

  const FlightDetailPage({Key? key, required this.flight}) : super(key: key);

  @override
  State<FlightDetailPage> createState() => _FlightDetailPageState();
}

class _FlightDetailPageState extends State<FlightDetailPage> {
  bool isLoading = false;
  final ApiOfferController _apiController = ApiOfferController();
  OfferPriceResponse? offerPriceResponse;


  Future<void> selectFlight(Datum flight) async{
    setState(() {
      isLoading = true;
    });
    try {
      final result = await _apiController.SelectOffer(
        flight,
      );
      setState(() {
        offerPriceResponse = result;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        offerPriceResponse = null; // Assign a default value
      });
    }
    finally {
      setState(() {
        isLoading = false;
      });
      if (offerPriceResponse != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PassengerDetailPage(),
          ),
        );
      } else {
        print('Flights data is not available.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load flight data.')),
        );
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flight Route and Stops
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    '${widget.flight.itineraries.first.segments.first.departure.iataCode} - ${widget.flight.itineraries.first.segments.last.arrival.iataCode}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.flight.itineraries.first.segments.length - 1} stop | ${formatDuration(widget.flight.itineraries.first.duration)} | Economy',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Flight Segments
            Column(
              children: widget.flight.itineraries.expand((itinerary) {
                return itinerary.segments.map((segment) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.flight, color: Colors.blue),
                        title: Text(
                          '${segment.departure.at.hour}:${segment.departure.at.minute.toString().padLeft(2, '0')} - ${segment.departure.iataCode}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${formatDate(segment.departure.at.toString())} ',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Text(
                                '${segment.arrival.at.hour}:${segment.arrival.at.minute.toString().padLeft(2, '0')} - ${segment.arrival.iataCode}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                });
              }).toList(),
            ),
            SizedBox(height: 16),
            // Price and Book Button
            Row(
              children: [
                Spacer(),
                Text(
                  'Total Price: \$${widget.flight.price.total}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 40),
                ElevatedButton(
                  onPressed: isLoading ? null :() async =>await selectFlight(widget.flight),
                  child: Text('Proceed to Book'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
