import '../testimoni/models/testimoni.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String url = "https://tk-pbp-a01.herokuapp.com";

  Future<List<Testimoni>> getTesti() async {
    final response = await http.get(Uri.parse("$url/testimoni/json"));
    // if (response.statusCode == 200) {
    return testimoniFromJson(response.body);
    // }
  }

  Future<bool> createTestimoni(Testimoni data) async {
    final response = await http.post( Uri.parse("$url/testimoni/json"),
      headers: {"content-type": "application/json"},
      body: testimoniToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTestimoni(Testimoni data) async {
    final response = await http.put( Uri.parse("$url/testimoni/${data.id}/json"),
      headers: {"content-type": "application/json"},
      body: testimoniToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteTestimoni(int id) async {
    final response = await http.delete( Uri.parse("$url/testimoni/$id/json"),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
