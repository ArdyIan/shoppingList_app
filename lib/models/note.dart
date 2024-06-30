class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;
  List<String> items; // Tambahkan properti ini

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
    this.items = const [], // Inisialisasi dengan daftar kosong secara default
  });

//method untuk mengubah judul dan konten catatan
  void editNote(String newTitle, String newContent) {
    this.title = newTitle;
    this.content = newContent;
    this.modifiedTime = DateTime.now();
  }
}

List<Note> sampleNotes = [
  Note(
      id: 0,
      title: 'Selamat Datang di Aplikasi Shopping List',
      content: '',
      modifiedTime: DateTime(2024, 1, 1, 34, 5)),
  // Note(
  //     id: 1,
  //     title: 'Bayam',
  //     content: 'Bayam mengandung banyak kalsium',
  //     modifiedTime: DateTime(2024, 1, 1, 34, 5)),
  // Note(
  //     id: 2,
  //     title: 'Bayam',
  //     content: 'Bayam mengandung banyak kalsium',
  //     modifiedTime: DateTime(2024, 1, 1, 34, 5)),
  // Note(
  //     id: 3,
  //     title: 'Bayam',
  //     content: 'Bayam mengandung banyak kalsium',
  //     modifiedTime: DateTime(2024, 1, 1, 34, 5)),
  // Note(
  //     id: 4,
  //     title: 'Bayam',
  //     content:
  //         'Bayam mengandung banyak kalsium. Merebus adalah cara terbaik untku menikmati kesehatan bayam . Dengan 3 ribu rupiah anda sudah dapat memiliki 1 ikat bayam',
  //     modifiedTime: DateTime(2024, 1, 1, 34, 5)),
  // Note(
  //     id: 5,
  //     title: 'Bayam',
  //     content: 'Bayam mengandung banyak kalsium',
  //     modifiedTime: DateTime(2024, 1, 1, 34, 5)),
  // Note(
  //     id: 6,
  //     title: 'Bayam',
  //     content: 'Bayam mengandung banyak kalsium',
  //     modifiedTime: DateTime(2024, 1, 1, 34, 5)),
  // Note(
  //     id: 7,
  //     title: 'Bayam',
  //     content: 'Bayam mengandung banyak kalsium',
  //     modifiedTime: DateTime(2024, 1, 1, 34, 5)),
  // Note(
  //     id: 8,
  //     title: 'Bayam',
  //     content: 'Bayam mengandung banyak kalsium',
  //     modifiedTime: DateTime(2024, 1, 1, 34, 5)),
];
