import 'dart:convert';
import 'package:data_siswa_app/model/siswa.dart';
import "package:http/http.dart" as http;

class ApiService {
  static const String baseUrl = "http://localhost/api_siswa/";

  //READ
  static Future<List<Siswa>> getSiswa() async {
    final response = await http.get(
      Uri.parse("${baseUrl}get_siswa.php"),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Siswa.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data siswa");
    }
  }

  //CREATE
  static Future<void> tambahSiswa(
    String nama,
    String kelas,
    String jurusan,
  ) async {
    final response = await http.post(
      Uri.parse("${baseUrl}tambah_siswa.php"),
      body: {
        "nama": nama,
        "kelas": kelas,
        "jurusan": jurusan,
      },
    );

    print("TAMBAH RESPONSE: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Gagal menambahkan data");
    }
  }

  //UPDATE
  static Future<void> editSiswa(
    String id,
    String nama,
    String kelas,
    String jurusan,
  ) async {
    final response = await http.post(
      Uri.parse("${baseUrl}edit_siswa.php"),
      body: {
        "id": id,
        "nama": nama,
        "kelas": kelas,
        "jurusan": jurusan,
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal mengedit data");
    }
  }

  //DELETE
  static Future<void> hapusSiswa(String id) async {
    final response = await http.post(
      Uri.parse("${baseUrl}hapus_siswa.php"),
      body: {"id": id},
    );

    print("HAPUS RESPONSE: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Gagal menghapus data");
    }
  }
}
