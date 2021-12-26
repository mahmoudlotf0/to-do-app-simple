import 'package:flutter/material.dart';

class DefualtFormField extends StatefulWidget {
  final Widget? label;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String? hintText;
  final TextInputType? textInputType;
  final bool? isPassword;
  final String? valueKey;
  final String? Function(String? val)? validate;
  final String? Function(String? val)? onSave;
  final Function()? onTap;
  const DefualtFormField({
    Key? key,
    this.onTap,
    required this.label,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
    this.textInputType,
    this.isPassword = false,
    this.valueKey,
    this.validate,
    this.onSave,
  }) : super(key: key);

  @override
  _DefualtFormFieldState createState() => _DefualtFormFieldState();
}

class _DefualtFormFieldState extends State<DefualtFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      onSaved: widget.onSave,
      validator: widget.validate,
      key: ValueKey(widget.valueKey),
      obscureText: widget.isPassword!,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        label: widget.label,
        prefixIcon: Icon(widget.prefixIcon),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}

















// Widget defualtTextField({
//   required TextEditingController? controller,
//   required IconData? prefixIcon,
//   required String? hintText,
//   TextInputType? textInputType,
//   bool isPassword = false,
//   required String? valueKey,
//   String? Function(String? val)? validate,
//   String? Function(String? val)? onSave,
// }) {
//   return TextFormField(
//     onSaved: onSave,
//     validator: validate,
//     key: ValueKey(valueKey),
//     obscureText: isPassword,
//     controller: controller,
//     keyboardType: textInputType,
//     decoration: InputDecoration(
//       prefixIcon: Icon(prefixIcon),
//       hintText: hintText,
//       border: OutlineInputBorder(
//         borderSide: const BorderSide(
//           color: Colors.blue,
//           width: 2.0,
//         ),
//         borderRadius: BorderRadius.circular(40.0),
//       ),
//       filled: true,
//       fillColor: Colors.white,
//     ),
//   );
// }
