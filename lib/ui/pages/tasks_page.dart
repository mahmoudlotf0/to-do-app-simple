import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/cubit/cubit_cubit.dart';
import 'package:todo/ui/widgets/build_task_item.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        List tasks = AppCubit.getObjectFromCubit(context).tasksFromDatabase;

        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return BuildTaskItem(tasks, index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            );
          },
          itemCount: tasks.length,
        );
      },
    );
  }
}
