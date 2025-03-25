import 'package:flutter/material.dart';
import 'models.dart';
import 'search_delegate.dart';

void main() {
  runApp(const ConstructionApp());
}

class ConstructionApp extends StatefulWidget {
  const ConstructionApp({super.key});

  @override
  _ConstructionAppState createState() => _ConstructionAppState();
}

class _ConstructionAppState extends State<ConstructionApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Строительство: Поставщики и подрядчики',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(toggleTheme: toggleTheme),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Function toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Service> services = [
    Service(
      title: 'Строительство домов',
      imageUrl: 'assets/images/1.jpg',
      description:
          'Мы строим дома любой сложности — от небольших коттеджей до многоэтажных жилых комплексов.',
    ),
    Service(
      title: 'Ремонт и отделка',
      imageUrl: 'assets/images/2.jpg',
      description:
          'Предоставляем услуги по ремонту и отделке помещений. Качественные материалы и индивидуальный подход.',
    ),
    Service(
      title: 'Электромонтажные работы',
      imageUrl: 'assets/images/3.jpg',
      description:
          'Профессиональный монтаж электрических сетей, установка оборудования и гарантия безопасности.',
    ),
  ];

  final List<String> carouselImages = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Строительные услуги'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCarousel(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Наши услуги',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return _buildServiceCard(services[index], context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Поставщики',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.engineering),
            label: 'Подрядчики',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SuppliersScreen(toggleTheme: widget.toggleTheme)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContractorsScreen(toggleTheme: widget.toggleTheme)),
            );
          }
        },
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: carouselImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                carouselImages[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(Service service, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceDetailScreen(service: service),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  service.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceDetailScreen extends StatefulWidget {
  final Service service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                widget.service.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.service.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.service.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 30),
            Text(
              'Оставить заявку',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Ваше имя',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите ваше имя';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Телефон',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите ваш телефон';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите ваш email';
                      }
                      if (!value.contains('@')) {
                        return 'Введите корректный email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Сообщение',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.message),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _submitForm();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Отправить заявку',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    // Здесь можно добавить логику отправки данных на сервер
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Заявка успешно отправлена!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}

class SuppliersScreen extends StatelessWidget {
  final Function toggleTheme;

  const SuppliersScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final List<Supplier> suppliers = [
      Supplier(
        name: 'Компания "СтройМатериалы"',
        description: 'Поставка бетона, кирпича, арматуры',
        phone: '+7 (999) 123-45-67',
        email: 'info@stroymat.ru',
        imageUrl: 'assets/images/2.jpg',
        details:
            'Мы занимаемся поставкой строительных материалов уже более 10 лет.',
      ),
      Supplier(
        name: 'Компания "ЭлектроСеть"',
        description: 'Электромонтажные работы',
        phone: '+7 (999) 987-65-43',
        email: 'info@electroset.ru',
        imageUrl: 'assets/images/3.jpg',
        details:
            'Наша компания специализируется на электромонтажных работах любой сложности.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Поставщики'),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () {
              toggleTheme();
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: suppliers.length,
        itemBuilder: (context, index) {
          return _buildSupplierCard(suppliers[index], context);
        },
      ),
    );
  }

  Widget _buildSupplierCard(Supplier supplier, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SupplierDetailScreen(supplier: supplier),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  supplier.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplier.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      supplier.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class SupplierDetailScreen extends StatelessWidget {
  final Supplier supplier;

  const SupplierDetailScreen({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(supplier.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  supplier.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              supplier.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              supplier.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'О компании:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              supplier.details,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Контакты',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildContactItem(Icons.phone, supplier.phone),
                    const SizedBox(height: 8),
                    _buildContactItem(Icons.email, supplier.email),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RequestFormScreen(
                                title: 'Заявка поставщику',
                                recipient: supplier.name,
                              ),
                            ),
                          );
                        },
                        child: const Text('Оставить заявку'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class ContractorsScreen extends StatelessWidget {
  final Function toggleTheme;

  const ContractorsScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final List<Contractor> contractors = [
      Contractor(
        name: 'ООО "СтройГарант"',
        description: 'Строительство жилых комплексов',
        phone: '+7 (999) 765-43-21',
        email: 'info@stroygarant.ru',
        imageUrl: 'assets/images/5.jpg',
details: 'Мы строим жилые комплексы под ключ.',
),
Contractor(
name: 'ИП Иванов',
description: 'Отделочные работы',
phone: '+7 (999) 111-22-33',
email: 'info@ivanov.ru',
imageUrl: 'assets/images/4.jpg',
details: 'Мы предлагаем услуги по отделке помещений любой сложности.',
),
];


return Scaffold(
  appBar: AppBar(
    title: const Text('Подрядчики'),
    actions: [
      IconButton(
        icon: Icon(
          Theme.of(context).brightness == Brightness.dark
              ? Icons.light_mode
              : Icons.dark_mode,
          color: Colors.white,
        ),
        onPressed: () {
          toggleTheme();
        },
      ),
    ],
  ),
  body: ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: contractors.length,
    itemBuilder: (context, index) {
      return _buildContractorCard(contractors[index], context);
    },
  ),
);
}

Widget _buildContractorCard(Contractor contractor, BuildContext context) {
return Card(
margin: const EdgeInsets.only(bottom: 16),
elevation: 4,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),
child: InkWell(
borderRadius: BorderRadius.circular(16),
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => ContractorDetailScreen(contractor: contractor),
),
);
},
child: Padding(
padding: const EdgeInsets.all(16),
child: Row(
children: [
ClipRRect(
borderRadius: BorderRadius.circular(12),
child: Image.asset(
contractor.imageUrl,
width: 80,
height: 80,
fit: BoxFit.cover,
),
),
const SizedBox(width: 16),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
contractor.name,
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
const SizedBox(height: 8),
Text(
contractor.description,
style: TextStyle(
color: Colors.grey[600],
),
),
],
),
),
const Icon(Icons.chevron_right),
],
),
),
),
);
}
}

