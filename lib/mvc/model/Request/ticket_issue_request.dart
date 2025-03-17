

class TicketIssueRequest {
  int? flightOrderId;
  int? travelerId;

  TicketIssueRequest({this.flightOrderId, this.travelerId});

  TicketIssueRequest.fromJson(Map<String, dynamic> json) {
    flightOrderId = json['flight_order_id'];
    travelerId = json['travelerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flight_order_id'] = this.flightOrderId;
    data['travelerId'] = this.travelerId;
    return data;
  }
}
