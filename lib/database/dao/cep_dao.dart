import 'package:floor/floor.dart';
import 'package:viacep/database/entity/cep_entity.dart';

@dao
abstract class CepDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCEP(CepEntity entity);

  @Query("""
    SELECT *
    FROM cep
  """)
  Future<List<CepEntity>> fetchAllCEP();

  @Query("""
    DELETE
    FROM cep
    WHERE id = :id
  """)
  Future<void> deleteEntity(int id);
}
