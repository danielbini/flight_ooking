import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/offer_price_controller.dart';
import '../model/Response/flight_offer_response.dart';
import '../model/Response/flight_search_response.dart';
import 'AddPassengerDetail.dart';

class FlightDetailPage extends StatefulWidget {
  final Datum flight;
  final String opratingAirline;
  const FlightDetailPage({Key? key, required this.flight, required this.opratingAirline}) : super(key: key);

  @override
  State<FlightDetailPage> createState() => _FlightDetailPageState();
}

class _FlightDetailPageState extends State<FlightDetailPage> {
  bool isLoading = false;
  final ApiOfferController _apiController = ApiOfferController();
  OfferPriceResponse? offerPriceResponse;
  bool _showFareRules = false;

  void _toggleFareRules() {
    setState(() {
      _showFareRules = !_showFareRules;
    });
  }

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
            builder: (context) => PassengerDetailPage( offerPriceResponse: offerPriceResponse!),
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

    return '$hours h $minutes m';
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('E, d MMM').format(dateTime); // "Thu, 20 Mar"
  }
  String formatCardDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('MMM d').format(dateTime); // "Thu, 20 Mar"
  }
  String formatMainDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('EEEE, MMM d yyyy').format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight Details'),backgroundColor: Colors.blue,),
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.network(
                    'https://pics.avs.io/300/300/${widget.flight.itineraries.first.segments.first.carrierCode}.png',
                    width: 30, // Adjust size as needed
                    height: 30,
                    errorBuilder: (context, error, stackTrace) {
                      // Return an empty container if the image fails to load
                      return SizedBox(width: 24, height: 24);
                    },
                  ),
                  Expanded( // Add this
                    child:
                    Text(
                      '${widget.opratingAirline}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    formatMainDate(widget.flight.itineraries.first.segments.first.departure.at.toString()),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Divider(  // This adds the separator line
              height: 1,
              thickness: 4,
              color: Colors.grey[300],
            ),
            SizedBox(height: 16),
            // Flight Segments
            Column(
              children: widget.flight.itineraries.expand((itinerary) {
                return itinerary.segments.map((segment) {
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
                                itinerary.segments.first.departure
                                    .iataCode,
                                style: TextStyle(
                                    fontSize: 14,fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '${formatDate(itinerary.segments.first.departure.at.toString())} ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${itinerary.segments.first.departure.at.hour}:${itinerary.segments.first.departure.at.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(height: 20),

                              Container(
                                height: 2,  // Thickness of the line
                                width: 80,  // Width of the line (customize as needed)
                                color: Colors.blue,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${formatDuration(itinerary.duration)}',
                                style: TextStyle(
                                    fontSize: 14),
                              ),
                              Text(
                                '${itinerary.segments.length - 1} ${itinerary.segments.length == 1 ? 'Stop' : 'Stops'}',
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
                                    .segments.last.arrival.iataCode,
                                style: TextStyle(
                                  fontSize: 14, ),
                              ),
                              Text(
                                '${formatDate(itinerary.segments.first.arrival.at.toString())} ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${itinerary.segments.last.arrival.at.hour}:${itinerary.segments.last.arrival.at.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              // Text(
                              //   itinerary
                              //       .segments.last.arrival.iataCode,
                              //   style: TextStyle(
                              //     fontSize: 14, ),
                              // ),
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
            // Center(

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
                            "${widget.flight.itineraries!.first!.segments.first.departure.at.hour} :${widget.flight.itineraries!.first!.segments.first.departure.at.minute.toString().padLeft(2,'0')}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            "${formatCardDate(widget.flight.itineraries!.first!.segments.first.departure.at.toString())}",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 80,
                            width: 2,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${formatDuration(widget.flight.itineraries!.first!.segments.first.duration)}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 80,
                            width: 2,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 05),
                          Text(
                            "${widget.flight.itineraries!.first!.segments.first.arrival.at.hour} :${widget.flight.itineraries!.first!.segments.first.arrival.at.minute.toString().padLeft(2,'0')}",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${formatCardDate(widget.flight.itineraries!.first!.segments.first.arrival.at.toString())}",
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
                                      "${widget.flight.itineraries.first.segments.first.departure.iataCode}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Text(
                                      "At terminal ${widget.flight.itineraries.first.segments.first.departure.terminal}",
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
                                              'https://pics.avs.io/300/300/${widget.flight.itineraries.first.segments.first.carrierCode}.png',
                                              width: 40, // Adjust size as needed
                                              height: 40,
                                              errorBuilder: (context, error, stackTrace) {
                                                // Return an empty container if the image fails to load
                                                return SizedBox(width: 24, height: 24);
                                              },
                                            ),
                                            SizedBox(width: 05),

                                            Text(
                                              "${widget.opratingAirline}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),

                                        Text(
                                          "${widget.flight.itineraries.first.segments.first.carrierCode } ${widget.flight.itineraries.first.segments.first.number}",
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
                                        "Baggage: 350LB/23KG  ${widget.flight.travelerPricings.first.fareDetailsBySegment.first.includedCabinBags.quantity}",
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
                                        "Class: ${widget.flight.travelerPricings.first.fareDetailsBySegment.first.cabin}",
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
                                        "Flight Number: ${widget.flight.itineraries.first.segments.first.carrierCode } ${widget.flight.itineraries.first.segments.first.number}",
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
