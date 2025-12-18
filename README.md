# Twitter-Toxicity-Text-Analysis

## Deskripsi Singkat

Proyek ini bertujuan untuk menganalisis teks tweet dan mengidentifikasi perbedaan karakteristik antara tweet toxic dan non-toxic menggunakan
pendekatan text mining dan visualisasi data. Analisis dilakukan dengan bahasa pemrograman R melalui tahapan pembersihan teks, tokenisasi, analisis frekuensi kata, 
serta TF-IDF untuk mengidentifikasi kata-kata yang paling khas pada masing-masing kategori.


## Tujuan dari analisis

Tujuan dari proyek ini adalah:
1. Menganalisis distribusi tweet toxic dan non-toxic
2. Membandingkan panjang tweet berdasarkan tingkat toxicity
3. Mengidentifikasi kata-kata yang paling sering muncul secara global
4. Mengidentifikasi kata khas pada tweet toxic dan non-toxic
5. Menyediakan insight awal untuk pengembangan model klasifikasi teks


## Dataset

Dataset yang digunakan berasal dari Kaggle dan berisi sekitar 31.962 tweet.
Struktur data:
- `id`    : ID unik tweet
- `label` : Kategori tweet (toxic / non-toxic)
- `tweet` : Teks tweet


## Metodologi Analisis

Alur analisis disusun sesuai urutan sintaks R, sebagai berikut:
1. Persiapan & Import Library
2. Load Data & Pemeriksaan Awal
3. Menghitung & Membersihkan teks
4. Analisis Distribusi Label & Panjang Tweet
5. Tokenisasi Tweet Menjadi Kata
6. Identifikasi Kata Paling Sering Muncul Secara Global
7. Identifikasi Kata Paling Sering muncul Setiap Kategori


## Visualisasi

### Proporsi Tweet Toxic vs Non-Toxic
![Proporsi](output/figures/Proporsi_Toxic_vs_Non-Toxic.png)
Visualisasi ini menunjukkan distribusi label pada dataset tweet. Dataset ini didominasi oleh tweet "Non-Toxic" (93%), sedangkan tweet "Toxic" hanya menyumbang sebagian kecil data (7%).

### Panjang Tweet Toxic vs Non-Toxic
![Panjang Tweet](output/figures/Panjang_Tweet_Toxic_vs_Non-Toxic.png)
Visualisasi ini menunjukkan perbedaan distribusi panjang tweet antara kategori "Toxic" dan "Non-Toxic".
Secara umum, "tweet Toxic" cenderung memiliki panjang yang sedikit lebih tinggi dibandingkan "tweet Non-Toxic", baik dilihat dari nilai median (nilai tengah) maupun rentang sebarannya.

Temuan ini mengindikasikan bahwa tweet yang bersifat "toxic" cenderung menggunakan lebih banyak kata atau karakter dalam mengekspresikan opini atau emosi tertentu, meskipun kedua kategori tetap menunjukkan variasi panjang tweet yang cukup besar.

### 15 Kata Paling Sering Muncul
![Top Words](output/figures/15_Kata_Paling_Sering_Muncul.png)
Visualisasi ini menampilkan 15 kata yang paling sering muncul berdasarkan keseluruhan dataset "tweet" setelah proses pembersihan teks.

Terlihat bahwa kata "user" merupakan kata yang paling dominan, yang mengindikasikan tingginya penggunaan mention atau rujukan terhadap pengguna lain dalam percakapan di "Twitter". Selain itu, kata-kata seperti "love", "happy", "thankful", dan "positive" juga muncul dengan frekuensi tinggi, menunjukkan bahwa secara umum konten tweet dalam dataset ini didominasi oleh ekspresi emosional yang bersifat positif.

Temuan ini juga sejalan dengan distribusi label sebelumnya, di mana sebagian besar tweet dikategorikan sebagai "Non-Toxic", sehingga kata-kata bernuansa positif lebih banyak muncul dalam keseluruhan dataset.

### Top Tweet Toxic vs Non-Toxic
![Top Tweet](output/figures/Top_Tweet_Toxic_vs_Non-Toxic.png)
Visualisasi ini menampilkan 10 kata yang paling sering muncul pada masing-masing kategori tweet, yaitu "Non-Toxic" dan "Toxic".

Pada kategori "Non-Toxic", kata-kata yang dominan cenderung bersifat netral hingga positif, seperti "love", "happy", "thankful", dan "positive". Hal ini menunjukkan bahwa tweet Non-Toxic umumnya digunakan untuk mengekspresikan emosi positif, interaksi sosial, serta aktivitas sehari-hari.

Sebaliknya, pada kategori "Toxic", selain kata umum seperti "user", mulai muncul kata-kata yang berkaitan dengan isu sensitif dan konfrontatif, seperti "trump", "libtard", "racist", serta istilah yang berkaitan dengan politik dan identitas sosial. Pola ini mengindikasikan bahwa tweet Toxic lebih sering mengandung topik yang bersifat provokatif atau berpotensi menimbulkan konflik.

Perbedaan pola kata ini menunjukkan adanya karakteristik bahasa yang berbeda antara "tweet Toxic" dan "Non-Toxic", yang dapat menjadi dasar awal dalam proses analisis teks dan pengembangan model klasifikasi di tahap selanjutnya.


## Kesimpulan 
Dataset didominasi oleh "tweet Non-Toxic" dengan pola bahasa yang cenderung positif. Sebaliknya, "tweet Toxic" memiliki pola bahasa yang berbeda, ditandai dengan penggunaan kata-kata yang lebih konfrontatif dan berkaitan dengan isu sensitif. Perbedaan karakteristik kata dan panjang tweet antara kategori "Toxic" dan "Non-Toxic" menunjukkan potensi fitur teks dalam mendukung analisis dan klasifikasi "toxic tweet".

Temuan ini menegaskan bahwa data teks, meskipun bersifat tidak terstruktur, dapat diolah menjadi informasi yang bermakna melalui proses eksplorasi dan ekstraksi fitur, sehingga memberikan dasar yang kuat bagi analisis data dan pengembangan model berbasis teks.
