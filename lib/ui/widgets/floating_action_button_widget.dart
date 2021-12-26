import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/cubit/cubit_cubit.dart';
import 'package:todo/ui/widgets/defualt_form_field.dart';

// ignore: must_be_immutable
class FloatingActionButtonWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AppCubit cubit;

  FloatingActionButtonWidget({
    Key? key,
    required this.formKey,
    required this.cubit,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void validateAndInsert() {
      if (formKey.currentState!.validate()) {
        cubit.insertToDatabase(
          title: cubit.titleController.text,
          date: cubit.dateController.text,
          time: cubit.timeController.text,
        );
        Navigator.pop(context);
        cubit.isBottomSheetShow = false;
      }
    }

    void closeBottomSheet() {
      cubit.changeButtomSheetState(
        isShow: false,
        icon: Icons.edit,
      );
    }

    Widget buildTaskTitle() {
      return DefualtFormField(
        label: const Text('Task Title'),
        textInputType: TextInputType.text,
        validate: (String? value) {
          if (value!.isEmpty) {
            return 'Title must not be empty';
          }
          return null;
        },
        controller: cubit.titleController,
        prefixIcon: Icons.title,
        hintText: 'Add Task',
      );
    }

    Widget buildTaskTime() {
      return DefualtFormField(
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((TimeOfDay? value) {
            cubit.timeController.text = value!.format(context).toString();
          });
        },
        validate: (String? value) {
          if (value!.isEmpty) {
            return 'Time must not be empty';
          }
        },
        label: const Text('Task Time'),
        textInputType: TextInputType.none,
        controller: cubit.timeController,
        prefixIcon: Icons.watch_later_outlined,
        hintText: 'Add Time',
      );
    }

    Widget buildTaskDate() {
      return DefualtFormField(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2025),
          ).then((DateTime? value) {
            cubit.dateController.text = DateFormat.yMMMd().format(value!);
          });
        },
        validate: (String? value) {
          if (value!.isEmpty) {
            return 'Date must not be empty';
          }
        },
        label: const Text('Task Date'),
        textInputType: TextInputType.none,
        controller: cubit.dateController,
        prefixIcon: Icons.calendar_today_outlined,
        hintText: 'Add Date',
      );
    }

    Widget buildContentOfBottomSheet() {
      return Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTaskTitle(),
              const SizedBox(height: 15.0),
              buildTaskTime(),
              const SizedBox(height: 15.0),
              buildTaskDate(),
            ],
          ),
        ),
      );
    }

    return FloatingActionButton(
      child: Icon(cubit.iconFloatingActionBottom),
      onPressed: () {
        print('----------------------------${cubit.titleController.text}');
        if (cubit.isBottomSheetShow) {
          validateAndInsert();
        } else {
          scaffoldKey.currentState
              ?.showBottomSheet(
                (BuildContext context) => buildContentOfBottomSheet(),
              )
              .closed
              .then((_) {
            closeBottomSheet();
          });
          cubit.changeButtomSheetState(isShow: true, icon: Icons.add);
        }
      },
    );
  }
}
