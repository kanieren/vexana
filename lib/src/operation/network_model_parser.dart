part of '../network_manager.dart';

extension _CoreServiceExtension on NetworkManager {
  dynamic _getBodyModel(dynamic data) {
    if (data is INetworkModel) {
      return data.toJson();
    } else if (data != null) {
      return jsonEncode(data);
    } else {
      return data;
    }
  }

  R? _parseBody<R, T extends INetworkModel>(dynamic responseBody, T model) {
    try {
      if (responseBody is List) {
        return responseBody.map((data) => model.fromJson(data)).cast<T>().toList() as R;
      } else if (responseBody is Map<String, dynamic>) {
        return model.fromJson(responseBody) as R;
      } else {
        return EmptyModel(name: responseBody.toString()) as R;
      }
    } catch (e) {
      Logger().e('Parse Error: $e - response body: $responseBody T model: $T , R model: $R ');
    }
  }
}
