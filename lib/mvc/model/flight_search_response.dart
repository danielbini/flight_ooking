
import 'dart:convert';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponse(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  Meta meta;
  List<Datum> data;
  //Dictionaries dictionaries;

  SearchResponse({
    required this.meta,
    required this.data,
   // required this.dictionaries,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    meta: Meta.fromJson(json["meta"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
   // dictionaries: Dictionaries.fromJson(json["dictionaries"]),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
   // "dictionaries": dictionaries.toJson(),
  };
}

class Datum {
  String type;
  String id;
  String source;
  bool instantTicketingRequired;
  bool nonHomogeneous;
  bool oneWay;
  bool isUpsellOffer;
  DateTime lastTicketingDate;
  DateTime lastTicketingDateTime;
  int numberOfBookableSeats;
  List<Itinerary> itineraries;
  DatumPrice price;
  PricingOptions pricingOptions;
  List<String> validatingAirlineCodes;
  List<TravelerPricing> travelerPricings;

  Datum({
    required this.type,
    required this.id,
    required this.source,
    required this.instantTicketingRequired,
    required this.nonHomogeneous,
    required this.oneWay,
    required this.isUpsellOffer,
    required this.lastTicketingDate,
    required this.lastTicketingDateTime,
    required this.numberOfBookableSeats,
    required this.itineraries,
    required this.price,
    required this.pricingOptions,
    required this.validatingAirlineCodes,
    required this.travelerPricings,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    type: json["type"],
    id: json["id"],
    source: json["source"],
    instantTicketingRequired: json["instantTicketingRequired"],
    nonHomogeneous: json["nonHomogeneous"],
    oneWay: json["oneWay"],
    isUpsellOffer: json["isUpsellOffer"],
    lastTicketingDate: DateTime.parse(json["lastTicketingDate"]),
    lastTicketingDateTime: DateTime.parse(json["lastTicketingDateTime"]),
    numberOfBookableSeats: json["numberOfBookableSeats"],
    itineraries: List<Itinerary>.from(json["itineraries"].map((x) => Itinerary.fromJson(x))),
    price: DatumPrice.fromJson(json["price"]),
    pricingOptions: PricingOptions.fromJson(json["pricingOptions"]),
    validatingAirlineCodes: List<String>.from(json["validatingAirlineCodes"].map((x) => x)),
    travelerPricings: List<TravelerPricing>.from(json["travelerPricings"].map((x) => TravelerPricing.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "source": source,
    "instantTicketingRequired": instantTicketingRequired,
    "nonHomogeneous": nonHomogeneous,
    "oneWay": oneWay,
    "isUpsellOffer": isUpsellOffer,
    "lastTicketingDate": "${lastTicketingDate.year.toString().padLeft(4, '0')}-${lastTicketingDate.month.toString().padLeft(2, '0')}-${lastTicketingDate.day.toString().padLeft(2, '0')}",
    "lastTicketingDateTime": "${lastTicketingDateTime.year.toString().padLeft(4, '0')}-${lastTicketingDateTime.month.toString().padLeft(2, '0')}-${lastTicketingDateTime.day.toString().padLeft(2, '0')}",
    "numberOfBookableSeats": numberOfBookableSeats,
    "itineraries": List<dynamic>.from(itineraries.map((x) => x.toJson())),
    "price": price.toJson(),
    "pricingOptions": pricingOptions.toJson(),
    "validatingAirlineCodes": List<dynamic>.from(validatingAirlineCodes.map((x) => x)),
    "travelerPricings": List<dynamic>.from(travelerPricings.map((x) => x.toJson())),
  };
}

class Itinerary {
  String duration;
  List<Segment> segments;

  Itinerary({
    required this.duration,
    required this.segments,
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
    duration: json["duration"],
    segments: List<Segment>.from(json["segments"].map((x) => Segment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "duration": duration,
    "segments": List<dynamic>.from(segments.map((x) => x.toJson())),
  };
}

class Segment {
  Arrival departure;
  Arrival arrival;
  String carrierCode;
  String number;
  SegmentAircraft aircraft;
  Operating operating;
  String duration;
  String id;
  int numberOfStops;
  bool blacklistedInEu;

  Segment({
    required this.departure,
    required this.arrival,
    required this.carrierCode,
    required this.number,
    required this.aircraft,
    required this.operating,
    required this.duration,
    required this.id,
    required this.numberOfStops,
    required this.blacklistedInEu,
  });

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    departure: Arrival.fromJson(json["departure"]),
    arrival: Arrival.fromJson(json["arrival"]),
    carrierCode: json["carrierCode"],
    number: json["number"],
    aircraft: SegmentAircraft.fromJson(json["aircraft"]),
    operating: Operating.fromJson(json["operating"]),
    duration: json["duration"],
    id: json["id"],
    numberOfStops: json["numberOfStops"],
    blacklistedInEu: json["blacklistedInEU"],
  );

  Map<String, dynamic> toJson() => {
    "departure": departure.toJson(),
    "arrival": arrival.toJson(),
    "carrierCode": carrierCode,
    "number": number,
    "aircraft": aircraft.toJson(),
    "operating": operating.toJson(),
    "duration": duration,
    "id": id,
    "numberOfStops": numberOfStops,
    "blacklistedInEU": blacklistedInEu,
  };
}

class SegmentAircraft {
  String code;

  SegmentAircraft({
    required this.code,
  });

  factory SegmentAircraft.fromJson(Map<String, dynamic> json) => SegmentAircraft(
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
  };
}

class Arrival {
  String iataCode;
  String terminal;
  DateTime at;

  Arrival({
    required this.iataCode,
    required this.terminal,
    required this.at,
  });

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
    iataCode: json["iataCode"],
    terminal: json["terminal"]?? "",
    at: DateTime.parse(json["at"]),
  );

  Map<String, dynamic> toJson() => {
    "iataCode": iataCode,
    "terminal": terminal,
    "at": at.toIso8601String(),
  };
}



class Operating {
  String carrierCode;

  Operating({
    required this.carrierCode,
  });

  factory Operating.fromJson(Map<String, dynamic> json) => Operating(
    carrierCode: json["carrierCode"],
  );

  Map<String, dynamic> toJson() => {
    "carrierCode": carrierCode,
  };
}

class DatumPrice {
  String currency;
  String total;
  String base;
  List<Fee> fees;
  String grandTotal;

  DatumPrice({
    required this.currency,
    required this.total,
    required this.base,
    required this.fees,
    required this.grandTotal,
  });

  factory DatumPrice.fromJson(Map<String, dynamic> json) => DatumPrice(
    currency: json["currency"],
    total: json["total"],
    base: json["base"],
    fees: List<Fee>.from(json["fees"].map((x) => Fee.fromJson(x))),
    grandTotal: json["grandTotal"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "total": total,
    "base": base,
    "fees": List<dynamic>.from(fees.map((x) => x.toJson())),
    "grandTotal": grandTotal,
  };
}

class Fee {
  String amount;
  String type;

  Fee({
    required this.amount,
    required this.type,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => Fee(
    amount: json["amount"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "type": type,
  };
}

class PricingOptions {
  List<String> fareType;
  bool includedCheckedBagsOnly;

  PricingOptions({
    required this.fareType,
    required this.includedCheckedBagsOnly,
  });

  factory PricingOptions.fromJson(Map<String, dynamic> json) => PricingOptions(
    fareType: List<String>.from(json["fareType"].map((x) => x)),
    includedCheckedBagsOnly: json["includedCheckedBagsOnly"],
  );

  Map<String, dynamic> toJson() => {
    "fareType": List<dynamic>.from(fareType.map((x) => x)),
    "includedCheckedBagsOnly": includedCheckedBagsOnly,
  };
}

class TravelerPricing {
  String travelerId;
  String fareOption;
  String travelerType;
  TravelerPricingPrice price;
  List<FareDetailsBySegment> fareDetailsBySegment;

  TravelerPricing({
    required this.travelerId,
    required this.fareOption,
    required this.travelerType,
    required this.price,
    required this.fareDetailsBySegment,
  });

  factory TravelerPricing.fromJson(Map<String, dynamic> json) => TravelerPricing(
    travelerId: json["travelerId"],
    fareOption: json["fareOption"],
    travelerType: json["travelerType"],
    price: TravelerPricingPrice.fromJson(json["price"]),
    fareDetailsBySegment: List<FareDetailsBySegment>.from(json["fareDetailsBySegment"].map((x) => FareDetailsBySegment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "travelerId": travelerId,
    "fareOption": fareOption,
    "travelerType": travelerType,
    "price": price.toJson(),
    "fareDetailsBySegment": List<dynamic>.from(fareDetailsBySegment.map((x) => x.toJson())),
  };
}

class FareDetailsBySegment {
  String segmentId;
  String cabin;
  String fareBasis;
  String fareDetailsBySegmentClass;
  IncludedCBags includedCheckedBags;
  IncludedCBags includedCabinBags;

  FareDetailsBySegment({
    required this.segmentId,
    required this.cabin,
    required this.fareBasis,
    required this.fareDetailsBySegmentClass,
    required this.includedCheckedBags,
    required this.includedCabinBags,
  });

  factory FareDetailsBySegment.fromJson(Map<String, dynamic> json) => FareDetailsBySegment(
    segmentId: json["segmentId"],
    cabin: json["cabin"],
    fareBasis: json["fareBasis"],
    fareDetailsBySegmentClass: json["class"],
    includedCheckedBags: IncludedCBags.fromJson(json["includedCheckedBags"]),
    includedCabinBags: IncludedCBags.fromJson(json["includedCabinBags"]),
  );

  Map<String, dynamic> toJson() => {
    "segmentId": segmentId,
    "cabin": cabin,
    "fareBasis":fareBasis,
    "class": fareDetailsBySegmentClass,
    "includedCheckedBags": includedCheckedBags.toJson(),
    "includedCabinBags": includedCabinBags.toJson(),
  };
}





class IncludedCBags {
  int quantity;

  IncludedCBags({
    required this.quantity,
  });

  factory IncludedCBags.fromJson(Map<String, dynamic> json) => IncludedCBags(
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
  };
}

class TravelerPricingPrice {
  String currency;
  String total;
  String base;

  TravelerPricingPrice({
    required this.currency,
    required this.total,
    required this.base,
  });

  factory TravelerPricingPrice.fromJson(Map<String, dynamic> json) => TravelerPricingPrice(
    currency: json["currency"],
    total: json["total"],
    base: json["base"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "total": total,
    "base": base,
  };
}

class Dictionaries {
  Locations locations;
  DictionariesAircraft aircraft;
  Currencies currencies;
  Carriers carriers;

  Dictionaries({
    required this.locations,
    required this.aircraft,
    required this.currencies,
    required this.carriers,
  });

  factory Dictionaries.fromJson(Map<String, dynamic> json) => Dictionaries(
    locations: Locations.fromJson(json["locations"]),
    aircraft: DictionariesAircraft.fromJson(json["aircraft"]),
    currencies: Currencies.fromJson(json["currencies"]),
    carriers: Carriers.fromJson(json["carriers"]),
  );

  Map<String, dynamic> toJson() => {
    "locations": locations.toJson(),
    "aircraft": aircraft.toJson(),
    "currencies": currencies.toJson(),
    "carriers": carriers.toJson(),
  };
}

class DictionariesAircraft {
  String the73H;
  String e90;

  DictionariesAircraft({
    required this.the73H,
    required this.e90,
  });

  factory DictionariesAircraft.fromJson(Map<String, dynamic> json) => DictionariesAircraft(
    the73H: json["73H"],
    e90: json["E90"],
  );

  Map<String, dynamic> toJson() => {
    "73H": the73H,
    "E90": e90,
  };
}

class Carriers {
  String kq;

  Carriers({
    required this.kq,
  });

  factory Carriers.fromJson(Map<String, dynamic> json) => Carriers(
    kq: json["KQ"],
  );

  Map<String, dynamic> toJson() => {
    "KQ": kq,
  };
}

class Currencies {
  String eur;

  Currencies({
    required this.eur,
  });

  factory Currencies.fromJson(Map<String, dynamic> json) => Currencies(
    eur: json["EUR"],
  );

  Map<String, dynamic> toJson() => {
    "EUR": eur,
  };
}

class Locations {
  Add add;
  Add nbo;
  Add dxb;

  Locations({
    required this.add,
    required this.nbo,
    required this.dxb,
  });

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
    add: Add.fromJson(json["ADD"]),
    nbo: Add.fromJson(json["NBO"]),
    dxb: Add.fromJson(json["DXB"]),
  );

  Map<String, dynamic> toJson() => {
    "ADD": add.toJson(),
    "NBO": nbo.toJson(),
    "DXB": dxb.toJson(),
  };
}

class Add {
  String cityCode;
  String countryCode;

  Add({
    required this.cityCode,
    required this.countryCode,
  });

  factory Add.fromJson(Map<String, dynamic> json) => Add(
    cityCode: json["cityCode"],
    countryCode: json["countryCode"],
  );

  Map<String, dynamic> toJson() => {
    "cityCode": cityCode,
    "countryCode": countryCode,
  };
}

class Meta {
  int count;
  Links links;

  Meta({
    required this.count,
    required this.links,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    count: json["count"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "links": links.toJson(),
  };
}

class Links {
  String self;

  Links({
    required this.self,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
