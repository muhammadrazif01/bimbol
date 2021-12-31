import 'dart:convert';
import 'package:http/http.dart' as http;

class JadwalModel {
  String id;
  String nama;
  String kelas;
  String hari;
  String link;
  String start;
  String end;
  String desc;

  //BUAT CONSTRUCTOR AGAR KETIKA CLASS INI DILOAD, MAKA DATA YANG DIMINTA HARUS DIPASSING SESUAI TIPE DATA YANG DITETAPKAN
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

  //FUNGSI INI UNTUK MENGUBAH FORMAT DATA DARI JSON KE FORMAT YANG SESUAI DENGAN EMPLOYEE MODEL
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

  Future<List<JadwalModel>> connectAPI() async {
    String url = "https://tk-pbp-a01.herokuapp.com/jadwal/api/get/";
    var response = await http.get(Uri.parse(url));
    // print(response.body);
    var jsonObject = json.decode(response.body).cast<Map<String, dynamic>>();
    _data = jsonObject
        .map<JadwalModel>((json) => JadwalModel.fromJson(json))
        .toList();
    // print(_data);
    //   var tmp = JadwalModel(
    //   id: jsonObject[0]['pk'].toString(),
    //   nama: jsonObject[0]['fields']['title'].toString(),
    //   kelas: jsonObject[0]['fields']['kelas'].toString(),
    //   hari: jsonObject[0]['fields']['day'].toString(),
    //   link: jsonObject[0]['fields']['link'].toString()
    // );
    // print(tmp);
    return _data;

    // return JadwalModel.fromJson(jsonObject);
    // final result = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
    // print(result);
    //KEMUDIAN MAPPING DATANYA UNTUK KEMUDIAN DIUBAH FORMATNYA SESUAI DENGAN EMPLOYEEMODEL DAN DIPASSING KE DALAM VARIABLE _DATA
    // return result.map<JadwalModel>((json) => JadwalModel.fromJson(json)).toList();
  }

  Future<bool> postJadwal(String nama, String kelas, String hari, String link,
    String start, String end, String desc) async {
    const url = 'https://tk-pbp-a01.herokuapp.com/jadwal/api/create/';
    //KIRIM REQUEST KE SERVER DENGAN MENGIRIMKAN DATA YANG AKAN DITAMBAHKAN PADA BODY
    final response = await http.post(Uri.parse(url), body: {
      "day": hari,
      "start": start,
      "end": end,
      "link": link,
      "kelas": kelas,
      "title": nama,
      "desc": desc,
      "guru": "1" //user.request
    });

    //DECODE RESPONSE YANG DITERIMA

    // print(result);
    //LAKUKAN PENGECEKAN, JIKA STATUS CODENYA 200 DAN STATUS SUCCESS
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

  Future<bool> putJadwal(String id, String nama, String kelas, String hari, String link,
      String start, String end, String desc) async {
    final url = 'https://tk-pbp-a01.herokuapp.com/jadwal/api/update/$id/';
    //KIRIM REQUEST KE SERVER DENGAN MENGIRIMKAN DATA YANG AKAN DITAMBAHKAN PADA BODY
    final response = await http.post(Uri.parse(url), body: {
      "day": hari,
      "start": start,
      "end": end,
      "link": link,
      "kelas": kelas,
      "title": nama,
      "desc": desc,
      "guru": "1" //user.request
    });

    //DECODE RESPONSE YANG DITERIMA

    // print(result);
    //LAKUKAN PENGECEKAN, JIKA STATUS CODENYA 200 DAN STATUS SUCCESS
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
