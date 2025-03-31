class OrderCreateRS {
  String? message;
  FlightOrder? flightOrder;
  StoredData? storedData;

  OrderCreateRS({this.message, this.flightOrder, this.storedData});

  OrderCreateRS.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    flightOrder = json['flightOrder'] != null ? new FlightOrder.fromJson(json['flightOrder']) : null;
    storedData = json['storedData'] != null ? new StoredData.fromJson(json['storedData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.flightOrder != null) {
      data['flightOrder'] = this.flightOrder!.toJson();
    }
    if (this.storedData != null) {
      data['storedData'] = this.storedData!.toJson();
    }
    return data;
  }
}

class FlightOrder {
  Data? data;

  FlightOrder({this.data});

  FlightOrder.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class Data {
  String? type;
  String? id;
  String? queuingOfficeId;
  List<AssociatedRecords>? associatedRecords;
  List<FlightOffers>? flightOffers;
  List<Travelers>? travelers;
  Remarks? remarks;
  TicketingAgreement? ticketingAgreement;
  List<AutomatedProcess>? automatedProcess;
  List<Contacts>? contacts;

  Data({this.type, this.id, this.queuingOfficeId, this.associatedRecords, this.flightOffers, this.travelers, this.remarks, this.ticketingAgreement, this.automatedProcess, this.contacts});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id']?.toString();
    queuingOfficeId = json['queuingOfficeId'];
    if (json['associatedRecords'] != null) {
      associatedRecords = <AssociatedRecords>[];
      json['associatedRecords'].forEach((v) { associatedRecords!.add(new AssociatedRecords.fromJson(v)); });
    }
    if (json['flightOffers'] != null) {
      flightOffers = <FlightOffers>[];
      json['flightOffers'].forEach((v) { flightOffers!.add(new FlightOffers.fromJson(v)); });
    }
    if (json['travelers'] != null) {
      travelers = <Travelers>[];
      json['travelers'].forEach((v) { travelers!.add(new Travelers.fromJson(v)); });
    }
    remarks = json['remarks'] != null ? new Remarks.fromJson(json['remarks']) : null;
    ticketingAgreement = json['ticketingAgreement'] != null ? new TicketingAgreement.fromJson(json['ticketingAgreement']) : null;
    if (json['automatedProcess'] != null) {
      automatedProcess = <AutomatedProcess>[];
      json['automatedProcess'].forEach((v) { automatedProcess!.add(new AutomatedProcess.fromJson(v)); });
    }
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) { contacts!.add(new Contacts.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['queuingOfficeId'] = this.queuingOfficeId;
    if (this.associatedRecords != null) {
      data['associatedRecords'] = this.associatedRecords!.map((v) => v.toJson()).toList();
    }
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
    if (this.automatedProcess != null) {
      data['automatedProcess'] = this.automatedProcess!.map((v) => v.toJson()).toList();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssociatedRecords {
  String? reference;
  String? creationDate;
  String? originSystemCode;
  String? flightOfferId;

  AssociatedRecords({this.reference, this.creationDate, this.originSystemCode, this.flightOfferId});

  AssociatedRecords.fromJson(Map<String, dynamic> json) {
    reference = json['reference'];
    creationDate = json['creationDate'];
    originSystemCode = json['originSystemCode'];
    flightOfferId = json['flightOfferId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference'] = this.reference;
    data['creationDate'] = this.creationDate;
    data['originSystemCode'] = this.originSystemCode;
    data['flightOfferId'] = this.flightOfferId;
    return data;
  }
}

class FlightOffers {
  String? type;
  String? id;
  String? source;
  bool? nonHomogeneous;
  String? lastTicketingDate;
  List<Itineraries>? itineraries;
  Price? price;
  PricingOptions? pricingOptions;
  List<String>? validatingAirlineCodes;
  List<TravelerPricings>? travelerPricings;

  FlightOffers({this.type, this.id, this.source, this.nonHomogeneous, this.lastTicketingDate, this.itineraries, this.price, this.pricingOptions, this.validatingAirlineCodes, this.travelerPricings});

  FlightOffers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id']?.toString();
    source = json['source'];
    nonHomogeneous = json['nonHomogeneous'];
    lastTicketingDate = json['lastTicketingDate'];
    if (json['itineraries'] != null) {
      itineraries = <Itineraries>[];
      json['itineraries'].forEach((v) { itineraries!.add(new Itineraries.fromJson(v)); });
    }
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    pricingOptions = json['pricingOptions'] != null ? new PricingOptions.fromJson(json['pricingOptions']) : null;
    validatingAirlineCodes = json['validatingAirlineCodes'].cast<String>();
    if (json['travelerPricings'] != null) {
      travelerPricings = <TravelerPricings>[];
      json['travelerPricings'].forEach((v) { travelerPricings!.add(new TravelerPricings.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['source'] = this.source;
    data['nonHomogeneous'] = this.nonHomogeneous;
    data['lastTicketingDate'] = this.lastTicketingDate;
    if (this.itineraries != null) {
      data['itineraries'] = this.itineraries!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    if (this.pricingOptions != null) {
      data['pricingOptions'] = this.pricingOptions!.toJson();
    }
    data['validatingAirlineCodes'] = this.validatingAirlineCodes;
    if (this.travelerPricings != null) {
      data['travelerPricings'] = this.travelerPricings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Itineraries {
  List<Segments>? segments;

  Itineraries({this.segments});

  Itineraries.fromJson(Map<String, dynamic> json) {
    if (json['segments'] != null) {
      segments = <Segments>[];
      json['segments'].forEach((v) { segments!.add(new Segments.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String? duration;
  String? id;
  int? numberOfStops;
  List<Co2Emissions>? co2Emissions;

  Segments({this.departure, this.arrival, this.carrierCode, this.number, this.aircraft, this.duration, this.id, this.numberOfStops, this.co2Emissions});

  Segments.fromJson(Map<String, dynamic> json) {
    departure = json['departure'] != null ? new Departure.fromJson(json['departure']) : null;
    arrival = json['arrival'] != null ? new Departure.fromJson(json['arrival']) : null;
    carrierCode = json['carrierCode'];
    number = json['number'];
    aircraft = json['aircraft'] != null ? new Aircraft.fromJson(json['aircraft']) : null;
    duration = json['duration'];
    id = json['id']?.toString();
    numberOfStops = json['numberOfStops'];
    if (json['co2Emissions'] != null) {
      co2Emissions = <Co2Emissions>[];
      json['co2Emissions'].forEach((v) { co2Emissions!.add(new Co2Emissions.fromJson(v)); });
    }
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
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['numberOfStops'] = this.numberOfStops;
    if (this.co2Emissions != null) {
      data['co2Emissions'] = this.co2Emissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Departure {
  String iataCode;
  String terminal;
  DateTime at;
  Departure({
    required this.iataCode,
    required this.terminal,
    required this.at,
  });
  factory Departure.fromJson(Map<String, dynamic> json) => Departure(
    iataCode: json["iataCode"],
    terminal: json["terminal"]?? "",
    at: DateTime.parse(json["at"]),
  );

  Map<String, dynamic> toJson() => {
    "iataCode": iataCode,
    "terminal": terminal,
    "at": at.toIso8601String().split(".")[0],
  };
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

class Co2Emissions {
  int? weight;
  String? weightUnit;
  String? cabin;

  Co2Emissions({this.weight, this.weightUnit, this.cabin});

  Co2Emissions.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    cabin = json['cabin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = this.weight;
    data['weightUnit'] = this.weightUnit;
    data['cabin'] = this.cabin;
    return data;
  }
}

class Price {
  String? currency;
  String? total;
  String? base;
  List<taxes>? fees;
  String? grandTotal;
  String? billingCurrency;

  Price({this.currency, this.total, this.base, this.fees, this.grandTotal, this.billingCurrency});

  Price.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    total = json['total'];
    base = json['base'];
    if (json['fees'] != null) {
      fees = <taxes>[];
      json['fees'].forEach((v) { fees!.add(new taxes.fromJson(v)); });
    }
    grandTotal = json['grandTotal'];
    billingCurrency = json['billingCurrency'];
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
    data['billingCurrency'] = this.billingCurrency;
    return data;
  }
}

class taxes {
  String? amount;
  String? type;

  taxes({this.amount, this.type});

  taxes.fromJson(Map<String, dynamic> json) {
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



class Taxes {
  String? amount;
  String? code;

  Taxes({this.amount, this.code});

  Taxes.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['code'] = this.code;
    return data;
  }
}

class FareDetailsBySegment {
  String? segmentId;
  String? cabin;
  String? fareBasis;
  String? classType;
  IncludedCheckedBags? includedCheckedBags;

  FareDetailsBySegment({this.segmentId, this.cabin, this.fareBasis, this.classType, this.includedCheckedBags});

  FareDetailsBySegment.fromJson(Map<String, dynamic> json) {
  segmentId = json['segmentId'];
  cabin = json['cabin'];
  fareBasis = json['fareBasis'];
  classType = json['classType'];
  includedCheckedBags = json['includedCheckedBags'] != null ? new IncludedCheckedBags.fromJson(json['includedCheckedBags']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['segmentId'] = this.segmentId;
  data['cabin'] = this.cabin;
  data['fareBasis'] = this.fareBasis;
  data['class'] = this.classType;
  if (this.includedCheckedBags != null) {
  data['includedCheckedBags'] = this.includedCheckedBags!.toJson();
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
  String? gender;
  Name? name;
  List<Documents>? documents;
  Contact? contact;

  Travelers({this.id, this.dateOfBirth, this.gender, this.name, this.documents, this.contact});

  Travelers.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) { documents!.add(new Documents.fromJson(v)); });
    }
    contact = json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
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

class Documents {
  String? number;
  String? issuanceDate;
  String? expiryDate;
  String? issuanceCountry;
  String? issuanceLocation;
  String? nationality;
  String? birthPlace;
  String? documentType;
  bool? holder;

  Documents({this.number, this.issuanceDate, this.expiryDate, this.issuanceCountry, this.issuanceLocation, this.nationality, this.birthPlace, this.documentType, this.holder});

  Documents.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    issuanceDate = json['issuanceDate'];
    expiryDate = json['expiryDate'];
    issuanceCountry = json['issuanceCountry'];
    issuanceLocation = json['issuanceLocation'];
    nationality = json['nationality'];
    birthPlace = json['birthPlace'];
    documentType = json['documentType'];
    holder = json['holder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['issuanceDate'] = this.issuanceDate;
    data['expiryDate'] = this.expiryDate;
    data['issuanceCountry'] = this.issuanceCountry;
    data['issuanceLocation'] = this.issuanceLocation;
    data['nationality'] = this.nationality;
    data['birthPlace'] = this.birthPlace;
    data['documentType'] = this.documentType;
    data['holder'] = this.holder;
    return data;
  }
}

class Contact {
  String? purpose;
  List<Phones>? phones;
  String? emailAddress;

  Contact({this.purpose, this.phones, this.emailAddress});

  Contact.fromJson(Map<String, dynamic> json) {
    purpose = json['purpose'];
    if (json['phones'] != null) {
      phones = <Phones>[];
      json['phones'].forEach((v) { phones!.add(new Phones.fromJson(v)); });
    }
    emailAddress = json['emailAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purpose'] = this.purpose;
    if (this.phones != null) {
      data['phones'] = this.phones!.map((v) => v.toJson()).toList();
    }
    data['emailAddress'] = this.emailAddress;
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

class AutomatedProcess {
  String? code;
  Queue? queue;
  String? officeId;

  AutomatedProcess({this.code, this.queue, this.officeId});

  AutomatedProcess.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    queue = json['queue'] != null ? new Queue.fromJson(json['queue']) : null;
    officeId = json['officeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.queue != null) {
      data['queue'] = this.queue!.toJson();
    }
    data['officeId'] = this.officeId;
    return data;
  }
}

class Queue {
  String? number;
  String? category;

  Queue({this.number, this.category});

  Queue.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['category'] = this.category;
    return data;
  }
}

class Contacts {
  AddresseeName? addresseeName;
  Address? address;
  String? purpose;
  List<Phones>? phones;
  String? companyName;
  String? emailAddress;

  Contacts({this.addresseeName, this.address, this.purpose, this.phones, this.companyName, this.emailAddress});

  Contacts.fromJson(Map<String, dynamic> json) {
    addresseeName = json['addresseeName'] != null ? new AddresseeName.fromJson(json['addresseeName']) : null;
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
    purpose = json['purpose'];
    if (json['phones'] != null) {
      phones = <Phones>[];
      json['phones'].forEach((v) { phones!.add(new Phones.fromJson(v)); });
    }
    companyName = json['companyName'];
    emailAddress = json['emailAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresseeName != null) {
      data['addresseeName'] = this.addresseeName!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['purpose'] = this.purpose;
    if (this.phones != null) {
      data['phones'] = this.phones!.map((v) => v.toJson()).toList();
    }
    data['companyName'] = this.companyName;
    data['emailAddress'] = this.emailAddress;
    return data;
  }
}

class AddresseeName {
  String? firstName;

  AddresseeName({this.firstName});

  AddresseeName.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    return data;
  }
}

class Address {
  List<String>? lines;
  String? postalCode;
  String? countryCode;
  String? cityName;

  Address({this.lines, this.postalCode, this.countryCode, this.cityName});

  Address.fromJson(Map<String, dynamic> json) {
    lines = json['lines'].cast<String>();
    postalCode = json['postalCode'];
    countryCode = json['countryCode'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lines'] = this.lines;
    data['postalCode'] = this.postalCode;
    data['countryCode'] = this.countryCode;
    data['cityName'] = this.cityName;
    return data;
  }
}



class StoredData {
  String? id;
  String? type;
  String? queuingOfficeId;
  String? ticketingOption;
  String? ticketingDelay;
  String? totalPrice;
  String? currency;
  String? createdAt;
  String? updatedAt;
  List<AssociatedRecords>? associatedRecords;
  List<Segments>? segments;
  List<Travelers>? travelers;

  StoredData({this.id, this.type, this.queuingOfficeId, this.ticketingOption, this.ticketingDelay, this.totalPrice, this.currency, this.createdAt, this.updatedAt, this.associatedRecords, this.segments, this.travelers});

  StoredData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    type = json['type'];
    queuingOfficeId = json['queuingOfficeId'];
    ticketingOption = json['ticketingOption'];
    ticketingDelay = json['ticketingDelay'];
    totalPrice = json['total_price'];
    currency = json['currency'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['associatedRecords'] != null) {
      associatedRecords = <AssociatedRecords>[];
      json['associatedRecords'].forEach((v) { associatedRecords!.add(new AssociatedRecords.fromJson(v)); });
    }
    if (json['segments'] != null) {
      segments = <Segments>[];
      json['segments'].forEach((v) { segments!.add(new Segments.fromJson(v)); });
    }
    if (json['travelers'] != null) {
      travelers = <Travelers>[];
      json['travelers'].forEach((v) { travelers!.add(new Travelers.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['queuingOfficeId'] = this.queuingOfficeId;
    data['ticketingOption'] = this.ticketingOption;
    data['ticketingDelay'] = this.ticketingDelay;
    data['total_price'] = this.totalPrice;
    data['currency'] = this.currency;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.associatedRecords != null) {
      data['associatedRecords'] = this.associatedRecords!.map((v) => v.toJson()).toList();
    }
    if (this.segments != null) {
      data['segments'] = this.segments!.map((v) => v.toJson()).toList();
    }
    if (this.travelers != null) {
      data['travelers'] = this.travelers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



