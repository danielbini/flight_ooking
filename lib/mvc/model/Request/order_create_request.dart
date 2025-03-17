import '../Response/flight_offer_response.dart';

class OrderCreateRQ {
  OrderCreateData? data;

  OrderCreateRQ({this.data});

  OrderCreateRQ.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new OrderCreateData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OrderCreateData {
  String? type;
  List<FlightOffers>? flightOffers;
  List<Travelers>? travelers;
  Remarks? remarks;
  TicketingAgreement? ticketingAgreement;
  List<Contacts>? contacts;

  OrderCreateData({this.type, this.flightOffers, this.travelers, this.remarks, this.ticketingAgreement, this.contacts});

  OrderCreateData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['flightOffers'] != null) {
      flightOffers = List<FlightOffers>.from(json['flightOffers'].map((x) => FlightOffers.fromJson(x)));

    }
    if (json['travelers'] != null) {
      travelers = <Travelers>[];
      json['travelers'].forEach((v) { travelers!.add(new Travelers.fromJson(v)); });
    }
    remarks = json['remarks'] != null ? new Remarks.fromJson(json['remarks']) : null;
    ticketingAgreement = json['ticketingAgreement'] != null ? new TicketingAgreement.fromJson(json['ticketingAgreement']) : null;
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) { contacts!.add(new Contacts.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.flightOffers != null) {
      data['flightOffers'] = this.flightOffers!.map((v) => v.toJson()).toList();
    }
    if (this.travelers != null) {
      data['travelers'] = this.travelers!.map((v) => v.toJson()).toList();
    }
    if (this.remarks != null) {
      data['remarks'] = this.remarks!.toJson();
    }
    if (this.ticketingAgreement != null) {
      data['ticketingAgreement'] = this.ticketingAgreement!.toJson();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Itineraries {
  String? duration;
  List<Segments>? segments;

  Itineraries({this.duration, this.segments});

  Itineraries.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    if (json['segments'] != null) {
      segments = <Segments>[];
      json['segments'].forEach((v) { segments!.add(new Segments.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    if (this.segments != null) {
      data['segments'] = this.segments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Segments {
  Departure? departure;
  Departure? arrival;
  String? carrierCode;
  String? number;
  Aircraft? aircraft;
  Operating? operating;
  String? duration;
  String? id;
  int? numberOfStops;
  bool? blacklistedInEU;

  Segments({this.departure, this.arrival, this.carrierCode, this.number, this.aircraft, this.operating, this.duration, this.id, this.numberOfStops, this.blacklistedInEU});

  Segments.fromJson(Map<String, dynamic> json) {
    departure = json['departure'] != null ? new Departure.fromJson(json['departure']) : null;
    arrival = json['arrival'] != null ? new Departure.fromJson(json['arrival']) : null;
    carrierCode = json['carrierCode'];
    number = json['number'];
    aircraft = json['aircraft'] != null ? new Aircraft.fromJson(json['aircraft']) : null;
    operating = json['operating'] != null ? new Operating.fromJson(json['operating']) : null;
    duration = json['duration'];
    id = json['id'];
    numberOfStops = json['numberOfStops'];
    blacklistedInEU = json['blacklistedInEU'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.departure != null) {
      data['departure'] = this.departure!.toJson();
    }
    if (this.arrival != null) {
      data['arrival'] = this.arrival!.toJson();
    }
    data['carrierCode'] = this.carrierCode;
    data['number'] = this.number;
    if (this.aircraft != null) {
      data['aircraft'] = this.aircraft!.toJson();
    }
    if (this.operating != null) {
      data['operating'] = this.operating!.toJson();
    }
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['numberOfStops'] = this.numberOfStops;
    data['blacklistedInEU'] = this.blacklistedInEU;
    return data;
  }
}

class Departure {
  String? iataCode;
  String? terminal;
  String? at;

  Departure({this.iataCode, this.terminal, this.at});

  Departure.fromJson(Map<String, dynamic> json) {
    iataCode = json['iataCode'];
    terminal = json['terminal'];
    at = json['at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iataCode'] = this.iataCode;
    data['terminal'] = this.terminal;
    data['at'] = this.at;
    return data;
  }
}

class Aircraft {
  String? code;

  Aircraft({this.code});

  Aircraft.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}

class Operating {
  String? carrierCode;

  Operating({this.carrierCode});

  Operating.fromJson(Map<String, dynamic> json) {
    carrierCode = json['carrierCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carrierCode'] = this.carrierCode;
    return data;
  }
}

class Price {
  String? currency;
  String? total;
  String? base;
  List<Fees>? fees;
  String? grandTotal;

  Price({this.currency, this.total, this.base, this.fees, this.grandTotal});

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    total = json['total'];
    base = json['base'];
    if (json['fees'] != null) {
      fees = <Fees>[];
      json['fees'].forEach((v) { fees!.add(new Fees.fromJson(v)); });
    }
    grandTotal = json['grandTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['total'] = this.total;
    data['base'] = this.base;
    if (this.fees != null) {
      data['fees'] = this.fees!.map((v) => v.toJson()).toList();
    }
    data['grandTotal'] = this.grandTotal;
    return data;
  }
}

class Fees {
  String? amount;
  String? type;

  Fees({this.amount, this.type});

  Fees.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['type'] = this.type;
    return data;
  }
}

class PricingOptions {
  List<String>? fareType;
  bool? includedCheckedBagsOnly;

  PricingOptions({this.fareType, this.includedCheckedBagsOnly});

  PricingOptions.fromJson(Map<String, dynamic> json) {
    fareType = json['fareType'].cast<String>();
    includedCheckedBagsOnly = json['includedCheckedBagsOnly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fareType'] = this.fareType;
    data['includedCheckedBagsOnly'] = this.includedCheckedBagsOnly;
    return data;
  }
}

class TravelerPricings {
  String? travelerId;
  String? fareOption;
  String? travelerType;
  Price? price;
  List<FareDetailsBySegment>? fareDetailsBySegment;

  TravelerPricings({this.travelerId, this.fareOption, this.travelerType, this.price, this.fareDetailsBySegment});

  TravelerPricings.fromJson(Map<String, dynamic> json) {
    travelerId = json['travelerId'];
    fareOption = json['fareOption'];
    travelerType = json['travelerType'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    if (json['fareDetailsBySegment'] != null) {
      fareDetailsBySegment = <FareDetailsBySegment>[];
      json['fareDetailsBySegment'].forEach((v) { fareDetailsBySegment!.add(new FareDetailsBySegment.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['travelerId'] = this.travelerId;
    data['fareOption'] = this.fareOption;
    data['travelerType'] = this.travelerType;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.fareDetailsBySegment != null) {
      data['fareDetailsBySegment'] = this.fareDetailsBySegment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class IncludedCheckedBags {
  int? quantity;

  IncludedCheckedBags({this.quantity});

  IncludedCheckedBags.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    return data;
  }
}

class Travelers {
  String? id;
  String? dateOfBirth;
  Name? name;
  String? gender;
  Contact? contact;
  List<Documents>? documents;

  Travelers({this.id, this.dateOfBirth, this.name, this.gender, this.contact, this.documents});

  Travelers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateOfBirth = json['dateOfBirth'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    gender = json['gender'];
    contact = json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) { documents!.add(new Documents.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateOfBirth'] = this.dateOfBirth;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['gender'] = this.gender;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Name {
  String? firstName;
  String? lastName;

  Name({this.firstName, this.lastName});

  Name.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}

class Contact {
  String? emailAddress;
  List<Phones>? phones;

  Contact({this.emailAddress, this.phones});

  Contact.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'];
    if (json['phones'] != null) {
      phones = <Phones>[];
      json['phones'].forEach((v) { phones!.add(new Phones.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailAddress'] = this.emailAddress;
    if (this.phones != null) {
      data['phones'] = this.phones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Phones {
  String? deviceType;
  String? countryCallingCode;
  String? number;

  Phones({this.deviceType, this.countryCallingCode, this.number});

  Phones.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    countryCallingCode = json['countryCallingCode'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceType'] = this.deviceType;
    data['countryCallingCode'] = this.countryCallingCode;
    data['number'] = this.number;
    return data;
  }
}

class Documents {
  String? documentType;
  String? birthPlace;
  String? issuanceLocation;
  String? issuanceDate;
  String? number;
  String? expiryDate;
  String? issuanceCountry;
  String? validityCountry;
  String? nationality;
  bool? holder;

  Documents({this.documentType, this.birthPlace, this.issuanceLocation, this.issuanceDate, this.number, this.expiryDate, this.issuanceCountry, this.validityCountry, this.nationality, this.holder});

  Documents.fromJson(Map<String, dynamic> json) {
    documentType = json['documentType'];
    birthPlace = json['birthPlace'];
    issuanceLocation = json['issuanceLocation'];
    issuanceDate = json['issuanceDate'];
    number = json['number'];
    expiryDate = json['expiryDate'];
    issuanceCountry = json['issuanceCountry'];
    validityCountry = json['validityCountry'];
    nationality = json['nationality'];
    holder = json['holder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentType'] = this.documentType;
    data['birthPlace'] = this.birthPlace;
    data['issuanceLocation'] = this.issuanceLocation;
    data['issuanceDate'] = this.issuanceDate;
    data['number'] = this.number;
    data['expiryDate'] = this.expiryDate;
    data['issuanceCountry'] = this.issuanceCountry;
    data['validityCountry'] = this.validityCountry;
    data['nationality'] = this.nationality;
    data['holder'] = this.holder;
    return data;
  }
}

class Remarks {
  List<General>? general;

  Remarks({this.general});

  Remarks.fromJson(Map<String, dynamic> json) {
    if (json['general'] != null) {
      general = <General>[];
      json['general'].forEach((v) { general!.add(new General.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.general != null) {
      data['general'] = this.general!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class General {
  String? subType;
  String? text;

  General({this.subType, this.text});

  General.fromJson(Map<String, dynamic> json) {
    subType = json['subType'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subType'] = this.subType;
    data['text'] = this.text;
    return data;
  }
}

class TicketingAgreement {
  String? option;
  String? delay;

  TicketingAgreement({this.option, this.delay});

  TicketingAgreement.fromJson(Map<String, dynamic> json) {
    option = json['option'];
    delay = json['delay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option'] = this.option;
    data['delay'] = this.delay;
    return data;
  }
}

class Contacts {
  Name? addresseeName;
  String? companyName;
  String? purpose;
  List<Phones>? phones;
  String? emailAddress;
  Address? address;

  Contacts({this.addresseeName, this.companyName, this.purpose, this.phones, this.emailAddress, this.address});

  Contacts.fromJson(Map<String, dynamic> json) {
    addresseeName = json['addresseeName'] != null ? new Name.fromJson(json['addresseeName']) : null;
    companyName = json['companyName'];
    purpose = json['purpose'];
    if (json['phones'] != null) {
      phones = <Phones>[];
      json['phones'].forEach((v) { phones!.add(new Phones.fromJson(v)); });
    }
    emailAddress = json['emailAddress'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresseeName != null) {
      data['addresseeName'] = this.addresseeName!.toJson();
    }
    data['companyName'] = this.companyName;
    data['purpose'] = this.purpose;
    if (this.phones != null) {
      data['phones'] = this.phones!.map((v) => v.toJson()).toList();
    }
    data['emailAddress'] = this.emailAddress;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  List<String>? lines;
  String? postalCode;
  String? cityName;
  String? countryCode;

  Address({this.lines, this.postalCode, this.cityName, this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    lines = json['lines'].cast<String>();
    postalCode = json['postalCode'];
    cityName = json['cityName'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lines'] = this.lines;
    data['postalCode'] = this.postalCode;
    data['cityName'] = this.cityName;
    data['countryCode'] = this.countryCode;
    return data;
  }
}

