import 'package:flutter/material.dart';

import '../app_theme.dart';

class MyElevatedButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  EdgeInsetsGeometry margin ;
  MyElevatedButton({required this.label,required this.onPressed,this.margin= const EdgeInsets.all(50),});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.lightBlue,
            foregroundColor: AppTheme.white
        ),
        onPressed: onPressed,
        child:  Text(label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 18,
            color: AppTheme.white,
          ),
        ),
      ),
    );
  }
}
