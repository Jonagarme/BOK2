class Client {
  String id;
  String name;
  String cedula;
  String phoneNumber;
  String address;
  String city;
  String email;
  bool isActive;
  DateTime registrationDate;

  Client({
    required this.id,
    required this.name,
    required this.cedula,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.email,
    required this.isActive,
    required this.registrationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cedula': cedula,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'email': email,
      'isActive': isActive,
      'registrationDate': registrationDate.toIso8601String(),
    };
  }

  static Client fromMap(Map<String, dynamic> map, String id) {
    return Client(
      id: id,
      name: map['name'],
      cedula: map['cedula'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      city: map['city'],
      email: map['email'],
      isActive: map['isActive'],
      registrationDate: DateTime.parse(map['registrationDate']),
    );
  }
}
