// ignore_for_file: avoid_print

/* 
Line 12: Menyimpan nama database, tetapi belum membuat atau membuka database
Line 15: Membuat variabel untuk nama tabel database
Line 19: Database adalah blueprint yang disediakan oleh sqflite untuk membuat koneksi dan berinteraksi dengan database SQLite
Line 19: Objek spesifik dari kelas Database (dalam hal ini Database? _database) adalah koneksi atau referensi ke database yang sebenarnya
Line 28: Proses pembuatan atau membuka database dilakukan di dalam fungsi openDatabase() atau di dalam metode _initDatabase()
*/
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:subproject1/models/user.dart';

class DatabaseUserHelper {
  final String databaseName = "marketplace";
  final int databaseVersion = 1;

  final String tableUser = "User";
  final String email = "email";
  final String password = "password";

  Database? _database;

  // Kalau belum, buatkan di function _initDatabase
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(path,
        version: databaseVersion, onCreate: onCreateDatabase);
  }

  Future<void> onCreateDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableUser ($email TEXT PRIMARY KEY NOT NULL, $password TEXT NOT NULL)");

    await db.insert(tableUser, {
      email: "mitraelektronik@gmail.com",
      password: "mitraelektronik123",
    });
  }

  Future<User?> loginUser(String inputEmail, String inputPassword) async {
    final db = await database();

    try {
      List<Map<String, dynamic>> result = await db.query(
        tableUser,
        where: "$email = ? AND $password = ?",
        whereArgs: [inputEmail, inputPassword],
      );

      if (result.isNotEmpty) {
        // Mengembalikan instance User jika login berhasil
        return User(
          email: result.first[email],
          password: result.first[
              password], // Biasanya tidak disimpan di sini, hanya untuk contoh
        );
      } else {
        return null; // Jika login gagal
      }
    } catch (e) {
      print("Error logging in: $e");
      return null; // Menangani kesalahan dan mengembalikan null
    }
  }
}
