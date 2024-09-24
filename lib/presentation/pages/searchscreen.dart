import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quad/presentation/pages/detailscreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> searchResults = [];

  Future<void> searchShows(String query) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onSubmitted: searchShows,
          decoration: const InputDecoration(
            hintText: 'Search for TV shows',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final show = searchResults[index]['show'];
          return Card(
            color: Colors.grey[850],
            child: ListTile(
              leading: show['image'] != null
                  ? Image.network(
                      show['image']['medium'],
                      width: 50,
                      height: 75,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 50,
                      height: 75,
                      color: Colors.black,
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.white),
                    ),
              title: Text(show['name'],
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(
                show['genres'].join(', '),
                style: const TextStyle(color: Colors.white70),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(show: show),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
