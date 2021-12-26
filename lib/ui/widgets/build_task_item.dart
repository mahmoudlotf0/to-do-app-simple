import 'package:flutter/material.dart';

class BuildTaskItem extends StatelessWidget {
  final int index;
  const BuildTaskItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40.0,
            child: Text(''
                // '${DatabaseServices.tasksFromDatabase![index]['time']}',
                ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '',
                // '${DatabaseServices.tasksFromDatabase![index]['title']}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '',
                // '${DatabaseServices.tasksFromDatabase![index]['date']}',
                textAlign: TextAlign.start,
                style: TextStyle(
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
