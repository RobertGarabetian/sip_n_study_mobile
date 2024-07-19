import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: 'https://dacwjwehhdquvsmwfffl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhY3dqd2VoaGRxdXZzbXdmZmZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTU0ODkwNzIsImV4cCI6MjAzMTA2NTA3Mn0.OH2sPgLxtdaUg196tDNAw2AJwUMn_JvdBUF7gayqxlg',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Coffee Shops',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = Supabase.instance.client.from('coffee_shops').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final coffee_shops = snapshot.data!;
          return ListView.separated(
            itemCount: coffee_shops.length,
            itemBuilder: ((BuildContext context, int index) {
              final coffee_shop = coffee_shops[index];
              return ListTile(
                title: Text(
                  coffee_shop['name'],
                  style: TextStyle(
                    color: Colors.blue, // Change the text color here
                    fontSize: 24, // Optional: Change the font size
                  ),
                ),
                tileColor: Colors.white,
                trailing: Text(
                  "${coffee_shop['sip_score']}",
                  style: TextStyle(
                    color: Colors.purple[300],
                    fontSize: 18,
                  ),
                ),
              );
            }),
            separatorBuilder: (BuildContext context, int index) =>
                Divider(color: Colors.amber[400]),
          );
        },
      ),
    );
  }
}
