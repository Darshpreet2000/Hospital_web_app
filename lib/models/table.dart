class table {
  final String name;

  table({this.name});

  factory table.fromJson(Map<String, dynamic> json) {
    return table(
        name: json['TABLE_NAME']
    );
  }
}