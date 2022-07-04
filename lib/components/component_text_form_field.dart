import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ComponentTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType? keyboard;
  final MaskTextInputFormatter? formatter;
  final IconData icon;
  final String? text;

  const ComponentTextFormField({
    Key? key,
    required this.controller,
    this.keyboard,
    this.formatter,
    required this.icon,
    this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none
        ),
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor,),
        labelText: text,
      ),
      textInputAction: TextInputAction.next,
      inputFormatters: formatter != null ? [formatter!] : null,
      cursorColor: Theme.of(context).primaryColor,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Insira um valor válido';
        }
        return null;
      },
    );
  }
}
