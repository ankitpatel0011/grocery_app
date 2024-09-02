import 'package:flutter/widgets.dart';
import 'package:grocery/model/product_model.dart';
import 'package:grocery/utils/colors/app_colors.dart';
import 'package:grocery/utils/widget.dart';

Widget buildProductList({
  required double screenHeight,
  required double screenWidth,
  required List<ProductModel> products,
}) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: products.length,
    itemBuilder: (context, index) {
      ProductModel product = products[index];
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: screenHeight / 8,
              width: screenWidth / 3.8,
              decoration: BoxDecoration(
                color: IconsConstant.shadowGreenColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Image.network(
                  product.image ?? "",
                  height: screenHeight / 12,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: FittedBox(
              child: Text(
                firstLetterCapital(input: product.category ?? ""),
                style: TextStyle(
                  fontSize: screenHeight / 60,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
