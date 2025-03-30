import 'package:flutter/material.dart';

class FlightTypeSelector extends StatefulWidget {
  final Function(String) onTypeSelected; // Callback to return the selected type

  const FlightTypeSelector({Key? key, required this.onTypeSelected}) : super(key: key);

  @override
  _FlightTypeSelectorState createState() => _FlightTypeSelectorState();
}

class _FlightTypeSelectorState extends State<FlightTypeSelector> {
  String _selectedTripType = "Round-trip"; // Default selected type

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: Row(
        children: [
          _buildTripTypeButton("One-way"),
          SizedBox(width: 15),
          _buildTripTypeButton("Round-trip"),
          SizedBox(width: 15),
          _buildTripTypeButton("Multi-city"), // Add as many as you want
        ],
      ),
    );
  }

  Widget _buildTripTypeButton(String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTripType = type; // Update selected type
        });
        widget.onTypeSelected(type); // Notify parent widget
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedTripType == type ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          type,
          style: TextStyle(
            fontSize: 20,
            color: _selectedTripType == type ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
