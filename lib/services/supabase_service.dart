import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://dacwjwehhdquvsmwfffl.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhY3dqd2VoaGRxdXZzbXdmZmZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTU0ODkwNzIsImV4cCI6MjAzMTA2NTA3Mn0.OH2sPgLxtdaUg196tDNAw2AJwUMn_JvdBUF7gayqxlg',
    );
  }

  static Future<List<dynamic>> getCoffeeShops() async {
    final response =
        await Supabase.instance.client.from('coffee_shops').select();

    return response as List<dynamic>;
  }
}