class ContractorDetailScreen extends StatelessWidget {
final Contractor contractor;

const ContractorDetailScreen({super.key, required this.contractor});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(contractor.name),
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Center(
child: ClipRRect(
borderRadius: BorderRadius.circular(16),
child: Image.asset(
contractor.imageUrl,
height: 200,
width: double.infinity,
fit: BoxFit.cover,
),
),
),
const SizedBox(height: 20),
Text(
contractor.name,
style: Theme.of(context).textTheme.headlineSmall?.copyWith(
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
Text(
contractor.description,
style: Theme.of(context).textTheme.bodyLarge,
),
const SizedBox(height: 16),
Text(
'О компании:',
style: Theme.of(context).textTheme.titleLarge?.copyWith(
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 8),
Text(
contractor.details,
style: Theme.of(context).textTheme.bodyLarge,
),
const SizedBox(height: 20),
Card(
elevation: 4,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),
child: Padding(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Контакты',
style: Theme.of(context).textTheme.titleLarge?.copyWith(
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 12),
_buildContactItem(Icons.phone, contractor.phone),
const SizedBox(height: 8),
_buildContactItem(Icons.email, contractor.email),
const SizedBox(height: 16),
SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => RequestFormScreen(
title: 'Заявка подрядчику',
recipient: contractor.name,
),
),
);
},
child: const Text('Оставить заявку'),
),
),
],
),
),
),
],
),
),
);
}

Widget _buildContactItem(IconData icon, String text) {
return Row(
children: [
Icon(icon, size: 20, color: Colors.blue),
const SizedBox(width: 8),
Text(
text,
style: const TextStyle(fontSize: 16),
),
],
);
}
}

class RequestFormScreen extends StatefulWidget {
final String title;
final String recipient;

const RequestFormScreen({
super.key,
required this.title,
required this.recipient,
});

@override
_RequestFormScreenState createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
final _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _messageController = TextEditingController();

bool _isLoading = false;

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(widget.title),
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Заявка для: ${widget.recipient}',
style: Theme.of(context).textTheme.titleLarge?.copyWith(
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 20),
TextFormField(
controller: _nameController,
decoration: const InputDecoration(
labelText: 'Ваше имя',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.person),
),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Пожалуйста, введите ваше имя';
}
return null;
},
),
const SizedBox(height: 16),
TextFormField(
controller: _phoneController,
decoration: const InputDecoration(
labelText: 'Телефон',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.phone),
),
keyboardType: TextInputType.phone,
validator: (value) {
if (value == null || value.isEmpty) {
return 'Пожалуйста, введите ваш телефон';
}
return null;
},
),
const SizedBox(height: 16),
TextFormField(
controller: _emailController,
decoration: const InputDecoration(
labelText: 'Email',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.email),
),
keyboardType: TextInputType.emailAddress,
validator: (value) {
if (value == null || value.isEmpty) {
return 'Пожалуйста, введите ваш email';
}
if (!value.contains('@')) {
return 'Введите корректный email';
}
return null;
},
),
const SizedBox(height: 16),
TextFormField(
controller: _messageController,
decoration: const InputDecoration(
labelText: 'Сообщение',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.message),
),
maxLines: 5,
),
const SizedBox(height: 24),
SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: _isLoading
? null
: () {
if (_formKey.currentState!.validate()) {
_submitForm();
}
},
style: ElevatedButton.styleFrom(
padding: const EdgeInsets.symmetric(vertical: 16),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
),
child: _isLoading
? const CircularProgressIndicator(
color: Colors.white,
)
: const Text(
'Отправить заявку',
style: TextStyle(fontSize: 16),
),
),
),
],
),
),
),
);
}

Future<void> _submitForm() async {
setState(() {
_isLoading = true;
});

// Здесь можно добавить логику отправки данных на сервер
await Future.delayed(const Duration(seconds: 2));

setState(() {
  _isLoading = false;
});

if (mounted) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Заявка успешно отправлена!'),
      backgroundColor: Colors.green,
    ),
  );

  Navigator.pop(context);
}
}

@override
void dispose() {
_nameController.dispose();
_phoneController.dispose();
_emailController.dispose();
_messageController.dispose();
super.dispose();
}
}