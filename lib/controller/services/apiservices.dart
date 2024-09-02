import 'package:grocery/controller/api_controller/api.dart';

class ApiService {
  static Future<dynamic> fetchProducts() async {
    return Api().request(
      url: "products",
      method: RequestMethod.get,
      header: Api.authHeader,
    );
  }

  static Future<dynamic> fetchCategory() async {
    return Api().request(
      url: "products/categories",
      method: RequestMethod.get,
      header: Api.authHeader,
    );
  }
}
