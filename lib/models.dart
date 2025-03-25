class Supplier {
  final String name;
  final String description;
  final String phone;
  final String email;
  final String imageUrl;
  final String details; // Добавлено поле details

  Supplier({
    required this.name,
    required this.description,
    required this.phone,
    required this.email,
    required this.imageUrl,
    required this.details, // Добавлено поле details
  });
}

class Contractor {
  final String name;
  final String description;
  final String phone;
  final String email;
  final String imageUrl;
  final String details; // Добавлено поле details

  Contractor({
    required this.name,
    required this.description,
    required this.phone,
    required this.email,
    required this.imageUrl,
    required this.details, // Добавлено поле details
  });
}

class Service {
  final String title;
  final String imageUrl;
  final String description;

  Service({
    required this.title,
    required this.imageUrl,
    required this.description,
  });
}