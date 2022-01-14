import 'package:c_product_flutter/models/user/LoginResponse.dart';
import 'package:c_product_flutter/shared/constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'drawer_body.dart';
import 'header.dart';

class DrawerNavigationScreen extends StatelessWidget {
  User? user;
  final padding = EdgeInsets.symmetric(horizontal: 16);
  DrawerNavigationScreen([this.user]):super();
  // static var dividerColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    final color = Colors.black;
    final hoverColor = Colors.white70;
    final dividerColor = Colors.white70;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 50.0),
      child: Drawer(
        child: Material(
          color: KAppDrawerColor,
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.drive_file_rename_outline,
                  color: color,
                ),
                title: Text(
                  '${user?.fullName}',
                  style: TextStyle(
                    color: color,
                  ),
                ),
                hoverColor: hoverColor,
                onTap: () {},
              ),
              Divider(
                color: Colors.deepPurpleAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// buildMenuItem(
//   title: 'Main Page',
//   icon: Icons.home,
//   onTabb: () => print("height === $height + $width"),
// ),

// buildMenuItem(title: 'Orders', icon: Icons.bookmark_border),

// buildMenuItem(title: 'Log in', icon: Icons.login),

// buildMenuItem(title: 'Profile', icon: Icons.person_sharp),

// buildMenuItem(
//     title: 'Shipping Cart',
//     icon: Icons.shopping_cart_outlined),

// buildMenuItem(title: 'Contact us', icon: Icons.call),

// Column buildMenuItem({
//   required String title,
//   required IconData icon,
//   VoidCallback? onTabb,
// }) {
//   final color = Colors.black;
//   final hoverColor = Colors.white70;
//   final dividerColor = Colors.white70;
//   return Column(
//     children: [
//       ListTile(
//         leading: Icon(
//           icon,
//           color: color,
//         ),
//         title: Text(
//           title,
//           style: TextStyle(color: color,),
//         ),
//         hoverColor: hoverColor,
//         onTap: onTabb,
//       ),
//       Divider(color: dividerColor,),
//
//     ],
//   );
// }
