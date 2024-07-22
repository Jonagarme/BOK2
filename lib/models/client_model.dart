class Client {
  String id;
  String name;
  String cedula;
  DateTime registrationDate;

  Client(
      {required this.id,
      required this.name,
      required this.cedula,
      required this.registrationDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cedula': cedula,
      'registrationDate': registrationDate.toIso8601String(),
    };
  }

  static Client fromMap(Map<String, dynamic> map, String id) {
    return Client(
      id: id,
      name: map['name'],
      cedula: map['cedula'],
      registrationDate: DateTime.parse(map['registrationDate']),
    );
  }
}
