import 'dart:convert';

import 'package:viacep/database/entity/cep_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CEPModel {
  final int? id;
  final String? cep;
  final String? logradouro;
  final String? complemento;
  final String? bairro;
  final String? localidade;
  final String? uf;
  final String? ibge;
  final String? gia;
  final String? ddd;
  final String? siafi;
  final bool? erro;

  CEPModel({
    this.id,
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
    this.erro,
  });

  factory CEPModel.fromEntityToModel(CepEntity entity) => CEPModel(
        id: entity.id,
        cep: entity.cep,
        logradouro: entity.logradouro,
        complemento: entity.complemento,
        bairro: entity.bairro,
        localidade: entity.localidade,
        uf: entity.uf,
        ibge: entity.ibge,
        gia: entity.gia,
        ddd: entity.ddd,
        siafi: entity.siafi,
        erro: false,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'ibge': ibge,
      'gia': gia,
      'ddd': ddd,
      'siafi': siafi,
      'erro': erro,
    };
  }

  factory CEPModel.fromMap(Map<String, dynamic> map) {
    return CEPModel(
      id: map['id'] != null ? map['id'] as int : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      logradouro:
          map['logradouro'] != null ? map['logradouro'] as String : null,
      complemento:
          map['complemento'] != null ? map['complemento'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      localidade:
          map['localidade'] != null ? map['localidade'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      ibge: map['ibge'] != null ? map['ibge'] as String : null,
      gia: map['gia'] != null ? map['gia'] as String : null,
      ddd: map['ddd'] != null ? map['ddd'] as String : null,
      siafi: map['siafi'] != null ? map['siafi'] as String : null,
      erro: map['erro'] != null ? map['erro'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CEPModel.fromJson(String source) =>
      CEPModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
