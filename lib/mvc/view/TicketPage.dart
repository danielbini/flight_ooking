import 'package:flight_booking/mvc/model/Response/ticket_issue_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FlightBookingPage.dart';

class TicketPage extends StatefulWidget {

  final TicketIssueResponse? ticketIssueResponse;

  const TicketPage({super.key, required this.ticketIssueResponse});
  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ticket Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget?.ticketIssueResponse?.message}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _ticketDetailRow("Ticket ID", widget.ticketIssueResponse!.ticket!.id.toString()),
            _ticketDetailRow("Ticket Number", widget!.ticketIssueResponse!.ticket!.ticketNumber!),
            _ticketDetailRow("Traveler ID", widget!.ticketIssueResponse!.ticket!.travelerId.toString()),
            _ticketDetailRow("Status",widget!.ticketIssueResponse!.ticket!.status!),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FlightBookingPage(),
                  ),
                ),

                child: Text("Back to home"),
                style: ElevatedButton.styleFrom(
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
  Widget _ticketDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }
}
