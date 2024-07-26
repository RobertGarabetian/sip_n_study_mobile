import 'package:http/http.dart' as http;
import 'dart:convert';

// var key = 'AIzaSyAwCZAjDZMPglia64gsXAB6JQyOqUhu4JM';
var name = 'La La Land Kind Cafe';
Future<http.Response?> fetchAlbum(shopName) async {
  try {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?'
        'fields=rating%2Cphotos%2Cformatted_address'
        '&input=$shopName'
        '&inputtype=textquery'
        '&locationbias=circle%3A16093.4%4034.052235%2C-118.243683'
        '&key=$key'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(shopName);

      if (jsonData['candidates'] != null && jsonData['candidates'].isNotEmpty) {
        var firstResult = jsonData['candidates'][0];
        if (firstResult['photos'] != null && firstResult['photos'].isNotEmpty) {
          var firstPhoto = firstResult['photos'][0];
          var photoResponse = await http.get(Uri.parse(
              'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${firstPhoto['photo_reference']}&key=$key'));

          if (photoResponse.statusCode == 200) {
            return photoResponse;
          } else {
            print('Failed to fetch image: ${photoResponse.statusCode}');
          }
        } else {
          print('No photos found.');
        }
      } else {
        print('No results found.');
      }
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
  return null;
}
