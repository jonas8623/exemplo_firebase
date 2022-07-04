import 'package:flutter/material.dart';

class ComponentButton extends StatelessWidget {

  final GestureTapCallback onPressed;
  final IconData iconData;
  final String text;

  const ComponentButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.60,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color: Colors.black45,),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextButton.icon(
              icon: Icon(iconData, color: Colors.white, size: 26.0,),
              label: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18.0),),
              onPressed: onPressed
            )
        ),
      ),
    );
  }
}
