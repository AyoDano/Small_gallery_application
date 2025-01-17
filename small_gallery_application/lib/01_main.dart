import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GalleryApp(),
    );
  }
}

class GalleryApp extends StatefulWidget {
  const GalleryApp({super.key});

  @override
  _GalleryAppState createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const GalleryScreen(),
    const Center(child: Text("About Me")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gallery",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera),
            label: "Gallery",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "About Me",
          ),
        ],
      ),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
        children: [
          CustomCard(
            title: "Colourful Basketball",
            imagePath: "assets/images/basketball_1.jpeg",
            description:
                "A colourful outdoor basketball court. In the centre is a basketball hoop, its white net swaying in the gentle breeze. The colours of the court glow under the warm evening sun. Many years ago, during a summer evening, friends met here for an unforgettable game in which the winners cheered the sunset.",
            date: "03.06.2023",
            context: context,
          ),
          CustomCard(
            title: "Watch out for bends",
            imagePath: "assets/images/bike.jpeg",
            description:
                "A large group of racing cyclists lean into a sharp bend in synchronisation as they race along the track at an impressive speed. The riders' colourful jerseys glow in the sunshine and their concentration is palpable. A few years ago, during an exciting competition on a sunny spring day, this bend marked the turning point of the race and became the scene of a thrilling duel for the top spot.",
            date: "18.06.2022",
            context: context,
          ),
          CustomCard(
            title: "Watch out for bends",
            imagePath: "assets/images/bike.jpeg",
            description:
                "A large group of racing cyclists lean into a sharp bend in synchronisation as they race along the track at an impressive speed. The riders' colourful jerseys glow in the sunshine and their concentration is palpable. A few years ago, during an exciting competition on a sunny spring day, this bend marked the turning point of the race and became the scene of a thrilling duel for the top spot.",
            date: "18.06.2022",
            context: context,
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final String date;
  final BuildContext context; // Der Kontext für die Navigation

  const CustomCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.date,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Wenn die Karte getippt wird, öffne die Detailseite und übergebe die Daten
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              title: title,
              imagePath: imagePath,
              description: description,
              date: date,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final String date;

  const DetailPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Titel der Detailseite
        leading: IconButton(
          icon: const Icon(
              Icons.chevron_left), // Chevron-Icon für den Zurück-Button
          onPressed: () {
            Navigator.pop(
                context); // Führt dazu, dass die Detailseite geschlossen wird
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                date, // Das übergebene Datum wird hier angezeigt
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                description, // Die individuelle Beschreibung wird hier angezeigt
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
