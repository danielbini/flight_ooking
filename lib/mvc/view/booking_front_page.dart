import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: FlightBookingScreen(),
  ));
}

class FlightBookingScreen extends StatefulWidget {
  @override
  _FlightBookingScreenState createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  int _selectedTab = 0; // 0 = One Way, 1 = Round Trip, 2 = Multi-city
  String _from = "DAC";
  String _to = "NYC";
  DateTime? _departureDate;
  DateTime? _returnDate;
  int _adults = 1;
  int _children = 0;
  int _infants = 0;
  String _class = "Economy";

  Future<void> _selectDate(BuildContext context, bool isReturn) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isReturn) {
          _returnDate = picked;
        } else {
          _departureDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Book Your Flight"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs for One Way, Round Trip, Multi-city
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTab("One Way", 0),
                _buildTab("Round Trip", 1),
                _buildTab("Multi-city", 2),
              ],
            ),
            SizedBox(height: 20),
            // Origin and Destination Fields
            Row(
              children: [
                _buildLocationField("From", _from),
                IconButton(
                  icon: Icon(Icons.swap_horiz),
                  onPressed: () {
                    setState(() {
                      String temp = _from;
                      _from = _to;
                      _to = temp;
                    });
                  },
                ),
                _buildLocationField("To", _to),
              ],
            ),
            SizedBox(height: 20),
            // Date Picker
            _buildDatePicker("Departure Date", _departureDate, false),
            if (_selectedTab == 1) _buildDatePicker("Return Date", _returnDate, true),
            SizedBox(height: 20),
            // Travelers and Class Dropdown
            _buildDropdown("Travelers", "$_adults Adult, $_children Child, $_infants Infant"),
            _buildDropdown("Class", _class),
            SizedBox(height: 30),
            // Search Flight Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Search Flight", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "My Booking"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: _selectedTab == index ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(title, style: TextStyle(color: _selectedTab == index ? Colors.white : Colors.black)),
      ),
    );
  }

  Widget _buildLocationField(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(value, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? date, bool isReturn) {
    return GestureDetector(
      onTap: () => _selectDate(context, isReturn),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date == null ? label : "${date.toLocal()}".split(' ')[0]),
            Icon(Icons.calendar_today, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(value, style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
