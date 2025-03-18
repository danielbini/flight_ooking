import 'package:flight_booking/mvc/model/Response/order_create_response.dart';
import 'package:flight_booking/mvc/view/paymentPage.dart';
import 'package:flutter/material.dart';
import 'package:flight_booking/mvc/model/Response/flight_offer_response.dart' as request;
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
        final result = await _Apicontroller.OrderCreate(widget.offerPriceResponse!,_passengerDetails);
        setState(() {
          orderCreateRS=result;
        });
      } catch (error) {
        setState(() {
          orderCreateRS = null; // Assign a default value
        });
      }
      finally {
        setState(() {
          isLoading = false;
        });
        if (orderCreateRS != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentPage(orderCreateRS:orderCreateRS!),
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
              ElevatedButton(
                onPressed: isLoading ? null :_submitForm,
                child: Text('Submit All'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPassengerForm(int index, request.TravelerPricings traveler) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Passenger ${index + 1} (${traveler.travelerType})',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
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
                          value: _passengerDetails[index]['countryCode'] != null &&
                              ['251', '44', '91', '61', '81', '49', '33']
                                  .contains(_passengerDetails[index]['countryCode'])
                              ? _passengerDetails[index]['countryCode']
                              : '251', // Ensure a default value if null or invalid
                          onChanged: (value) {
                            setState(() {
                              _passengerDetails[index]['countryCode'] = value??'251';
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
                                      .split(
                                          ' ')[0] // Convert DateTime to String
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
}
