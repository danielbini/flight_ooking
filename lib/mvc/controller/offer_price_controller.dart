import 'dart:convert';

import '../model/Request/flight_offer_price_request.dart';
import '../model/Response/flight_offer_response.dart';
import '../model/Response/flight_search_response.dart';
import 'package:http/http.dart' as http;

import 'Services/TokenService.dart';

class ApiOfferController {
  static const String baseUrl = 'https://travelapi.test.tobiyamarketplace.com';

  Future<OfferPriceResponse> SelectOffer(Datum flight) async {
    const String endpoint = '$baseUrl/api/shopping/flight-pricing';
    String? token = TokenService().token;
    if (token == null) {
      throw Exception("Token not available");
    }
    OfferPrice flightOfferRQ = OfferPrice(
      data: OfferData(
        type: "flight-offers-pricing",
        flightOffers: [flight],
      ),
    );

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(flightOfferRQ.toJson()),
      );
      if (response.statusCode == 200) {
        return OfferPriceResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to fetch offer price");
      }
    } catch (error) {
      throw Exception("Failed to fetch offer price");
    }
  }
}
