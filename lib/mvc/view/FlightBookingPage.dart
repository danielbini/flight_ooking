import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../controller/flight_search_controller.dart';
import '../model/flight_search_response.dart';
import 'flight_list_page.dart';

class FlightBookingPage extends StatefulWidget {
  @override
  _FlightBookingPageState createState() => _FlightBookingPageState();
}

class _FlightBookingPageState extends State<FlightBookingPage> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _returnDateController = TextEditingController();
  final ApiController _apiController = ApiController();

  SearchResponse? flights;

  int? _passengers;

  String _travelClass = 'Economy';
  String _selectedTripType = "Round-trip";
  bool isLoading = false;

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _dateController.dispose();
    _returnDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> bookFlight() async {
    setState(() {
      isLoading = true;
    });
    final String origin = _originController.text;
    final String destination = _destinationController.text;
    final String date = _dateController.text;
    final int? passengers = _passengers;
    final String returndate = _returnDateController.text;
    if (_selectedTripType == "Round-trip") {
      final String returndate = _returnDateController.text;
    }
    try {
      final result = await _apiController.bookFlight(
        context,
        origin,
        destination,
        date,
        returndate,
        passengers,
      );
      setState(() {
        flights = result;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        flights = null; // Assign a default value
      });
    } finally {
      setState(() {
        isLoading = false;
      });
      if (flights != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FlightListPage(flightData: flights!),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Book a Flight'),
          elevation: 0,
          backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: CurvedTopClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                color: Colors.blue, // Background color for the curved section
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTripTypeButton('One-way'),
                        SizedBox(width: 20),
                        _buildTripTypeButton('Round-trip'),
                        SizedBox(width: 20),
                        _buildTripTypeButton('Multi-city'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(_originController, 'Origin'),
                        ),
                        IconButton(
                            onPressed: () {
                              String temp = _originController.text;
                              _originController.text =
                                  _destinationController.text;
                              _destinationController.text = temp;
                            },
                            icon: Icon(Icons.swap_horiz)),
                        Expanded(
                          child: _buildTextField(
                              _destinationController, 'Destination'),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    _buildDateField(_dateController, 'Departure Date'),
                    if (_selectedTripType == "Round-trip") SizedBox(height: 20),
                    if (_selectedTripType == "Round-trip")
                      _buildDateField(_returnDateController, 'Return Date'),

                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Passengers:'),
                        SizedBox(width: 10),
                        DropdownButton<int>(
                          value: _passengers,
                          hint: Text('1 Adult, 0 Child, 0 Infants',
                              style: TextStyle(color: Colors.black)),
                          items: List.generate(3, (index) => index + 1)
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.toString())))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _passengers = value;
                            });
                          },
                        ),
                      ],
                    ),

                    DropdownButtonFormField<String>(
                      value: _travelClass,
                      decoration: InputDecoration(labelText: 'Travel Class'),
                      items: ['Economy', 'Business', 'First Class']
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _travelClass = value!;
                        });
                      },
                    ),
                    // Extra space for scrolling
                  ],
                ),
              ),
            ),
            // Button stays fixed at the bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: isLoading ? null : bookFlight,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Book Flight",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Helper function for trip type buttons
  Widget _buildTripTypeButton(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedTripType = text;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedTripType == text ? Colors.blue : Colors.grey,
      ),
      child: Text(text),
    );
  }

  /// ✅ Helper function for text fields
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      inputFormatters: [UpperCaseTextFormatter()],
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  /// ✅ Helper function for date fields
  Widget _buildDateField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      readOnly: true,
      onTap: () => _selectDate(context, controller),
    );
  }
}

class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.75);
    path.lineTo(size.width, 0); // Top-right corner
    path.close(); // Complete the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
