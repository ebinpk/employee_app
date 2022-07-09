class CompanyModel{

  int? nEmployeeId;
  String? cName;
  String? cCatchPhrase;
  String? cBs;

  CompanyModel({
    this.nEmployeeId,
    this.cName,
    this.cCatchPhrase,
    this.cBs,
  }) ;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'cName': cName,
      'cCatchPhrase': cCatchPhrase,
      'cBs':cBs
    };
    if (nEmployeeId != null) {
      map['nEmployeeId'] = nEmployeeId;
    }
    return map;
  }



}
class AddressModel{

  int? nEmployeeId;
  String? street;
  String? suite;
  String? city;
  String? zipcode;


  AddressModel({
    this.nEmployeeId,
    this.street,
    this.suite,
    this.city,
    this.zipcode
  }) ;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'street': street,
      'suite': suite,
      'city':city,
      'zipcode':zipcode,
    };
    if (nEmployeeId != null) {
      map['nEmployeeId'] = nEmployeeId;
    }
    return map;
  }

}
class EmployeeHdrModel {

  int? nEmployeeId;
  String? name;
  String? username;
  String? email;
  String? profileImage;
  dynamic phone;
  String? website;


  EmployeeHdrModel({
    this.nEmployeeId,
    this.name,
    this.username,
    this.email,
    this.profileImage,
    this.phone,
    this.website,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'username': username,
      'email': email,
      'profileImage': profileImage,
      'phone': phone,
      'website': website
    };
    if (nEmployeeId != null) {
      map['nEmployeeId'] = nEmployeeId;
    }
    return map;
  }
}

class GeoLocationModel{

  int? nEmployeeId;
  String? lat;
  String? lng;

  GeoLocationModel({
    this.nEmployeeId,
    this.lat,
    this.lng,

  }) ;

  Map<String, dynamic> toMap() {
  var map = <String, dynamic>{
  'lat': lat,
  'lng': lng

  };
  if (nEmployeeId != null) {
  map['nEmployeeId'] = nEmployeeId;
  }
  return map;
  }
}





class ListDataModel {

  int? nEmployeeId;
  String? name;
  String? profileImage;
  String? companyName;


  ListDataModel({
    this.nEmployeeId,
    this.name,
   this.companyName,
    this.profileImage,

  });

  ListDataModel.fromMap(Map<String, dynamic> map) {
    nEmployeeId = map['nEmployeeId'];
    name = map['name'];
    profileImage = map['profileImage'];
    companyName = map['companyName'];
  }
}


class DetailsModel {

  String? name;
  String? username;
  String? email;
  String? profileImage;
  dynamic phone;
  String? website;
  String? companyName;
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  String? cCatchPhrase;
  String? cBs;


  DetailsModel({
    this.name,
    this.companyName,
    this.profileImage,
    this.username,
    this.phone,this.website,
    this.email,this.street,this.suite,this.zipcode,this.city,this.cBs,this.cCatchPhrase

  });

  DetailsModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    profileImage = map['profileImage'];
    companyName = map['companyName'];
    username = map['username'];
    phone = map['phone'];
    website = map['website'];
    email = map['email'];
    street = map['street'];
    suite = map['suite'];
    zipcode = map['zipcode'];
    city = map['city'];
    cBs = map['cBs'];
    cCatchPhrase = map['cCatchPhrase'];
  }
}