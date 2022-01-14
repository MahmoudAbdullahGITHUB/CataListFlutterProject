
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.color,
    required this.hoverColor,
    required this.height,
    required this.width,
    required this.dividerColor,
    required this.itemIcon,
    required this.title,
    required this.onTab,
  }) : super(key: key);

  final Color color;
  final Color hoverColor;
  final double height;
  final double width;
  final Color dividerColor;
  final IconData itemIcon;
  final String title;
  final VoidCallback onTab;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            itemIcon,
            color: color,
          ),
          title: Text(
            '$title',
            style: TextStyle(
              color: color,
            ),
          ),
          hoverColor: hoverColor,
          onTap: onTab ,
        ),
        Divider(
          color: dividerColor,
        ),
      ],
    );
  }
}
