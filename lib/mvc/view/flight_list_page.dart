import 'package:flight_booking/mvc/model/Response/flight_search_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'FlightDetailPage.dart';

class FlightListPage extends StatefulWidget {
  final SearchResponse flightData;

  const FlightListPage({Key? key, required this.flightData}) : super(key: key);

  @override
  State<FlightListPage> createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {


  String getAirlineName(String carrierCode) {
    try {
      return widget.flightData.dictionaries.carriers[carrierCode] ?? '';
    } catch (e) {
      return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight List'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${widget?.flightData?.data?.first?.itineraries?.first?.segments?.first?.departure.iataCode} ',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.airplane_ticket_outlined,size: 55, color: Colors.white),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ' ${widget?.flightData?.data?.first?.itineraries?.first?.segments?.last?.arrival.iataCode}',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Departure',
                            style: TextStyle(color: Colors.white)),
                        Text(
                            '${widget?.flightData?.data?.first?.itineraries?.first?.segments?.first?.departure.at.hour}:${widget?.flightData?.data?.first?.itineraries?.first?.segments?.first?.departure.at.minute.toString().padLeft(2, '0')}', style: TextStyle(color: Colors.white)),
                        Text(DateFormat('MMM d, y').format(widget!.flightData!.data!.first!.itineraries!.first!.segments!.first!.departure!.at), style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 2,  // Thickness of the line
                          width: 40,  // Width of the line (customize as needed)
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Text(
                            '${widget.flightData.data!.first.itineraries!.first.segments!.length- 1} ${widget?.flightData?.data?.first?.itineraries?.first?.segments!.length == 1 ? 'Stop' : 'Stops'}', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Arrival',
                            style: TextStyle(color: Colors.white)),
                        Text(
                            '${widget!.flightData!.data!.first!.itineraries!.first!.segments!.last!.arrival.at.hour}:${widget!.flightData!.data!.first!.itineraries!.first!.segments!.last!.arrival.at.minute.toString().padLeft(2, '0')}', style: TextStyle(color: Colors.white)),
                        Text(DateFormat('MMM d, y').format(widget!.flightData!.data!.first!.itineraries!.first!.segments!.last!.arrival.at), style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: FlightCard(flight: widget.flightData.data, getAirlineName: getAirlineName),
          ),),
        ],
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  final List<Datum> flight;
  final String Function(String) getAirlineName;
  const FlightCard({Key? key, required this.flight, required this.getAirlineName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (flight.isEmpty) return Center(child: Text('No flights available'));

    // Get common data from first flight (assuming same route for all flights)
    final firstItinerary = flight.first.itineraries.first;
    final departure = firstItinerary.segments.first.departure;
    final arrival = firstItinerary.segments.last.arrival;

    return Column(
      children: [
        // Common blue header

        SizedBox(height: 20),
        ...flight
            .map((flight) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlightDetailPage(flight: flight,opratingAirline :getAirlineName(flight.itineraries.first.segments.first
                            .carrierCode)),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    margin: EdgeInsets.only(bottom: 30.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                'https://pics.avs.io/300/300/${flight.itineraries.first.segments.first.carrierCode}.png',
                                width: 30, // Adjust size as needed
                                height: 30,
                                errorBuilder: (context, error, stackTrace) {
                                  // Return an empty container if the image fails to load
                                  return SizedBox(width: 24, height: 24);
                                },
                              ),
                              Text(getAirlineName(flight.itineraries.first.segments.first
                                  .carrierCode)
                               ,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.normal),
                              ),
                               // Add some spacing between text and logo

                              Text(
                                '${flight.price.total} ${flight.price.currency}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blue),
                              ),
                            ],
                          ),
                          SizedBox(height: 08),

                          Divider(  // This adds the separator line
                            height: 1,
                            thickness: 4,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 12),
                          ...flight.itineraries.map((itinerary) {
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
                                        Container(
                                          height: 2,  // Thickness of the line
                                          width: 80,  // Width of the line (customize as needed)
                                          color: Colors.blue,
                                        ),
                                        SizedBox(height: 8),  // Optional spacing
                                        Text(
                                          '${formatDuration(itinerary.duration)}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          '${itinerary.segments.length - 1} ${itinerary.segments.length == 1 ? 'Stop' : 'Stops'}',
                                          style: TextStyle(fontSize: 14),
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

                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 18),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      ],
    );
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('MMM d').format(dateTime); // "Thu, 20 Mar"
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
}
