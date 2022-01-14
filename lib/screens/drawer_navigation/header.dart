
import 'package:c_product_flutter/shared/constants/images-providers.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: DrawerHeader(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageProviders.KAppBarBackgroundImage),
                fit: BoxFit.none,
              )),
          child: null,
        ),
      ),
    );
  }
}
