import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../controller/flight_search_controller.dart';
import '../model/Response/flight_search_response.dart';
import 'AirportListPage.dart';
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
  int _adults = 1;
  int _children = 0;
  int _infants = 0;
  int? _passengers;
  String? _originCode;
  String? _destinationCode;
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
  void _showPassengerPicker() {
    int tempAdults = _adults;
    int tempChildren = _children;
    int tempInfants = _infants;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: Text('Passengers'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPassengerRow('Adults', tempAdults, (value) {
                    setDialogState(() {
                      tempAdults = value;
                    });
                  }),
                  _buildPassengerRow('Children', tempChildren, (value) {
                    setDialogState(() {
                      tempChildren = value;
                    });
                  }),
                  _buildPassengerRow('Infants', tempInfants, (value) {
                    setDialogState(() {
                      tempInfants = value;
                    });
                  }),
                ],
              ),
                actions: [
                  SizedBox(
                    width: double.infinity, // Full width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 11), // Adjust vertical padding
                      ),
                      onPressed: () {
                        // Update the parent widget's state when "Done" is pressed
                        setState(() {
                          _adults = tempAdults;
                          _passengers = tempAdults;
                          _children = tempChildren;
                          _infants = tempInfants;
                        });
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Done', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],

            );
          },
        );
      },
    );
  }
  Widget _buildODTextField({
    required TextEditingController controller,
    required String label,
    required Function(String) onAirportSelected,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      readOnly: true, // Prevent manual typing
      onTap: () async {
        // Navigate to AirportSearchScreen
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AirportSearchScreen(
              onAirportSelected: (String fullSelection) {
                // Split the full selection into name and code
                final split = fullSelection.split('(');
                final fullName = split[0].trim();
                final code = split[1].replaceAll(')', '').trim();

                controller.text = fullName; // Display full airport name in the text field
                onAirportSelected(code); // Pass only the airport code
              },
            ),
          ),
        );
      },
    );
  }


  Widget _buildPassengerRow(String label, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if (value > 0) {
                  onChanged(value - 1);
                }
              },
            ),
            Text(value.toString()),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                onChanged(value + 1);
              },
            ),
          ],
        ),
      ],
    );
  }
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller,
      {DateTime? firstDate}) async {
    DateTime now = DateTime.now();
    DateTime effectiveFirstDate = firstDate ?? now;
    DateTime initialDate =
        effectiveFirstDate.isAfter(now) ? effectiveFirstDate : now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: effectiveFirstDate,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toLocal().toString().split(' ')[0];
        if (controller == _dateController) {
          _returnDateController.text = ""; // Clear return date if needed
        }
      });
    }
  }

  Future<void> bookFlight() async {
    setState(() {
      isLoading = true;
    });
    final String origin = _originCode!;
    final String destination = _destinationCode!;
    final String date = _dateController.text;
    final int? passengers = _adults;
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildTripTypeButton('One-way'),
                          SizedBox(width: 15),
                          _buildTripTypeButton('Round-trip'),
                          SizedBox(width: 15),
                          _buildTripTypeButton('Multi-city'),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildODTextField(
                        controller: _originController,
                        label: 'Origin',
                        onAirportSelected: (String code) {
                          setState(() {
                            _originCode = code; // Save the origin airport code for API
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Swap origin and destination values
                        String tempText = _originController.text;
                        String? tempCode = _originCode;

                        setState(() {
                          _originController.text = _destinationController.text;
                          _originCode = _destinationCode;

                          _destinationController.text = tempText;
                          _destinationCode = tempCode;
                        });
                      },
                      icon: Icon(Icons.swap_horiz),
                    ),
                    Expanded(
                      child: _buildODTextField(
                        controller: _destinationController,
                        label: 'Destination',
                        onAirportSelected: (String code) {
                          setState(() {
                            _destinationCode = code; // Save the destination airport code for API
                          });
                        },
                      ),
                    ),
                  ],
                )

                ,

                    SizedBox(height: 20),
                    _buildDateField(_dateController, 'Departure Date'),
                    if (_selectedTripType == "Round-trip") SizedBox(height: 20),
                    if (_selectedTripType == "Round-trip")
                      _buildDateField(_returnDateController, 'Return Date',
                          firstDate: _dateController.text.isNotEmpty
                              ? DateTime.parse(_dateController.text)
                              : DateTime.now()),

                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Passengers:'),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: _showPassengerPicker,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '$_adults Adult${_adults != 1 ? 's' : ''}, $_children Child${_children != 1 ? 'ren' : ''}, $_infants Infant${_infants != 1 ? 's' : ''}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
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
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              // Ensure all 4 tabs show
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: 'My Booking'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: 'History'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.login), label: 'Profile'),
              ],
              onTap: (index) {},
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
  Widget _buildDateField(TextEditingController controller, String label,
      {DateTime? firstDate}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      readOnly: true,
      onTap: () => _selectDate(context, controller, firstDate: firstDate),
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



