import 'package:flutter/material.dart';

import '../widgets.dart';

class InputPassword extends StatefulWidget {
  final TextEditingController controller;
  final String validatorMessage;
  final String? hintText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const InputPassword({
    super.key,
    required this.controller,
    required this.validatorMessage,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    required IconButton suffixIcon,
  });

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return InputText(
      controller: widget.controller,
      validatorMessage: widget.validatorMessage,
      obscureText: _obscure,
      prefixIcon: widget.prefixIcon,
      hintText: widget.hintText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      suffixIcon: IconButton(
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(
                () {
              _obscure = !_obscure;
            },
          );
        },
      ),
    );
  }
}
