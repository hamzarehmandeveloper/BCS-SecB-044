import 'package:carrentalservices/widgets/homePage/brand_logo.dart';
import 'package:carrentalservices/widgets/homePage/category.dart';
import 'package:flutter/material.dart';

Column buildTopBrands(Size size, bool isDarkMode) {
  return Column(
    children: [
      buildCategory('Top Brands', size, isDarkMode),
      Padding(
        padding: EdgeInsets.only(top: size.height * 0.015),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBrandLogo(
              Image.asset(
                'assets/icons/hyundai.png',
                height: size.width * 0.1,
                width: size.width * 0.15,
                fit: BoxFit.fill,
              ),
              size,
              isDarkMode,
            ),
            buildBrandLogo(
              Image.asset(
                'assets/icons/volkswagen.png',
                height: size.width * 0.12,
                width: size.width * 0.12,
                fit: BoxFit.fill,
              ),
              size,
              isDarkMode,
            ),
            buildBrandLogo(
              Image.asset(
                'assets/icons/toyota.png',
                height: size.width * 0.08,
                width: size.width * 0.12,
                fit: BoxFit.fill,
              ),
              size,
              isDarkMode,
            ),
            buildBrandLogo(
              Image.asset(
                'assets/icons/bmw.png',
                height: size.width * 0.12,
                width: size.width * 0.12,
                fit: BoxFit.fill,
              ),
              size,
              isDarkMode,
            ),
          ],
        ),
      ),
    ],
  );
}
