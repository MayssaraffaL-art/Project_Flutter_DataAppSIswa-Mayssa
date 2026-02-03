class Siswa {
  final String id;
  final String nama;
  final String kelas;
  final String jurusan;

  Siswa({
    required this.id,
    required this.nama,
    required this.kelas,
    required this.jurusan,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      id: json['id'].toString(),
      nama: json['nama'],
      kelas: json['kelas'],
      jurusan: json['jurusan']
    );
  }
}
