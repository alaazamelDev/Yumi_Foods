import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({Key? key, this.thinkness = 1.0}) : super(key: key);
  final double? thinkness;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      child: Divider(thickness: thinkness),
    );
  }
}
