// import 'package:sqflite/sqflite.dart';

// class DatabaseServices {
//   static Database? database;
//   static String tableName = 'tasks';
//   static int version = 1;
//   static List<Map>? tasksFromDatabase = [];
//   static void createDatabase() async {
//     try {
//       String pathDatabase = await getDatabasesPath() + 'todo.db';
//       database = await openDatabase(
//         pathDatabase,
//         version: version,
//         onCreate: (Database database, int version) async {
//           print('Database Created');
//           await database.execute(
//               'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
//         },
//         onOpen: (Database database) {
//           getDataFromDatabase(database).then((List<Map> value) {
//             tasksFromDatabase = value;
//             print(tasksFromDatabase);
//           });
//           print('Database Open');
//         },
//       );
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   static Future insertToDatabase({
//     required String title,
//     required String date,
//     required String time,
//   }) async {
//     return await database!.transaction(
//       (txn) async {
//         txn
//             .rawInsert(
//           'INSERT INTO $tableName (title, date, time, status) VALUES("$title", "$date", "$time", "new")',
//         )
//             .then(
//           (int value) {
//             getDataFromDatabase(DatabaseServices.database!).then((value) {
//               tasksFromDatabase = value;
//             });
//             print('$value Inserted Successfully');
//           },
//         ).catchError((error) {
//           print('Error when insert data ${error.toString()}');
//         });
//       },
//     );
//   }

//   static Future<List<Map>> getDataFromDatabase(Database database) async {
//     return await database.rawQuery('SELECT * FROM $tableName');
//   }
// }
// // INSERT INTO $tableName (title, date, time, status) VALUES("frist title", "15-10", "10:22", "new")