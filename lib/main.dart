import 'package:flutter/material.dart';
import 'movies_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    const SingleMovieScreen(),
    const MovieListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Movie App',
      home: Scaffold(
        /*appBar: AppBar(
          title: Text('Flutter Movie App'),
        ),*/
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Single Movie',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Movie List',
            ),
          ],
        ),
      ),
    );
  }
}

class SingleMovieScreen extends StatefulWidget {
  const SingleMovieScreen({super.key});

  @override
  _SingleMovieScreenState createState() => _SingleMovieScreenState();
}

class _SingleMovieScreenState extends State<SingleMovieScreen> {
  late Map<String, String> selectedMovie;

  @override
  void initState() {
    super.initState();
    selectedMovie = movies[0]; // default to first movie
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Film Sélectionné'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<Map<String, String>>(
              value: selectedMovie,
              isExpanded: true,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedMovie = value;
                  });
                }
              },
              items: movies.map((movie) {
                return DropdownMenuItem<Map<String, String>>(
                  value: movie,
                  child: Text(movie['title']!),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                selectedMovie['image']!,
                width: double.infinity,
                //height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              selectedMovie['title']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              selectedMovie['description']!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films Populaires'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // two columns
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.65, // for poster shape
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      movie['image']!,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      movie['title']!,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
