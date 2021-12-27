import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo/ui/pages/archive_page.dart';
import 'package:todo/ui/pages/done_page.dart';
import 'package:todo/ui/pages/tasks_page.dart';

part 'cubit_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit getObjectFromCubit(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);
  // * variabls text field
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  void clearCotroller() {
    titleController.clear();
    timeController.clear();
    dateController.clear();
  }

  // * Bottom Navigation Bar
  void bottomNavigationbar() {}
  int currentIndexBottomBar = 0;
  List<String> titlesAppBar = [
    'Tasks',
    'Done',
    'Archive',
  ];
  List<Widget> pagesOfBottomBar = [
    const TasksPage(),
    const DonePage(),
    const ArchivePage(),
  ];
  void changeIndexForBottomBar(int index) {
    currentIndexBottomBar = index;
    emit(AppChangeBottomNavigationBar());
  }

  // * Database
  Database? database;
  String tableName = 'tasks';
  int version = 1;
  List<Map> newTasksFromDatabase = [];
  List<Map> doneTasksFromDatabase = [];
  List<Map> archiveTasksFromDatabase = [];

  void createDatabase() async {
    try {
      String pathDatabase = await getDatabasesPath() + 'todo.db';
      openDatabase(
        pathDatabase,
        version: version,
        onCreate: (Database database, int version) async {
          print('Database Created');
          await database.execute(
              'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
        },
        onOpen: (Database database) {
          getDataFromDatabase(database);
          print('Database Open');
        },
      ).then((value) {
        database = value;
        emit(AppCreateDatabaseState());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO $tableName (title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      )
          .then((int value) {
        print('$value Inserted Successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database!);
        clearCotroller();
        emit(AppClearControllerState());
      }).catchError((error) {
        print('Error when insert data ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(Database database) {
    newTasksFromDatabase = [];
    doneTasksFromDatabase = [];
    archiveTasksFromDatabase = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM $tableName').then((value) {
      for (Map element in value) {
        if (element['status'] == 'new') {
          newTasksFromDatabase.add(element);
        } else if (element['status'] == 'done') {
          doneTasksFromDatabase.add(element);
        } else {
          archiveTasksFromDatabase.add(element);
        }
      }
      emit(AppGetDatabaseState());
    });
  }

  void updateDataFromDatabase({required String status, required int id}) async {
    database!.rawUpdate(
      'UPDATE $tableName SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database!);
      emit(AppUbdateDatabaseState());
    });
  }

  void deleteDataFromDatabase(int id) async {
    await database!
        .rawDelete('DELETE FROM $tableName WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database!);
    });
    emit(AppDeleteDatabaseState());
  }

  // * Bottom Sheet
  IconData iconFloatingActionBottom = Icons.edit;
  bool isBottomSheetShow = false;
  void changeButtomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShow = isShow;
    iconFloatingActionBottom = icon;
    emit(AppChangeBottomSheetState());
  }
}
