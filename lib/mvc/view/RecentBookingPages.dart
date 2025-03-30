import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/order_create_controller.dart';
import '../model/Response/order_create_response.dart';
import 'BookingDetailPage.dart';
import 'FlightBookingPage.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<OrderCreateRS> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    setState(() => isLoading = true);
    final savedOrders = await getSavedOrders();
    setState(() {
      orders = savedOrders;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? Center(child: Text('No bookings found'))
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return _buildBookingCard(order);
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'My Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
        if(index==0){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FlightBookingPage()),
          );
        }
        if(index==2){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingPage()),
          );
        }

        },
      ),
    );
  }

  Widget _buildBookingCard(OrderCreateRS order) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingDetailPage(flightOffers: order.flightOrder!.data!.flightOffers),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blue background section
            Container(
              decoration: BoxDecoration(
                color: Colors.blue, // Light blue background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route row with delete button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${order.flightOrder?.data?.flightOffers?.first.itineraries?.first.segments?.first.departure?.iataCode ?? 'N/A'} - '
                              '${order.flightOrder?.data?.flightOffers?.first.itineraries?.first.segments?.last.arrival?.iataCode ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900], // Darker blue text
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteOrder(order),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Price and class row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.flightOrder?.data?.flightOffers?.first.itineraries?.first.segments?.first.co2Emissions?.first.cabin ?? 'Economy',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${order.flightOrder?.data?.flightOffers?.first.price?.currency ?? ''} '
                            '${order.flightOrder?.data?.flightOffers?.first.price?.total ?? '0'}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // White background section (rest of the content)
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Addis Ababa"),
                  SizedBox(height: 8),
                  if (order.flightOrder?.data?.flightOffers?.first.itineraries?.first.segments?.first.departure?.at != null &&
                      order.flightOrder?.data?.flightOffers?.last.itineraries?.last.segments?.last.arrival?.at != null)
                    Text(
                      '${_formatDate(order.flightOrder!.data!.flightOffers!.first.itineraries!.first.segments!.first.departure!.at!.toString())} - '
                          '${_formatDate(order.flightOrder!.data!.flightOffers!.last.itineraries!.last.segments!.last.arrival!.at!.toString())}',
                    ),
                  SizedBox(height: 4),
                  if (order.flightOrder?.data?.flightOffers?.first.itineraries?.first.segments?.first.departure?.at != null)
                    Text(
                      "20:05",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dates) {
    DateTime date = DateTime.parse(dates);
    return '${date.day} ${_getMonthName(date.month)}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  Future<void> _deleteOrder(OrderCreateRS order) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Booking'),
        content: Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() => isLoading = true);
      try {
        // Remove from local storage
        final prefs = await SharedPreferences.getInstance();
        final ordersJson = prefs.getString('saved_orders');
        if (ordersJson != null) {
          final List<dynamic> ordersList = jsonDecode(ordersJson);
          ordersList
              .removeWhere((o) => o['orderId'] == order.flightOrder!.data!.id!);
          await prefs.setString('saved_orders', jsonEncode(ordersList));
        }

        // Update UI
        setState(() {
          orders.removeWhere(
              (o) => o.storedData!.id! == order.flightOrder!.data!.id!);
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking deleted successfully')),
        );
      } catch (e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete booking')),
        );
      }
    }
  }
}
