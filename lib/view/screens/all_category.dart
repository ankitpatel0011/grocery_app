import 'package:flutter/material.dart';
import 'package:grocery/controller/provider/provider.dart';
import 'package:grocery/model/product_model.dart';
import 'package:grocery/utils/colors/app_colors.dart';
import 'package:grocery/utils/widget.dart';
import 'package:grocery/view/screens/category_details.dart';
import 'package:provider/provider.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await productProvider.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        toolbarHeight: screenHeight / 13,
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: screenHeight / 40,
              color: Colors.white,
            )),
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 0.2,
              mainAxisSpacing: 0.3,
              childAspectRatio: 0.85,
            ),
            itemCount: productProvider.products.length,
            itemBuilder: (BuildContext context, int index) {
              ProductModel ds = productProvider.products[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetails(
                        ds: ds,
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: screenHeight / 8,
                        width: screenWidth / 3.8,
                        decoration: BoxDecoration(
                            color: IconsConstant.shadowGreenColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Image.network(
                            ds.image ?? "",
                            height: screenHeight / 12,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: FittedBox(
                          child: Text(
                        firstLetterCapital(input: ds.category ?? ""),
                        style: TextStyle(
                            fontSize: screenHeight / 60,
                            fontWeight: FontWeight.w600),
                      )),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
