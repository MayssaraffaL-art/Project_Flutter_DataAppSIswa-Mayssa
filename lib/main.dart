
import 'package:data_siswa_app/halaman/halaman_siswa.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Siswa',
      debugShowCheckedModeBanner: false,
      home: HalamanSiswa(),
    );
  }
}

