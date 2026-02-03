<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST *");

include 'koneksi.php';

$nama = $_POST['nama'] ?? '';
$kelas = $_POST['kelas'] ?? '';
$jurusan = $_POST['jurusan'] ?? '';

if ($nama == '' || $kelas == '' || $jurusan == '') {
    echo json_encode([
    "status" => false,
    "pesan" => "Data tidak lengkap " 
    ]);
    exit;
}

$query = "INSERT INTO siswa (nama, kelas, jurusan)
VALUES ('$nama','$kelas','$jurusan')";

 if ($koneksi->query($query)) {
    echo json_encode([
    "status" => true,
    "pesan" => "Data berhasil ditambahkan " 
    ]);
 } else {
    echo json_encode([
    "status" => false,
    "pesan" => $koneksi->error 
    ]);
 }
?>
