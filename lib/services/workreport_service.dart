import '../networking/constant.dart';
import '../support/dio_helper.dart';

class WorkreportService {


  static Future WorkreportList(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/workspace',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  static Future WorkreportEdit(data,id) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/workspace/update/$id',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  static Future CreateWorkReport(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/workspace/create', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

}