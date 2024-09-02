import 'package:flutter/material.dart';
import 'package:grocery/controller/provider/provider.dart';
import 'package:grocery/model/product_model.dart';
import 'package:grocery/utils/widget.dart';
import 'package:grocery/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

class CategoryWiseScreen extends StatefulWidget {
  const CategoryWiseScreen({super.key});

  @override
  State<CategoryWiseScreen> createState() => _CategoryWiseScreenState();
}

class _CategoryWiseScreenState extends State<CategoryWiseScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        toolbarHeight: screenHeight / 13,
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const HomeScreen(),
            //     ));
          },
          icon: Icon(Icons.arrow_back_ios,
              size: screenHeight / 40, color: Colors.white),
        ),
        title: const Text(
          "Fruits",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Consumer<ProductProvider>(
            builder: (context, productProvider, child) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.80,
                ),
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  ProductModel ds = productProvider.products[index];
                  int quantity = productProvider.cartCounts[index];

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: screenHeight / 8,
                          width: double.infinity,
                          child: Image.network(
                            ds.image ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    firstLetterCapital(
                                        input: ds.category ?? ""),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight / 65),
                                  ),
                                  Text("\$${ds.price}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize: screenHeight / 65)),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20)),
                                ),
                                child: Column(
                                  children: [
                                    if (quantity > 0)
                                      InkWell(
                                        onTap: () {
                                          productProvider
                                              .decrementProductQuantity(index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(Icons.remove,
                                              size: screenHeight / 38,
                                              color: Colors.white),
                                        ),
                                      ),
                                    if (quantity > 0)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          "$quantity",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    InkWell(
                                      onTap: () {
                                        productProvider
                                            .incrementProductQuantity(index);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(Icons.add,
                                            size: screenHeight / 38,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
