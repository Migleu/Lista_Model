import 'package:flutter/material.dart';
import 'package:money_search/data/MoneyController.dart';
import 'package:money_search/model/ListPersonModel.dart';
import 'package:money_search/model/MoneyModel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}
/// instancia do modelo para receber as informações
List<ListPersonModel> model = [];

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de pessoas'),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: FutureBuilder<List<ListPersonModel>>(
          ///future: local onde informções serão buscadas
          future: MoneyController().getListPerson(),
          builder: (context, snapshot) {
            /// validação de carregamento da conexão
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            /// validação de erro
            if (snapshot.error == true) {
              return SizedBox(
                height: 300,
                child: Text("Vazio"),
              );
            }
            /// passando informações para o modelo criado
            model = snapshot.data ?? model;
            model.sort((a , b) => a.name!.compareTo(b.name!),
            );
            return ListView.builder(
              itemCount: model.length,
              itemBuilder: (context, index) {
                 ListPersonModel item = model[index];
                 
                 return Text(item.name ?? "");
              }
              );
          },
        ));
  }

  Future<Null> refresh() async {
    setState(() {});
  }
}
