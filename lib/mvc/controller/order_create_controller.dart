import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Request/order_create_request.dart';
import '../model/Response/flight_offer_response.dart';
import '../model/Response/order_create_response.dart';
import 'Services/TokenService.dart';
import 'package:flight_booking/mvc/model/Request/order_create_request.dart'
    as order_create_travelers;

class ApiOrderCreateController {
  static const String baseUrl = 'https://travelapi.test.tobiyamarketplace.com';

  Future<OrderCreateRS> OrderCreate(OfferPriceResponse offerPriceResponse,
      List<Map<String, dynamic>> passengerDetails) async {
    const String endpoint = '$baseUrl/api/shopping/flight-order';

    String? token = TokenService().token;
    if (token == null) {
      throw Exception("Token not available");
    }
    List<order_create_travelers.Travelers> travelers =
        passengerDetails.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> passenger = entry.value;

      return order_create_travelers.Travelers(
        id: (index + 1).toString(),
        // Assigning a unique ID (1-based index)
        dateOfBirth: passenger['dateOfBirth'],
        // Already in string format
        gender: 'MALE',
        name: order_create_travelers.Name(
          firstName: passenger['firstName'],
          lastName: passenger['lastName'],
        ),
        contact: index == 0
            ? order_create_travelers.Contact(
                emailAddress: passenger['email'],
                phones: [
                  order_create_travelers.Phones(
                    // Fix: use `Phones` instead of `Phone`
                    deviceType: "MOBILE",
                    countryCallingCode: passenger?['countryCode']??"251",
                    number: passenger['contactNumber'],
                  )
                ],
              )
            : null,
        // Contact info only for first passenger
        documents: [
          order_create_travelers.Documents(
            documentType: "PASSPORT",
            birthPlace: "Madrid",
            issuanceCountry: "ES",
            issuanceDate: "2015-04-14",
            number: "00000000",
            expiryDate: "2025-04-14",
            issuanceLocation: "Madrid",
            validityCountry: "ES",
            nationality: "ES",
            holder: true,
          )
        ],
      );
    }).toList();
    OrderCreateRQ orderCreateRQ = OrderCreateRQ(
      data: OrderCreateData(
        type: "flight-order",
        flightOffers: [offerPriceResponse!.data!.flightOffers!.first],
        travelers: travelers,
        remarks: order_create_travelers.Remarks(
          general: [
            order_create_travelers.General(
              subType: "GENERAL_MISCELLANEOUS",
              text: "ONLINE BOOKING FROM INCREIBLE VIAJES",
            )
          ],
        ),
        ticketingAgreement: order_create_travelers.TicketingAgreement(
          option: "DELAY_TO_CANCEL",
          delay: "6D",
        ),
        contacts: [
          order_create_travelers.Contacts(
            addresseeName: order_create_travelers.Name(
                firstName: "PABLO", lastName: "RODRIGUEZ"),
            companyName: "INCREIBLE VIAJES",
            purpose: "STANDARD",
            emailAddress: "support@increibleviajes.es",
            phones: [
              order_create_travelers.Phones(
                deviceType: "LANDLINE",
                countryCallingCode: "34",
                number: "480080071",
              ),
              order_create_travelers.Phones(
                deviceType: "MOBILE",
                countryCallingCode: "33",
                number: "480080072",
              ),
            ],
            address: order_create_travelers.Address(
              lines: ["Calle Prado, 16"],
              postalCode: "28014",
              cityName: "Madrid",
              countryCode: "ES",
            ),
          ),
        ],
      ),
    );
    String requestBody = jsonEncode(orderCreateRQ.toJson());
    print("Request JSON: $requestBody");
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(orderCreateRQ.toJson()),
      );
      if (response.statusCode == 201) {
        final orderResponse = OrderCreateRS.fromJson(jsonDecode(response.body));
       var sdfs= await _saveOrder(orderResponse);
        final savedOrders = await getSavedOrders();
        return orderResponse;
      } else {
        throw Exception("Failed to fetch offer price");
      }
    } catch (error) {
      throw Exception("Failed to fetch offer price");
    }
  }
}
Future<void> _saveOrder(OrderCreateRS order) async {
  final prefs = await SharedPreferences.getInstance();

  // Get existing orders
  final String? ordersJson = prefs.getString('saved_orders');
  List<dynamic> orders = [];

  if (ordersJson != null) {
    orders = jsonDecode(ordersJson);
  }

  // Add new order
  orders.add(order.toJson());

  // Save back
  await prefs.setString('saved_orders', jsonEncode(orders));
}
Future<List<OrderCreateRS>> getSavedOrders() async {
  final prefs = await SharedPreferences.getInstance();
  final String? ordersJson = prefs.getString('saved_orders');

  if (ordersJson == null) {
    return [];
  }

  final List<dynamic> ordersList = jsonDecode(ordersJson);
  return ordersList.map((json) => OrderCreateRS.fromJson(json)).toList();
}