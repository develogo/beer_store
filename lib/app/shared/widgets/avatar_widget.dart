import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Stack(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('assets/profile_pic.jpg'),
          ),
          Positioned(
            top: 3,
            right: 0,
            child: Container(
              height: 14,
              width: 14,
              decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
