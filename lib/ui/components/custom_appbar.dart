import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget child;
  final double expandableHeight;

  const CustomAppBar({
    Key? key,
    required this.height,
    required this.expandableHeight,
    required this.child,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      automaticallyImplyLeading: false,
      expandedHeight: expandableHeight,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.zoomBackground],
        background: child,
      ),
    );
  }
}
