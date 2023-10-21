import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:viacep/model/cep_model.dart';

class Network {
  final _dio = Dio();

  Network() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
      ),
    );
  }

  Future<CEPModel?> fetchAddressByCep({
    required String cep,
  }) async {
    final Response<dynamic> result =
        await _dio.get("https://viacep.com.br/ws/$cep/json/");

    if (result.statusCode == 200 || result.statusCode == 204) {
      final cepModel = CEPModel.fromMap(result.data as Map<String, dynamic>);

      if (cepModel.erro != null && cepModel.erro!) {
        return null;
      }

      return cepModel;
    }

    return null;
  }
}
