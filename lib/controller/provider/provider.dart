import 'package:flutter/cupertino.dart';
import 'package:grocery/model/product_model.dart';
import 'package:grocery/controller/services/apiservices.dart';

ProductProvider productProvider = ProductProvider();

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<String> _sliderImages = [];
  List _category = [];
  bool _isLoading = false;
  List<int> _cartCounts = [];
  int index = 0;
  final List<ProductModel> _categoryProducts = [];
  final List<ProductModel> _filteredProductsByCategory = [];

  List get categoryProducts=> _categoryProducts;
  List get products => _products;

  List get category => _category;

  bool get isLoading => _isLoading;

  List<String> get sliderImages => _sliderImages;

  List<int> get cartCounts => _cartCounts;

  set setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future fetchProducts() async {
    setLoading = true;

    await ApiService.fetchProducts().then((onValue) {
      if (onValue is List) {
        _products =
            List.from(onValue.map((e) => ProductModel.fromJson(e)).toList());
        // Initialize cart counts with 0 for each product
        _cartCounts = List<int>.filled(_products.length, 0);
      }
    });

    setLoading = false;
    notifyListeners();
  }

  Future fetchCategory() async {
    setLoading = true;

    await ApiService.fetchCategory().then((onValue) {
      if (onValue is List) {
        _category = List.from(onValue.map((e) => e).toList());
      }
    });
    addCategoryProducts();
    setLoading = false;
    notifyListeners();
  }

  addCategoryProducts() {
    for (var category in category) {
      for (var product in products) {
        if (product.category.toString() == category.toString()) {
          _categoryProducts.add(product);
          break;
        }
      }
    }
    notifyListeners();
  }

  filterProductsCategory(String category) {
    _filteredProductsByCategory.clear();
    for (var product in products) {
      if (product.category.toString() == category.toString()) {
        _filteredProductsByCategory.add(product);
      }
    }
    notifyListeners();
  }

  Future fetchSliderImage() async {
    setLoading = true;

    await ApiService.fetchProducts().then((onValue) {
      if (onValue is List) {
        // Print the response to debug
        print("Slider Image Response: $onValue");

        // Ensure the items have 'image' field and the correct type
        _sliderImages = List<String>.from(
          onValue
              .map((item) {
                // Ensure that 'image' field exists and is a String
                if (item is Map<String, dynamic> && item.containsKey('image')) {
                  return item['image'] as String;
                } else {
                  // Handle unexpected formats
                  return '';
                }
              })
              .where((url) => url.isNotEmpty) // Filter out empty strings
              .toList(),
        );
      }
    });

    setLoading = false;
    notifyListeners();
  }

  void incrementProductQuantity(int productIndex) {
    _cartCounts[productIndex]++;
    print("Incremented: ankit");
    notifyListeners();
  }

  void decrementProductQuantity(int productIndex) {
    if (_cartCounts[productIndex] > 0) {
      _cartCounts[productIndex]--;
      notifyListeners();
    }
  }
}
