// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:floor/floor.dart';
import 'package:viacep/model/cep_model.dart';

@Entity(tableName: "cep")
class CepEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String cep;
  final String logradouro;
  final String? complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ibge;
  final String gia;
  final String ddd;
  final String siafi;

  CepEntity({
    this.id,
    required this.cep,
    required this.logradouro,
    this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });

  factory CepEntity.fromModelToEntity(CEPModel model) {
    return CepEntity(
      id: model.id,
      cep: model.cep ?? "",
      logradouro: model.logradouro ?? "",
      bairro: model.bairro ?? "",
      complemento: model.complemento,
      localidade: model.localidade ?? "",
      uf: model.uf ?? "",
      ibge: model.ibge ?? "",
      gia: model.gia ?? "",
      ddd: model.ddd ?? "",
      siafi: model.siafi ?? "",
    );
  }
}
