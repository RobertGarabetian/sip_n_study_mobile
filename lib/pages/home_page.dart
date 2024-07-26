import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import '../services/google_request.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = SupabaseService.getCoffeeShops();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final coffee_shops = snapshot.data!;
          return ListView.builder(
            itemCount: coffee_shops.length,
            itemBuilder: ((BuildContext context, int index) {
              final coffee_shop = coffee_shops[index];
              return Container(
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width *
                    0.9, // 90% of screen width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Text(
                    coffee_shop['name'],
                    style: TextStyle(
                      color: Colors.grey[800], // Change the text color here
                      fontSize: 24, // Optional: Change the font size
                    ),
                  ),
                  tileColor: Colors.white,
                  trailing: FutureBuilder<http.Response?>(
                    future: fetchAlbum(coffee_shop['name']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data == null) {
                        return Text('Failed to load image');
                      } else {
                        final imageBytes = snapshot.data!.bodyBytes;
                        return Image.memory(imageBytes);
                      }
                    },
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
