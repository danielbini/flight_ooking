import 'dart:convert';

import '../model/Request/ticket_issue_request.dart';
import '../model/Response/ticket_issue_response.dart';
import 'Services/TokenService.dart';
import 'package:http/http.dart' as http;

class ApiTicketIssueController {
  static const String baseUrl = 'https://travelapi.test.tobiyamarketplace.com';

  Future<TicketIssueResponse> TicketIssue() async {
    const String endpoint = '$baseUrl/api/shopping/flight-tickets';
    String? token = TokenService().token;
    if (token == null) {
      throw Exception("Token not available");
    }
    TicketIssueResponse ticketIssueResponse;
    TicketIssueRequest  ticketIssueRequest = TicketIssueRequest(
      flightOrderId: 15,
      travelerId: 1
    );

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(ticketIssueRequest.toJson()),
      );
      if (response.statusCode == 201) {
        return TicketIssueResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to fetch offer price");
      }
    } catch (error) {
      throw Exception("Failed to fetch offer price");
    }
  }
}
