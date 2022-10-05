import 'package:flutter/material.dart';

import '../utils/colors.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.maybePop(context);
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1.5,
            color: AppColors.lightgrey.withOpacity(0.50),
          ),
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
