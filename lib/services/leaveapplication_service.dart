import '../networking/constant.dart';
import '../support/dio_helper.dart';

class LeaveApplicationService {


  static Future LeaveList(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/leaves', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future Createleave(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/leaves/create',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future LeaveApplicationEdit(data,id) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/leaves/update/$id',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

}