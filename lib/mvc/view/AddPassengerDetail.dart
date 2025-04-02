import 'package:flight_booking/mvc/model/Response/order_create_response.dart';
import 'package:flight_booking/mvc/view/paymentPage.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking/mvc/model/Response/flight_offer_response.dart'
    as request;
import 'package:intl/intl.dart';
import '../controller/order_create_controller.dart';
import '../model/Response/flight_offer_response.dart';

class PassengerDetailPage extends StatefulWidget {
  final OfferPriceResponse? offerPriceResponse;

  const PassengerDetailPage({Key? key, required this.offerPriceResponse})
      : super(key: key);

  @override
  _PassengerDetailPageState createState() => _PassengerDetailPageState();
}

class _PassengerDetailPageState extends State<PassengerDetailPage> {
  final _formKey = GlobalKey<FormState>();
  OrderCreateRS? orderCreateRS;
  bool isLoading = false;
  bool _showFlightDetails = false;
  final ApiOrderCreateController _Apicontroller = ApiOrderCreateController();
  List<Map<String, dynamic>> _passengerDetails = [];

  @override
  void initState() {
    super.initState();

    if (widget.offerPriceResponse != null &&
        widget.offerPriceResponse!.data != null &&
        widget.offerPriceResponse!.data?.flightOffers != null &&
        widget.offerPriceResponse!.data!.flightOffers!.isNotEmpty) {
      _passengerDetails =
          widget.offerPriceResponse!.data!.flightOffers!.first.travelerPricings
                  ?.map((traveler) => {
                        'firstName': '',
                        'lastName': '',
                        'email': '',
                        'countryCode': '',
                        'contactNumber': '',
                        'dateOfBirth': '',
                        'gender': null,
                      })
                  .toList() ??
              [];
    }
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _passengerDetails[index]['dateOfBirth'] =
            picked.toIso8601String().split('T')[0];
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        final result = await _Apicontroller.OrderCreate(
            widget.offerPriceResponse!, _passengerDetails);
        setState(() {
          orderCreateRS = result;
        });
      } catch (error) {
        setState(() {
          orderCreateRS = null; // Assign a default value
        });
      } finally {
        setState(() {
          isLoading = false;
        });
        if (orderCreateRS != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentPage(orderCreateRS: orderCreateRS!),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passenger Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (widget.offerPriceResponse != null &&
                  widget.offerPriceResponse!.data != null &&
                  widget.offerPriceResponse!.data!.flightOffers != null &&
                  widget.offerPriceResponse!.data!.flightOffers!.isNotEmpty)
                ...widget.offerPriceResponse!.data!.flightOffers!.first
                        .travelerPricings
                        ?.asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final traveler = entry.value;
                      return _buildPassengerForm(index, traveler);
                    }).toList() ??
                    [],
              SizedBox(height: 24),
              if(!_showFlightDetails)
              ElevatedButton(
                onPressed: isLoading  ? null : _submitForm,
                child: Text('Submit All'),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPassengerForm(int index, request.TravelerPricings traveler) {
    var itineraries =
        widget.offerPriceResponse!.data!.flightOffers!.first.itineraries;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _showFlightDetails = false; // Toggle visibility
                });
              },
              child: Text(
                'Passenger ${index + 1} (${traveler.travelerType})',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _showFlightDetails = true; // Toggle visibility
                });
              },
              child: Text(
                'Flight Details',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        if (_showFlightDetails) // Show flight details when toggled
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Card(
              elevation: 2,
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: itineraries!.expand(
                    (itinerary) {
                      return itinerary.segments!.map(
                        (segment) {
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
                                       segment.departure!.iataCode!,
                                        style: TextStyle(
                                            fontSize: 18,fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 05),

                                      Text(
                                        '${formatDate(segment.departure!.at.toString())} ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 05),

                                      Text(
                                        '${formatTimeFromISOString(segment.departure!.at!)}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 30),

                                      Container(
                                        height: 2,  // Thickness of the line
                                        width: 80,  // Width of the line (customize as needed)
                                        color: Colors.blue,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '${formatDuration(segment.duration!)}',
                                        style: TextStyle(
                                            fontSize: 14),
                                      ),
                                      Text(
                                        "${segment.carrierCode } ${segment.number}",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),

                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        segment.arrival!.iataCode!,
                                        style: TextStyle(
                                          fontSize: 18,fontWeight: FontWeight.bold ),
                                      ),
                                      SizedBox(height: 05),

                                      Text(
                                        '${formatDate(segment.arrival!.at.toString())} ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 05),

                                      Text(
                                        '${formatTimeFromISOString(segment.arrival!.at!)}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 18),
                            ],
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        if (_showFlightDetails)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: SizedBox(
              width: double.infinity,
              height: 100,
              child: Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Add padding inside the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                    children: [
                      SizedBox(height: 10), // Push content down
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Total Price: ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' ${widget.offerPriceResponse!.data!.flightOffers!.first.price!.currency} ${widget.offerPriceResponse!.data!.flightOffers!.first.price!.total}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        if (!_showFlightDetails)
          Card(
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Gender',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGenderButton(index, 'Mr.'),
                      _buildGenderButton(index, 'Mrs.'),
                      _buildGenderButton(index, 'Miss.'),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'First & Middle Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _passengerDetails[index]['firstName'] = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first and middle name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _passengerDetails[index]['lastName'] = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  if (index == 0) ...[
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _passengerDetails[index]['email'] = value.trim();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        // Country Code Dropdown
                        Container(
                          width: 100, // Adjust width as needed
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Code',
                            ),
                            value: _passengerDetails[index]['countryCode'] !=
                                        null &&
                                    [
                                      '251',
                                      '44',
                                      '91',
                                      '61',
                                      '81',
                                      '49',
                                      '33'
                                    ].contains(
                                        _passengerDetails[index]['countryCode'])
                                ? _passengerDetails[index]['countryCode']
                                : '251',
                            // Ensure a default value if null or invalid
                            onChanged: (value) {
                              setState(() {
                                _passengerDetails[index]['countryCode'] =
                                    value ?? '251';
                              });
                            },
                            items: [
                              '251', // USA, Canada
                              '44', // UK
                              '91', // India
                              '61', // Australia
                              '81', // Japan
                              '49', // Germany
                              '33', // France
                            ].map((code) {
                              return DropdownMenuItem<String>(
                                value: code,
                                child: Text(code),
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(width: 10),

                        // Phone Number Field
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              _passengerDetails[index]['contactNumber'] = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () => _selectDate(context, index),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _passengerDetails[index]['dateOfBirth'] == null
                                ? 'Select Date'
                                : (_passengerDetails[index]['dateOfBirth']
                                        is DateTime)
                                    ? (_passengerDetails[index]['dateOfBirth']
                                                as DateTime)
                                            .toLocal()
                                            .toString()
                                            .split(' ')[
                                        0] // Convert DateTime to String
                                    : _passengerDetails[index][
                                        'dateOfBirth'], //  Use existing string value
                          ),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
      ],
    );
  }


  Widget _buildGenderButton(int index, String gender) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _passengerDetails[index]['gender'] = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _passengerDetails[index]['gender'] == gender
              ? Colors.blue
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          gender,
          style: TextStyle(
            color: _passengerDetails[index]['gender'] == gender
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('E, d MMM').format(dateTime); // "Thu, 20 Mar"
  }
  String formatTimeFromISOString(String isoTime) {
    try {
      DateTime dateTime = DateTime.parse(isoTime);
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      // Fallback if parsing fails
      return '--:--';
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
}
