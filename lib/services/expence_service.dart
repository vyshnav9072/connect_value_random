import '../networking/constant.dart';
import '../support/dio_helper.dart';

class ExpenceService {


  static Future ExpenceList(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/expense',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }



  static Future CreateExpence(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/expense/create', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  static Future ExpenceEdit(data,id) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/expense/update/$id',data:data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


}