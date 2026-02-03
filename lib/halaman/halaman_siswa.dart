import 'package:data_siswa_app/model/siswa.dart';
import 'package:data_siswa_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'; // Tambahkan package ini untuk animasi staggered

import 'tambah_siswa.dart';
import 'edit_siswa.dart';

class HalamanSiswa extends StatefulWidget {
  const HalamanSiswa({super.key});

  @override
  State<HalamanSiswa> createState() => _HalamanSiswaState();
}

class _HalamanSiswaState extends State<HalamanSiswa> {
  late Future<List<Siswa>> daftarSiswa;

  void refreshData() {
    setState(() {
      daftarSiswa = ApiService.getSiswa();
    });
  }

  @override
  void initState() {
    super.initState();
    daftarSiswa = ApiService.getSiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.black, // Primary hitam
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          accentColor: Colors.black,
        ).copyWith(
          secondary: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.white, // Background putih
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data Siswa'),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TambahSiswa()),
            );
            refreshData();
          },
        ),
        body: FutureBuilder<List<Siswa>>(
          future: daftarSiswa,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Terjadi Error:\n${snapshot.error}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[800]),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "Data Siswa Belum Tersedia",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return AnimationLimiter(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final siswa = snapshot.data![index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Card(
                          elevation: 8,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              siswa.nama,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              "${siswa.kelas} - ${siswa.jurusan}",
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.black),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditSiswa(siswa: siswa),
                                      ),
                                    );
                                    refreshData();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.black),
                                  onPressed: () async {
                                    final konfirmasi = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        title: Text(
                                          "Konfirmasi Hapus",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        content: Text(
                                          "Apakah Anda yakin ingin menghapus data ${siswa.nama}?",
                                          style: TextStyle(color: Colors.grey[700]),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text(
                                              "Batal",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            onPressed: () => Navigator.pop(context, false),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white, // Background putih
                                              foregroundColor: Colors.black, // Teks hitam
                                              side: BorderSide(color: Colors.black, width: 2), // Border hitam
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text("Hapus"),
                                            onPressed: () => Navigator.pop(context, true),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (konfirmasi == true) {
                                      await ApiService.hapusSiswa(siswa.id);
                                      refreshData();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}