import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _infoText = 'Informe os dados';

  TextEditingController kmController = TextEditingController();
  TextEditingController litrosController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    kmController.text = '';
    litrosController.text = '';
    setState(() {
      _infoText = 'Informe os dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculo(){
    setState(() {
      double km = double.parse(kmController.text);
      double litros = double.parse(litrosController.text);
      double x = km / litros;
      _infoText = "O carro fez ${x.toStringAsPrecision(2)} km/l";
      print (x);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumo de combustivel'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.local_gas_station, size: 150.0, color: Colors.red),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Km parcial',
                  labelStyle: TextStyle(color: Colors.red)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 25.0),
                controller: kmController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira o km antes de continuar";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Litros abastecidos',
                  labelStyle: TextStyle(color: Colors.red)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 25.0),
                controller: litrosController,
                validator: (value) {
                  if(value.isEmpty){
                    return "Insira os litros antes de continuar";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calculo();
                      }
                    },
                    child: Text('Calcular', style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    color: Colors.red,
                  ),
                ),
              ),
              Text(_infoText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontSize: 25.0),)
            ],
          ),
        ),
      ),
    );
  }
}
