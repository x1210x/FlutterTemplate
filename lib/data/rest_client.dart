import 'package:dio/dio.dart';
import 'package:flutter_template/data/model/product.dart';
import 'package:intl/intl.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

Map<String, String> headers = { };

@RestApi(baseUrl: 'https://dummyjson.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('products')
  Future<Products> getProducts();
}

DateTime? dateTimeFromString(String? text) {
  if (text != null) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(text);
  } else {
    return null;
  }
}