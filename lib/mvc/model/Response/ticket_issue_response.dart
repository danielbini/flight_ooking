class TicketIssueResponse {
  String? message;
  Ticket? ticket;

  TicketIssueResponse({this.message, this.ticket});

  TicketIssueResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    ticket =
    json['ticket'] != null ? new Ticket.fromJson(json['ticket']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.ticket != null) {
      data['ticket'] = this.ticket!.toJson();
    }
    return data;
  }
}

class Ticket {
  int? id;
  String? ticketNumber;
  int? travelerId;
  int? flightOrderId;
  String? status;
  String? updatedAt;
  String? createdAt;

  Ticket(
      {this.id,
        this.ticketNumber,
        this.travelerId,
        this.flightOrderId,
        this.status,
        this.updatedAt,
        this.createdAt});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketNumber = json['ticketNumber'];
    travelerId = json['travelerId'];
    flightOrderId = json['flight_order_id'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticketNumber'] = this.ticketNumber;
    data['travelerId'] = this.travelerId;
    data['flight_order_id'] = this.flightOrderId;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
