import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../screens/user_session_support.dart';

class JadwalModel {
  String id;
  String nama;
  String kelas;
  String hari;
  String link;
  String start;
  String end;
  String desc;

  JadwalModel({
    required this.id,
    required this.nama,
    required this.kelas,
    required this.hari,
    required this.link,
    required this.start,
    required this.end,
    required this.desc,
  });

  factory JadwalModel.fromJson(Map<String, dynamic> json) => JadwalModel(
        id: json['id'].toString(),
        nama: json['title'].toString(),
        kelas: json['kelas'].toString(),
        hari: json['day'].toString(),
        link: json['link'].toString(),
        start: json['start'].toString().substring(0, 5),
        end: json['end'].toString().substring(0, 5),
        desc: json['desc'].toString(),
      );
}

class JadwalUtils {
  List<JadwalModel> _data = [];
  List<JadwalModel> get dataJadwal => _data;
  static bool isGuru = false;

  Future<List<JadwalModel>> connectAPI() async {
    var username = user[0]['username'];
    if (username == null) {
      return _data;
    }

    String url =
        "https://tk-pbp-a01.herokuapp.com/jadwal/api/get/username/$username/";
    var response = await http.get(Uri.parse(url));
    // print(response.body);
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body).cast<Map<String, dynamic>>();
      _data = jsonObject
          .map<JadwalModel>((json) => JadwalModel.fromJson(json))
          .toList();
      isGuru = true;
      return _data;
    }
    return _data; //data kosong
  }

  Future<bool> postJadwal(String nama, String kelas, String hari, String link,
      String start, String end, String desc) async {
    var username = user[0]['username'];
    if (username == null) {
      return false;
    }
    const url = 'https://tk-pbp-a01.herokuapp.com/jadwal/api/create/';
    final response = await http.post(Uri.parse(url), body: {
      "day": hari,
      "start": start,
      "end": end,
      "link": link,
      "kelas": kelas,
      "title": nama,
      "desc": desc,
      "guru": username, //user.request
    });

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<JadwalModel> findJadwal(String id) async {
    String url = "https://tk-pbp-a01.herokuapp.com/jadwal/api/get/$id/";
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> jadwalMap = jsonDecode(response.body);
    var data = JadwalModel.fromJson(jadwalMap);
    return data;
  }

  Future<bool> putJadwal(String id, String nama, String kelas, String hari,
      String link, String start, String end, String desc) async {
    var username = user[0]['username'];
    if (username == null) {
      return false;
    }
    final url = 'https://tk-pbp-a01.herokuapp.com/jadwal/api/update/$id/';
    final response = await http.post(Uri.parse(url), body: {
      "day": hari,
      "start": start,
      "end": end,
      "link": link,
      "kelas": kelas,
      "title": nama,
      "desc": desc,
      "guru": username //user.request
    });

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
