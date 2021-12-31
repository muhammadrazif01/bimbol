import 'dart:convert';

class Testimoni {
  int id;
  String nama;
  String kelas;
  String testimoni;

  Testimoni({
    this.id = 0,
    required this.testimoni,
    required this.nama,
    required this.kelas
  });

  factory Testimoni.fromJson(Map<String, dynamic> json) {
    return Testimoni(
        id: json["id"], 
        nama: json["nama"], 
        kelas: json["kelas"], 
        testimoni: json["testimoni"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "nama": nama, "kelas": kelas, "testimoni": testimoni};
  }

  @override
  String toString() {
    return 'Testimoni{id: $id, nama: $nama, kelas: $kelas, testimoni: $testimoni}';
  }

}

String testimoniToJson(Testimoni data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

List<Testimoni> testimoniFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Testimoni>.from(data.map((item) => Testimoni.fromJson(item)));
  
}

