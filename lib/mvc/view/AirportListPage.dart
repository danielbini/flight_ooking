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
    'London Heathrow United Kingdom (LHR)',
    'Frankfurt Germany Europe (FRA)',
    'Paris Charles de Gaulle France Europe (CDG)',
    'Tokyo Haneda Japan Asia (HND)',
    'Beijing Capital China Asia (PEK)',
    'Sydney Kingsford Smith Australia Oceania (SYD)',
    'Toronto Pearson Canada North America (YYZ)',
    'Los Angeles International United States of America (LAX)',
    'Johannesburg OR Tambo South Africa Africa (JNB)',
    'Cairo International Egypt Africa (CAI)',
    'São Paulo Guarulhos Brazil South America (GRU)',
    'Mexico City Benito Juárez Mexico North America (MEX)',
    'Singapore Changi Singapore Asia (SIN)',
    'Delhi Indira Gandhi India Asia (DEL)',
    'Hong Kong International Hong Kong Asia (HKG)',
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
