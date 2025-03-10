import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/flight_search_response.dart';

class ApiController {
  static const String baseUrl =
      'https://travelapi.test.tobiyamarketplace.com'; // Replace with actual API URL

  Future<SearchResponse> bookFlight(BuildContext context,String origin, String destination,
      String date, String returndate, int? passengers) async {
    const String endpoint = '$baseUrl/api/auth/token';
    SearchResponse  flightSearchRespnse ;
    try {
      final tokenResponse = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
      );

      if (tokenResponse.statusCode == 200) {
        final Uri uri = Uri.parse(
                'https://travelapi.test.tobiyamarketplace.com/api/shopping/flight-offers')
            .replace(
          queryParameters: {
            'originLocationCode': origin,
            'destinationLocationCode': destination,
            'departureDate': date,
            'returnDate': returndate,
            'adults': passengers.toString(),
            'max': '5',
          },
        );
        final data = jsonDecode(tokenResponse.body);
        String accessToken = data['accessToken'];
        final response = await http.get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          },
          // body: jsonEncode({'origin': origin, 'destination': destination}),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);

          if (data != null) {
             flightSearchRespnse = SearchResponse.fromJson(data);
             return flightSearchRespnse;

          } else {
            flightSearchRespnse=SearchResponse.fromJson(data);
            print('Data is null');
          }
          return flightSearchRespnse;
        } else {
          throw Exception('Failed to  load data: ${response.statusCode}');
        }
      } else {
        throw Exception('Failed to load data: ${tokenResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
