import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/controller/provider/provider.dart';
import 'package:grocery/model/product_model.dart';
import 'package:grocery/view/screens/all_category.dart';
import 'package:grocery/view/screens/category_details.dart';
import 'package:grocery/view/screens/categorywise_data.dart';
import 'package:grocery/view/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../utils/colors/app_colors.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  var iconList = [
    CupertinoIcons.square_grid_2x2,
    CupertinoIcons.archivebox,
    CupertinoIcons.gift,
    CupertinoIcons.slider_horizontal_3
  ];
  var labelList = ["Home", "Order", "Offer", "More"];
  var _bottomNavIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    // CategoryDetails(ds: ProductModel()),
    Container(
      child: Center(child: Text("Order Screen")
      ),
    ),
    const AllCategoryScreen(),
    const CategoryWiseScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBg,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: Badge(
            label:
                Consumer<ProductProvider>(builder: (context, provider, index) {
              int totalCartCount =
                  provider.cartCounts.fold(0, (sum, count) => sum + count);

              return Text(totalCartCount.toString());
              //Text("${provider.cartItemsCount}");
            }),
            backgroundColor: CupertinoColors.activeOrange,
            alignment: Alignment.topCenter,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: const BorderSide(
                      color: CupertinoColors.activeGreen, width: 5)),
              backgroundColor: Colors.white,
              splashColor: Colors.green.withOpacity(0.5),
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.cart,
                color: CupertinoColors.activeGreen,
              ),
              //params
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        gapLocation: GapLocation.center,
        backgroundColor: CupertinoColors.activeGreen,
        elevation: 0,
        itemCount: iconList.length,
        height: 60,
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 25,
        rightCornerRadius: 25,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
              ),
              Text(
                labelList[index],
                style: TextStyle(
                    color: isActive
                        ? Colors.white
                        : Colors.white.withOpacity(0.5)),
              )
            ],
          );
        },
        activeIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
      body: _screens[_bottomNavIndex],
    );
  }
}

// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:grocery/controller/provider/provider.dart';
// import 'package:grocery/model/product_model.dart';
// import 'package:grocery/view/screens/all_category.dart';
// import 'package:grocery/view/screens/category_details.dart';
// import 'package:grocery/view/screens/categorywise_data.dart';
// import 'package:grocery/view/screens/home_screen.dart';
// import 'package:provider/provider.dart';
// import '../utils/colors/app_colors.dart';

// class MainLayout extends StatefulWidget {
//   const MainLayout({super.key});

//   @override
//   State<MainLayout> createState() => _MainLayoutState();
// }

// class _MainLayoutState extends State<MainLayout> {
//   var iconList = [
//     CupertinoIcons.square_grid_2x2,
//     CupertinoIcons.archivebox,
//     CupertinoIcons.gift,
//     CupertinoIcons.slider_horizontal_3
//   ];
//   var labelList = ["Home", "Order", "Offer", "More"];
//   var _bottomNavIndex = 0;

//   final List<Widget> _screens = [
//     const HomeScreen(),
//     Container(child: Placeholder(),),
//     const AllCategoryScreen(),
//     const CategoryWiseScreen()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appBg,
//       floatingActionButton: Consumer<ProductProvider>(
//         builder: (context, provider, child) {
//           int totalCartCount = provider.cartCounts.fold(0, (sum, count) => sum + count);
//           return SizedBox(
//             width: 70,
//             height: 70,
//             child: FittedBox(
//               child: Badge(
//                 label: Text(totalCartCount.toString()),
//                 backgroundColor: CupertinoColors.activeOrange,
//                 alignment: Alignment.topCenter,
//                 child: FloatingActionButton(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(100),
//                       side: const BorderSide(
//                           color: CupertinoColors.activeGreen, width: 5)),
//                   backgroundColor: Colors.white,
//                   splashColor: Colors.green.withOpacity(0.5),
//                   onPressed: () {},
//                   child: const Icon(
//                     CupertinoIcons.cart,
//                     color: CupertinoColors.activeGreen,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: AnimatedBottomNavigationBar.builder(
//         gapLocation: GapLocation.center,
//         backgroundColor: CupertinoColors.activeGreen,
//         elevation: 0,
//         itemCount: iconList.length,
//         height: 60,
//         notchSmoothness: NotchSmoothness.defaultEdge,
//         leftCornerRadius: 25,
//         rightCornerRadius: 25,
//         tabBuilder: (int index, bool isActive) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 iconList[index],
//                 color: isActive ? Colors.white : Colors.white.withOpacity(0.7),
//               ),
//               Text(
//                 labelList[index],
//                 style: TextStyle(
//                     color: isActive
//                         ? Colors.white
//                         : Colors.white.withOpacity(0.5)),
//               )
//             ],
//           );
//         },
//         activeIndex: _bottomNavIndex,
//         onTap: (index) {
//           setState(() {
//             _bottomNavIndex = index;
//           });
//         },
//       ),
//       body: _screens[_bottomNavIndex],
//     );
//   }
// }
