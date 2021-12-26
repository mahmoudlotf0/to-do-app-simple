import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit_cubit.dart';

class BuildTaskItem extends StatelessWidget {
  final List tasks;
  final int index;
  const BuildTaskItem(this.tasks, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text('${tasks[index]['time']}'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tasks[index]['title']}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${tasks[index]['date']}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              AppCubit.getObjectFromCubit(context).updateDataFromDatabase(
                  status: 'done', id: tasks[index]['id']);
            },
            icon: const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.getObjectFromCubit(context).updateDataFromDatabase(
                  status: 'archive', id: tasks[index]['id']);
            },
            icon: const Icon(
              Icons.archive,
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}
