import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/shared/cubit/bloc_observer.dart';
import 'package:todo/shared/cubit/cubit_cubit.dart';
import 'package:todo/ui/widgets/bottom_bar_widget.dart';
import 'package:todo/ui/widgets/floating_action_button_widget.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Widget buildCircularIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            // lma twsl ll state a3ml pop
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.getObjectFromCubit(context);
          return Scaffold(
            key: scaffoldKey,
            bottomNavigationBar: BottomNavigationBarWidget(cubit: cubit),
            appBar: AppBar(
              title: Text(cubit.titlesAppBar[cubit.currentIndexBottomBar]),
            ),
            body: state is! AppGetDatabaseLoadingState
                ? cubit.pagesOfBottomBar[cubit.currentIndexBottomBar]
                : buildCircularIndicator(),
            floatingActionButton: FloatingActionButtonWidget(
              formKey: formKey,
              cubit: cubit,
              scaffoldKey: scaffoldKey,
            ),
          );
        },
      ),
    );
  }
}
