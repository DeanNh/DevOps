# Sentra Digital Batam - Layanan Contoh DevOps

Artefak praktikum mata kuliah DevOps, Politeknik Negeri Batam.

## Prasyarat

- Linux atau WSL2, Python 3.10 ke atas, Bash 5
- curl

## Menjalankan

```bash
./setup.sh
```

Aplikasi berjalan di `http://127.0.0.1:5000` (ubah dengan variabel `PORT`).

## Berkas yang tersedia

| Berkas | Fungsi |
|---|---|
| setup.sh | Menyiapkan venv, memasang dependensi, menjalankan aplikasi, dan cek endpoint /health |
| lib/common.sh | Fungsi logging dan validasi bersama |
| buat-log.sh | Membuat log akses contoh untuk latihan analisis log |
| src/app.py | Kode aplikasi |
| HANDOVER.md | Catatan serah terima |
