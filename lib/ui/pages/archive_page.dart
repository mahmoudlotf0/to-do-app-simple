import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/cubit/cubit_cubit.dart';
import 'package:todo/ui/widgets/build_task_item.dart';
import 'package:todo/ui/widgets/no_tasks_yet.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        List tasks =
            AppCubit.getObjectFromCubit(context).archiveTasksFromDatabase;
        return tasks.isEmpty
            ? const NoTasksYet()
            : ListView.separated(
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
