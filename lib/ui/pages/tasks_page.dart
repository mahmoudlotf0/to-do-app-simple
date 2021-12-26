import 'package:flutter/material.dart';
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
    return Center(
      child: Text(
        AppCubit.getObjectFromCubit(context).tasksFromDatabase.toString(),
        style: const TextStyle(fontSize: 29.0),
      ),
    );
    // return ListView.separated(
    //   itemBuilder: (BuildContext context, int index) {
    //     return BuildTaskItem(index);
    //   },
    //   separatorBuilder: (BuildContext context, int index) {
    //     return Container(
    //       width: double.infinity,
    //       height: 1,
    //       color: Colors.grey[300],
    //     );
    //   },
    //   itemCount: 5,
    // );
  }
}
