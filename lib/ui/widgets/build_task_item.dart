import 'package:flutter/material.dart';

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
          Column(
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
        ],
      ),
    );
  }
}
