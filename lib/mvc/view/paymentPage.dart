import 'dart:ffi';

import 'package:flight_booking/mvc/controller/ticket_issue_controller.dart';
import 'package:flight_booking/mvc/model/Response/order_create_response.dart';
import 'package:flight_booking/mvc/model/Response/ticket_issue_response.dart';
import 'package:flight_booking/mvc/view/TicketPage.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final OrderCreateRS orderCreateRS;

  const PaymentPage({Key? key, required this.orderCreateRS});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = false;
  final ApiTicketIssueController _apiController = ApiTicketIssueController();
  TicketIssueResponse? ticketIssueResponse;

  Future<void> TicketIssue() async {  // Use 'void' instead of 'Void'
    setState(() {
      isLoading = true;
    });

    try {
      final result = await _apiController.TicketIssue();
      setState(() {
        ticketIssueResponse = result;
      });

      if (ticketIssueResponse != null) {
        showDialog(
          context: context,
          barrierDismissible: false, // Prevent closing by tapping outside
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.blue, size: 60), // Checkmark Icon
                  SizedBox(height: 10),
                  Text(
                    "Payment Succeed!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text("Thank you for purchasing the ticket!"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Blue button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TicketPage()),
                      );
                    },
                    child: Text("View Ticket", style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Go back to Home
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back, color: Colors.grey),
                        SizedBox(width: 5),
                        Text("Back to Home", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to issue ticket.')),
        );
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error issuing ticket: $err')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Due: \$14500',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'You save \$500',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            Text(
              'Convenience Fee Added',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildPaymentMethod('PayPal', 'Paypal'),
            _buildPaymentMethod('VISA', 'Visa Card'),
            _buildPaymentMethod('Stripe', 'Stripe'),
            Divider(height: 32, thickness: 2),
            Text(
              'Fare Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildFareDetail('Adult x1', '\$13000'),
            _buildFareDetail('Basic Fare', '\$13000'),
            _buildFareDetail('Taxes', '\$20000'),
            Divider(height: 32, thickness: 2),
            Center(
              child: ElevatedButton(
                onPressed:isLoading ? null :TicketIssue,
                child: Text('Proceed to Payment'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.blue
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPaymentMethod(String method, String description) {
  return Card(
    margin: EdgeInsets.only(bottom: 16),
    child: ListTile(
      title: Text(
        method,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Handle payment method selection
      },
    ),
  );
}

Widget _buildFareDetail(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}
