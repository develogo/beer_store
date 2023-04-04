import 'package:beer_store/app/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RunningDropWidget extends StatelessWidget {
  final AnimationController controller;
  final int selectedIndex;
  final int previousIndex;

  const RunningDropWidget(
      {Key? key,
      required this.controller,
      required this.selectedIndex,
      required this.previousIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final maxElementWidth = deviceWidth / 3;
    return AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return Transform.translate(
            offset: Tween<Offset>(
              begin: Offset(previousIndex * maxElementWidth, 0),
              end: Offset(selectedIndex * maxElementWidth, 0),
            )
                .animate(
                  CurvedAnimation(
                    parent: controller,
                    curve: const Interval(0.0, 0.35),
                  ),
                )
                .value,
            child: SizedBox(
              width: maxElementWidth,
              child: Column(
                children: [
                  Container(
                    height: 2,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
