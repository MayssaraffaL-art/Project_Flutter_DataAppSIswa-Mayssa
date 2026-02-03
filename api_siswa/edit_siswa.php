<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST *");

include 'koneksi.php';

$id = $_POST['id'] ?? '';
$nama = $_POST['nama'] ?? '';
$kelas = $_POST['kelas'] ?? '';
$jurusan = $_POST['jurusan'] ?? '';

if ($id =='' || $nama == '' || $kelas == '' || $jurusan == '') {
    echo json_encode([
    "status" => false,
    "pesan" => "Data tidak lengkap " 
    ]);
    exit;
}

$query = "UPDATE siswa SET 
            nama='$nama',
            kelas='$kelas',
            jurusan='$jurusan'
            WHERE id='$id'";

 if ($koneksi->query($query)) {
    echo json_encode([
    "status" => true,
    "pesan" => "Data berhasil diupdate " 
    ]);
 } else {
    echo json_encode([
    "status" => false,
    "pesan" => $koneksi->error 
    ]);
 }
?>