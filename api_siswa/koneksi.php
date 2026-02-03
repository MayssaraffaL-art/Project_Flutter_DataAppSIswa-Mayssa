<?php
$koneksi = new mysqli("localhost", "root", "", "db_sekolah");

if ($koneksi->connect_error) {
    die(json_encode ([
    "status" => false,
    "pesan" => "Koneksi database gagal " ]));
}
?>
