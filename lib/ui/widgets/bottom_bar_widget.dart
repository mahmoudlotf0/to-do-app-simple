import 'package:flutter/material.dart';
import 'package:todo/shared/cubit/cubit_cubit.dart';

// ignore: must_be_immutable
class BottomNavigationBarWidget extends StatelessWidget {
  late AppCubit cubit;

  BottomNavigationBarWidget({Key? key, required this.cubit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_outlined),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline),
          label: 'Done',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.archive_outlined),
          label: 'Archive',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        cubit.changeIndexForBottomBar(index);
      },
      currentIndex: cubit.currentIndexBottomBar,
    );
  }
}
