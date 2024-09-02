import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery/view/screens/category_details.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/provider.dart';
import '../../model/product_model.dart';
import '../../utils/colors/app_colors.dart';
import '../../utils/widget.dart';
import '../../utils/widgets/custom_appbar.dart';
import 'all_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<ProductProvider>().fetchProducts();
      await context.read<ProductProvider>().fetchCategory();
      await context.read<ProductProvider>().fetchSliderImage();
      _startAutoSlide();
    });
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page! + 1).toInt() %
            context.read<ProductProvider>().sliderImages.length;
        _pageController.animateToPage(nextPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.green,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: Colors.green,
          snap: true,
          forceElevated: true,
          floating: true,
          pinned: true,
          toolbarHeight: screenHeight / 13,
          titleSpacing: 1.5,
          title: PreferredSize(
              preferredSize: Size.fromHeight(screenHeight / 14),
              child: const CustomAppBar()),
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(screenHeight / 9.89),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: GestureDetector(
                  child: Container(
                    height: screenHeight / 15,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5), width: 0.5)),
                    child: TextField(
                     readOnly: true,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            top: 15,
                          ),
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          hintText: "Search your daily grocery food...",
                          hintStyle: TextStyle(
                              fontSize: screenHeight / 55, color: Colors.grey)),
                    ),
                  ),
                  onTap: () {
                    // Navigate to search screen
                  },
                ),
              )),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              // main background container
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: screenHeight / 3.8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight / 45),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllCategoryScreen(),
                                            ));
                                      },
                                      child: const Text(
                                        "See all",
                                        style: TextStyle(color: Colors.green),
                                      )),
                                ],
                              ),
                              Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: productProvider.categoryProducts.length < 5
                                      ? productProvider.categoryProducts.length
                                      : 4,
                                  itemBuilder: (context, index) {
                                    ProductModel? ds = productProvider.categoryProducts.isNotEmpty
                                        ? productProvider.categoryProducts[index]
                                        : null;

                                    if (ds == null) {
                                      return const SizedBox.shrink(); // Return an empty widget if null
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CategoryDetails(ds: ds,),
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
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(13),
                                                child: Image.network(
                                                  ds.image ?? "",
                                                  height: screenHeight / 12,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return const Icon(Icons.error);
                                                  },
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
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: screenHeight / 4, // Adjusted height
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: productProvider.sliderImages.isNotEmpty
                              ? PageView.builder(
                                  controller: _pageController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      productProvider.sliderImages.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 15),
                                      child: Container(
                                        width: screenWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          image: DecorationImage(
                                            image: NetworkImage(productProvider
                                                .sliderImages[index]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator()),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 45,
                      ),
                      Container(
                        height: screenHeight / 3.8,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Popular deals",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenHeight / 45),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllCategoryScreen(),
                                            ));
                                      },
                                      child: const Text(
                                        "See all",
                                        style: TextStyle(color: Colors.green),
                                      )),
                                ],
                              ),
                              Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: productProvider.categoryProducts.length < 5
                                      ? productProvider.categoryProducts.length
                                      : 4,
                                  itemBuilder: (context, index) {
                                    ProductModel? ds =
                                        productProvider.categoryProducts.isNotEmpty
                                            ? productProvider.categoryProducts[index]
                                            : null;

                                    if (ds == null) {
                                      return const SizedBox
                                          .shrink(); // Return an empty widget if null
                                    }

                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Container(
                                            height: screenHeight / 8,
                                            width: screenWidth / 3.8,
                                            decoration: BoxDecoration(
                                              color: IconsConstant
                                                  .shadowGreenColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(13),
                                              child: Image.network(
                                                ds.image ?? "",
                                                height: screenHeight / 12,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(Icons
                                                      .error); // Display error icon if image fails to load
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: FittedBox(
                                            child: Text(
                                              firstLetterCapital(
                                                  input: ds.category ?? ""),
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
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
