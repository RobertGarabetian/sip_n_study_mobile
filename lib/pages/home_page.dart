import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

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
                  trailing: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      // Handle button press
                      print('ElevatedButton Pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
