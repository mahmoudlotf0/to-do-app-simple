import 'package:flutter/material.dart';
import 'package:todo/ui/widgets/defualt_form_field.dart';

class DonePage extends StatefulWidget {
  const DonePage({Key? key}) : super(key: key);

  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefualtFormField(
          prefixIcon: Icons.ac_unit,
          hintText: '',
          label: const Text(''),
          controller: controller,
        ),
        ElevatedButton(
            onPressed: () {
              print('---------------- ${controller.text}');
            },
            child: const Text('Tap'))
      ],
    );

    // return const Center(
    //   child: Text(
    //     'Done',
    //     style: TextStyle(
    //       fontSize: 25.0,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // );
  }
}
