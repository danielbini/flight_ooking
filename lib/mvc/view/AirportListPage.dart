import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AirportSearchScreen extends StatefulWidget {
  final Function(String) onAirportSelected;

  const AirportSearchScreen({Key? key, required this.onAirportSelected})
      : super(key: key);

  @override
  _AirportSearchScreenState createState() => _AirportSearchScreenState();
}

class _AirportSearchScreenState extends State<AirportSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _allAirports = [
    'Addis Ababa Ethiopia Africa (ADD)',
    'Bahir Dar Ethiopia Africa (BJR)',
    'Dubai United Arab Emirate (DXB)',
    'Washington Dulles United States of America (IAD)',
    'Los Angeles International (LAX)',
    'John F. Kennedy International (JFK)',
    'San Francisco International (SFO)',
    'Chicago O\'Hare International (ORD)',
    'Dallas/Fort Worth International (DFW)',
  ];
  List<String> _filteredAirports = [];

  @override
  void initState() {
    super.initState();
    _filteredAirports = _allAirports; // Show all airports initially
    _searchController.addListener(_filterAirports);
  }

  void _filterAirports() {
    setState(() {
      _filteredAirports = _allAirports
          .where((airport) => airport
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Airport'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search airport',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredAirports.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredAirports[index]),
                  onTap: () {
                    widget.onAirportSelected(_filteredAirports[index]);
                    Navigator.of(context).pop(); // Close the screen
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
