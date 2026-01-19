import '../networking/constant.dart';
import '../support/dio_helper.dart';

class FollowingService {

  static Future Followlead(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL//telecaller/home', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  static Future Followleadcreate(data,id) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/telecaller/leads/followup/$id/create', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  static Future Followleadstatusupdate(data,id,fid) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/telecaller/leads/followup/$id/show/$fid',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

}
