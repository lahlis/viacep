import 'package:viacep/database/dao/cep_dao.dart';
import 'package:viacep/database/entity/cep_entity.dart';
import 'package:viacep/model/cep_model.dart';
import 'package:viacep/network/network.dart';

class CepRepository {
  CepRepository({
    required this.cepDao,
  });

  final CepDao cepDao;
  final Network network = Network();

  Future<void> searchCEP({
    required String cep,
  }) async {
    final CEPModel? result = await network.fetchAddressByCep(cep: cep);

    if (result != null) {
      await _createCEPOnDatabase(cep: result);
    }
  }

  Future<void> _createCEPOnDatabase({
    required CEPModel cep,
  }) async {
    final CepEntity entity = CepEntity.fromModelToEntity(cep);
    await cepDao.insertCEP(entity);
  }

  Future<List<CEPModel>> fetchAllCEPOnDatabase() async {
    final List<CepEntity> result = await cepDao.fetchAllCEP();

    return result.map((e) => CEPModel.fromEntityToModel(e)).toList();
  }

  Future<void> deleteCEPOnDatabase({
    required int id,
  }) async {
    await cepDao.deleteEntity(id);
  }
}
