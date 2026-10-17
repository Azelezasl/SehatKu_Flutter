# SehatKu 🌿

**Pendamping kebiasaan sehat harian** — proyek aplikasi mobile Flutter 

> **Kelompok:** Endless  
> **Anggota:** Wesley (241111300) Michael (241112834)

## 1. Ringkasan proyek

SehatKu adalah aplikasi mobile berbasis Flutter yang dirancang untuk membantu pengguna membangun dan mempertahankan kebiasaan hidup sehat melalui pencatatan kebiasaan harian, pemantauan progres, refleksi suasana hati, kalkulator BMI, edukasi kesehatan, serta pengaturan profil dan pengingat.

Aplikasi ini dibuat sebagai proyek kelompok untuk menerapkan materi pengembangan aplikasi Flutter, khususnya widget dasar, layout, Material Design 3, reusable widget, asset, struktur project Flutter, dan responsive UI.

## 2. Fitur yang sudah diimplementasikan

- Dashboard: target, progres, streak, mood, tips harian.
- Pelacak kebiasaan: air, tidur, olahraga, sayur/buah dengan tombol tambah/check.
- Statistik mingguan: ringkasan dan grafik progres 7 hari.
- Jurnal mood: pilihan suasana hati, catatan, dan riwayat.
- Kalkulator BMI: input tinggi/berat dan kategori BMI.
- Edukasi kesehatan: artikel singkat dan pencarian.
- Profil & pengingat: nama, jam pengingat, pengaturan profil.
- Mode gelap: Material Design 3 light/dark theme.
- Responsive UI: menggunakan layout Flutter yang dapat beradaptasi pada ukuran layar.

## 3. Tampilan aplikasi

Preview berikut dibuat sebagai dokumentasi tampilan halaman berdasarkan implementasi Flutter di `lib/main.dart`.

### Beranda
![Beranda](assets/screenshots/01_beranda.png)

### Statistik
![Statistik](assets/screenshots/02_statistik.png)

### Jurnal Mood
![Jurnal Mood](assets/screenshots/03_jurnal.png)

### Edukasi
![Edukasi](assets/screenshots/04_edukasi.png)

### Profil & BMI
![Profil](assets/screenshots/05_profil.png)

### Mode Gelap
![Mode Gelap](assets/screenshots/06_dark_mode.png)

## 4. Struktur project

```text
sehatku_flutter/
├── assets/
│   └── screenshots/
├── lib/
│   └── main.dart
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
```

## 5. Cara menjalankan

Pastikan Flutter SDK sudah terpasang.

```bash
flutter pub get
flutter run
```

Untuk melihat target perangkat yang tersedia:

```bash
flutter devices
```

Lalu pilih emulator/HP Android atau target desktop/web yang tersedia.

## 6. Catatan implementasi

Project ini sengaja menggunakan Flutter SDK dan Material 3 tanpa paket state-management eksternal. Data pada versi tugas ini bersifat **in-memory** selama aplikasi berjalan. Jika proyek dikembangkan lebih lanjut, penyimpanan lokal dapat ditambahkan untuk mempertahankan data kebiasaan, jurnal, profil, dan pengingat setelah aplikasi ditutup.

## 7. Kesesuaian dengan tugas

Implementasi menerapkan widget dasar Flutter, layout single-child dan multi-child, Material Design 3, reusable widget, asset dokumentasi, serta UI responsif. Struktur kode juga dibuat agar setiap anggota dapat menjelaskan bagian UI, state, dan logika yang dikerjakan.

## 8. GitHub

Setelah folder ini diunggah ke repository ketua kelompok, link repository dapat dikumpulkan pada assignment dosen.

Contoh perintah:

```bash
git init
git add .
git commit -m "feat: implement SehatKu Flutter project"
git branch -M main
git remote add origin <URL_REPOSITORY_GITHUB>
git push -u origin main
```

## 9. Pembagian bagian untuk presentasi/demo

- **Dashboard & tracker:** alur pencatatan kebiasaan dan progres.
- **Statistik:** grafik progres 7 hari.
- **Jurnal:** pemilihan mood dan penyimpanan catatan.
- **Edukasi:** pencarian dan detail artikel.
- **Profil:** mode gelap, pengingat, dan BMI.

## 10. Referensi sumber proyek

Spesifikasi fitur dan konsep aplikasi mengikuti proposal proyek Flutter **SehatKu**, SDG 3, Kelompok Endless.
