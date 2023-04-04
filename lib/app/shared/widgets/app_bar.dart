import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../config/theme/app_colors.dart';
import 'avatar_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    required this.onBackPressed,
  }) : super(key: key);

  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.all(12),
        child: IconButton(
          onPressed: onBackPressed,
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const AvatarWidget(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
