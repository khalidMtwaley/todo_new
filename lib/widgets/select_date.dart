import 'package:flutter/material.dart';

class SelectDate extends StatelessWidget {
void Function() onTab;
String text;
SelectDate({required this.onTab,required this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontSize: 18),
      ),
    );
  }
}
