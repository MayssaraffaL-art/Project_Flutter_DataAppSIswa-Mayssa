<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST *");

include 'koneksi.php';

$id = $_POST['id'] ?? '';

if ($id =='') {
    echo json_encode([
    "status" => false,
    "pesan" => "Data tidak ditemukan " 
    ]);
    exit;
}

$query = "DELETE FROM siswa WHERE id='$id'";

 if ($koneksi->query($query)) {
    echo json_encode([
    "status" => true,
    "pesan" => "Data berhasil dihapus " 
    ]);
 } else {
    echo json_encode([
    "status" => false,
    "pesan" => $koneksi->error 
    ]);
 }
?>