import 'package:c_product_flutter/screens/login-screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'drawer_item.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    Key? key,
    required this.padding,
    required this.color,
    required this.hoverColor,
    required this.height,
    required this.width,
    required this.dividerColor,
  }) : super(key: key);

  final EdgeInsets padding;
  final Color color;
  final Color hoverColor;
  final double height;
  final double width;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      children: [
        SizedBox(
          height: 20,
        ),
        DrawerItem(
          color: color,
          hoverColor: hoverColor,
          height: height,
          width: width,
          dividerColor: dividerColor,
          itemIcon: Icons.home,
          title: 'Main Page',
          onTab: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
        // DrawerItem(
        //   color: color,
        //   hoverColor: hoverColor,
        //   height: height,
        //   width: width,
        //   dividerColor: dividerColor,
        //   itemIcon: Icons.bookmark_border,
        //   title: 'Orders',
        //   onTab: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => ShippingCart()),
        //     );
        //   },
        // ),
        // DrawerItem(
        //   color: color,
        //   hoverColor: hoverColor,
        //   height: height,
        //   width: width,
        //   dividerColor: dividerColor,
        //   itemIcon: Icons.login,
        //   title: 'Log in',
        //   onTab: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => ContactUsScreen()),
        //     );
        //   },
        // ),
        // DrawerItem(
        //   color: color,
        //   hoverColor: hoverColor,
        //   height: height,
        //   width: width,
        //   dividerColor: dividerColor,
        //   itemIcon: Icons.person_sharp,
        //   title: 'Profile',
        //   onTab: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => ProfileScreen()),
        //     );
        //   },
        // ),
        // DrawerItem(
        //   color: color,
        //   hoverColor: hoverColor,
        //   height: height,
        //   width: width,
        //   dividerColor: dividerColor,
        //   itemIcon: Icons.shopping_cart_outlined,
        //   title: 'Shipping Cart',
        //   onTab: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => ShippingCart()),
        //     );
        //   },
        // ),
        // DrawerItem(
        //   color: color,
        //   hoverColor: hoverColor,
        //   height: height,
        //   width: width,
        //   dividerColor: dividerColor,
        //   itemIcon: Icons.call,
        //   title: 'Contact us',
        //   onTab: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => ContactUsScreen()),
        //     );
        //   },
        // ),
      ],
    );
  }
}
