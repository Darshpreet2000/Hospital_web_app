class hospital {
  final String charge_type;
  final String DateUpdated;
  final String description;
  final String name;
  final String price;

  hospital({this.DateUpdated, this.charge_type, this.description,this.name,this.price});
  List<hospital> current;

  factory hospital.fromJson(Map<String, dynamic> json) {
   return hospital(
       charge_type: json['charge_type'],
       DateUpdated: json['DateUpdated'],
       description: json['description'],
       name: json['name'],
       price: json['price']
   );;
  }
}