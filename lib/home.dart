import 'package:flutter/material.dart';
import 'package:viacep/database/dao/cep_dao.dart';
import 'package:viacep/model/cep_model.dart';
import 'package:viacep/repository/cep_repository.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
    required this.cepDao,
  });

  final CepDao cepDao;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController cepTextEditingController =
      TextEditingController();

  late CepRepository repository;

  @override
  void initState() {
    repository = CepRepository(cepDao: widget.cepDao);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Consulta de CEPs"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: cepTextEditingController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Informe o CEP que deseja consultar',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    repository
                        .searchCEP(cep: cepTextEditingController.text)
                        .then((value) {
                      setState(
                        () {
                          cepTextEditingController.clear();
                        },
                      );
                    });
                  },
                  child: const Text("Buscar"),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Text("Histórico de buscas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),),
          SizedBox(height: 30,),
          SingleChildScrollView(
            child: FutureBuilder(
                future: repository.fetchAllCEPOnDatabase(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final CEPModel element = snapshot.data![index];
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: const Color.fromARGB(255, 248, 124, 115),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Icon(Icons.delete_forever),
                          ),
                          onDismissed: (_) async {
                            await repository.deleteCEPOnDatabase(
                                id: element.id!);
                            await repository.fetchAllCEPOnDatabase();
                          },
                          key: ValueKey<int>(element.id!),
                          child: Container(
                            width: double.infinity,
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Consulta ${element.id}", style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      Text("CEP: ${element.cep ?? " CEP não encontrado"}"
                                          ),
                                      Text("Logradouro: ${element.logradouro ??
                                          "Logradouro não encontrado"}"),
                                      
                                      Row(
                                        children: [
                                          Text(element.localidade ?? ""),
                                          Text(" - "),
                                          Text(element.uf ?? " "),
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        );
                      }),
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return Center(
                      child: Text("Nenhum CEP foi consultado", style: TextStyle(fontSize: 14),),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
