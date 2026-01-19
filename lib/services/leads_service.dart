import '../networking/constant.dart';
import '../support/dio_helper.dart';

class LeadService {


  static Future Createlead(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/telecaller/leads/create',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future LeadPageStates() async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL//location/state');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future LeadPageDistrict() async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL//location/district');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future LeadPageservice() async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL//home/services/search');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future LeadList(data) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/telecaller/leads', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future LeadInnerPage(id) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/telecaller/leads/$id');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future LeadCommentsAddPage(data,id) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/telecaller/leads/comments/create/$id',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future LeadAmountAddPage(data,id) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/telecaller/leads/amount/$id',data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future Leadstatusupdate(data,id) async {
    try {
      var dio = await DioHelper.getInstance();
      var response = await dio.post('$baseURL/telecaller/leads/status/$id',data:data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}