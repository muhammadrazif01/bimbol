# Kelompok A01 PBP Gasal Fasilkom UI 2021/2022
Repository ini digunakan untuk Proyek Akhir Semester pada mata kuliah PBP semester gasal Fasilkom UI 2021/2022.

## 👪 Anggota Kelompok
- Adella Rakha Amadea - 2006463616
- Ardanisa Rachma - 2006463080
- Markus Leonard Wijaya - 2006473913
- Mohammad Bryan Mahdavikhia - 2006463124
- Muhammad Halif - 2006473850
- Muhammad Razif Firmansyah - 2006463206
- Mutiara Azzahra - 2006463641

## 🔗 Links
- Link Download APK A01 (BIMBOL)      :  https://github.com/muhammadrazif01/bimbol/releases
- Link Web-app A01 (BIMBOL)           :  https://tk-pbp-a01.herokuapp.com/

## 📱 Tentang Aplikasi
Nama aplikasi : BIMBOL (Bimbel Online di Masa Pandemi)

Di masa pandemi seperti ini, dengan terbatasnya pertemuan antara siswa dengan guru, maka secara otomatis kemampuan siswa dalam menerima materi pun akan terbatas.Berkurangnya intensitas pertemuan siswa dengan guru di sekolah serta sistem pembelajaran yang dilakukan secara jarak jauh menjadi kendala dalam pencapaian tujuan belajar. 

Salah satu solusi yang dapat dilakukan yaitu dengan melakukan pendampingan belajar oleh orang tua di rumah. Namun, hal ini sulit dilakukan karena kebanyakan  orang tua memiliki kesibukan tersendiri. Maka dari itu, kebanyakan orang tua memilih untuk mendaftarkan anaknya untuk mengikuti les privat ataupun tutor agar dapat memahami materi dengan lebih baik.

Namun, ditengah pandemi saat ini, tentu menjadi salah satu tantangan tersendiri bagi para orang tua dalam menemukan tutor yang tepat bagi anaknya. Begitupun sebaliknya, para tutor/pengajar juga kesulitan untuk mencari pekerjaan karena perlu adanya penyesuaian sistem atau platform untuk menerapkan kegiatan tutor secara online.

Untuk menyelesaikan permasalahan tersebut, kami berpikir untuk membuat **BIMBOL, sebuah aplikasi yang dapat mempertemukan antara pengajar dengan siswa yang membutuhkan tutor melalui platform bimbel online dengan mudah. Aplikasi ini dapat membantu para siswa yang kesulitan dalam memahami materi pembelajaran serta mempertemukannya dengan tutor/pengajar yang juga sedang  mencari pekerjaan.**

## 📚 Daftar Modul
- Pendaftaran Guru (oleh Adella Rakha Amadea)
Halaman yang berisi form untuk registrasi untuk mendaftar sebagai pengajar bimbingan belajar. Setelah registrasi berhasil, maka akan ditampilkan halaman yang berisi profil pengajar serta nantinya bisa dilakukan edit pada profil.
- Pendaftaran Siswa (oleh Ardanisa Rachma)
Halaman yang berisi form untuk registrasi untuk mendaftar sebagai siswa bimbingan belajar. Setelah registrasi berhasil, maka akan otomatis login dan ditampilkan welcome page yang hanya dapat diakses apabila telah login
- Home Page dan Login (oleh Muhammad Razif Firmansyah)
Halaman awal yang menampilkan informasi umum aplikasi, menampilkan navigasi dengan link pada halaman lainnya, serta akses untuk login
- Booking guru (oleh Mohammad Bryan Mahdavikhia)
Halaman akan menampilkan daftar profil pengajar, lalu siswa dapat memilih pengajar yang diinginkan. Setelahnya, akan ditampilkan informasi kontak pengajar untuk kelanjutan mekanisme  pembelajaran
- Jadwal (oleh Muhammad Halif)
Siswa dapat memilih jadwal pembelajaran sesuai slot yang ada. Ketika sudah memilih, akan ditampilkan halaman jadwal yang telah dipilih oleh siswa dan nantinya dapat dilakukan edit apabila terdapat jadwal yang ingin diubah
- Forum (oleh Markus Leonard Wijaya)
Siswa dapat bertanya atau mendiskusikan  materi atau soal yang kurang dipahami pada forum diskusi kepada pengajar atau siswa lainnya
- Testimoni (oleh Mutiara Azzahra)
Pada halaman ini, siswa yang sudah terdaftar dapat mengisi form testimoni bimbingan belajar yang nantinya akan ditampilkan pada halaman dashboard

## 🖥️ Integrasi dengan Web Service
- Menggunakan library Dart http untuk pengimplementasi Cookie-based authentication 
- Menggunakan JsonResponse atau JSON Serializer Django untuk pengimplementasi REST API pada backend Django
- Membuat frontend mobile dengan menggunakan berbagai widget dengan benchmark desain frontend website
- Menggunakan konsep asynchronous HTTP untuk integrasi frontend-backend

## 👨‍🎓 Persona
- Anonim : Belum mendaftar (tidak memiliki akun) dan hanya dapat melihat Home Page dan daftar forum
- Guru   : Memiliki jadwal yang dapat diakses dan dibooking untuk mengajar oleh siswa dan dapat mengisi forum
- Siswa  : Dapat melihat jadwal guru dan membooking jadwal ajar guru tersebut serta dapat mengisi forum dan testimoni.

## 📝 Informasi detail tambahan mengenai aplikasi
🖊 Motivasi dan masalah yang ingin diselesaikan
- Pembelajaran daring membuat beberapa siswa kesulitan mengikuti pelajaran
- Tidak memungkinkannya bimbel luring karena faktor keamanan dan kesehatan di masa pandemi Covid-19
- Cukup banyaknya guru yang tidak memiliki pekerjaan di masa pandemi Covid-10

🖊 Goals
- Murid lebih mudah mendapat bimbingan belajar karena pembelajaran dilakukan secara daring
- Murid dapat bertanya materi yang mereka tidak ketahui secara aman tanpa perlu khawatir ancaman Covid-19
- Orang tua murid dapat lebih mudah melakukan tracking capaian pembelajaran anaknya selama belajar daring
- Membuka lapangan pekerjaan bagi pengajar di masa pandemi Covid-19