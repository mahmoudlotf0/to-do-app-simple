part of 'cubit_cubit.dart';

@immutable
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavigationBar extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppUbdateDatabaseState extends AppStates {}
