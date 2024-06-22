class Disaster {
  final int id;
  final String name;
  final String description;
  final String date;
  final String location;

  Disaster({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date,
      'location': location,
    };
  }

  factory Disaster.fromJson(Map<String, dynamic> json) {
    return Disaster(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: json['date'],
      location: json['location'],
    );
  }
}
