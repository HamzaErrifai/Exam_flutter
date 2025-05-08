import 'package:flutter/material.dart';
import 'movies_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    //SingleMovieScreen(selectedMovie: movies[0]),
    MovieListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Movie App', home: MovieListScreen());
  }
}
/*
class SingleMovieScreen extends StatefulWidget {
  final Map<String, String> selectedMovie;

  const SingleMovieScreen({Key? key, required this.selectedMovie})
      : super(key: key);

  @override
  _SingleMovieScreenState createState() => _SingleMovieScreenState();
}

class _SingleMovieScreenState extends State<SingleMovieScreen> {
  late Map<String, String> selectedMovie;

  @override
  void initState() {
    super.initState();
    // Initialize with the passed movie.
    selectedMovie = widget.selectedMovie;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Sélectionné'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                selectedMovie['image']!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              selectedMovie['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              selectedMovie['description']!,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
*/

class SingleMovieScreen extends StatefulWidget {
  final Map<String, String>? selectedMovie; // Make this nullable for dropdown

  SingleMovieScreen({Key? key, this.selectedMovie}) : super(key: key);

  @override
  _SingleMovieScreenState createState() => _SingleMovieScreenState();
}

class _SingleMovieScreenState extends State<SingleMovieScreen> {
  late Map<String, String> selectedMovie;

  @override
  void initState() {
    super.initState();
    // Use the passed movie if available; otherwise, default to the first movie
    selectedMovie = widget.selectedMovie ?? movies[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Film Sélectionné')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown menu
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
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              selectedMovie['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              selectedMovie['description']!,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}



class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Films Populaires'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns for the grid.
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.65, // Adjust aspect ratio as needed.
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the SingleMovieScreen with the tapped movie.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SingleMovieScreen(selectedMovie: movie),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
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
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
