import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/shared/constans/bloc_observer.dart';
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
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.getObjectFromCubit(context);
          return Scaffold(
            key: scaffoldKey,
            bottomNavigationBar: BottomNavigationBarWidget(cubit: cubit),
            appBar: AppBar(
              title: Text(cubit.titlesAppBar[cubit.currentIndexBottomBar]),
            ),
            body: cubit.pagesOfBottomBar[cubit.currentIndexBottomBar],
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
/*
  FloatingActionButton(
              child: Icon(cubit.iconFloatingActionBottom),
              onPressed: () {
                if (cubit.isBottomSheetShow) {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    cubit.isBottomSheetShow = false;
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (BuildContext context) => Container(
                          color: Colors.grey[100],
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefualtFormField(
                                  label: const Text('Task Title'),
                                  textInputType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Title must not be empty';
                                    }
                                    return null;
                                  },
                                  controller: titleController,
                                  prefixIcon: Icons.title,
                                  hintText: 'Add Task',
                                ),
                                const SizedBox(height: 15.0),
                                DefualtFormField(
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((TimeOfDay? value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Time must not be empty';
                                    }
                                  },
                                  label: const Text('Task Time'),
                                  textInputType: TextInputType.none,
                                  controller: timeController,
                                  prefixIcon: Icons.watch_later_outlined,
                                  hintText: 'Add Time',
                                ),
                                const SizedBox(height: 15.0),
                                DefualtFormField(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2025),
                                    ).then((DateTime? value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Date must not be empty';
                                    }
                                  },
                                  label: const Text('Task Date'),
                                  textInputType: TextInputType.none,
                                  controller: dateController,
                                  prefixIcon: Icons.calendar_today_outlined,
                                  hintText: 'Add Date',
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeButtomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeButtomSheetState(isShow: true, icon: Icons.add);
                }
              },
            ),
         
 
 */