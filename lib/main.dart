import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void reset(){
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcImc(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.6){
        _infoText = 'Abaixo do peso ! ${imc.toStringAsPrecision(3)}';
      }else if(imc >= 18.6 && imc <24.9){
        _infoText = 'Peso ideal ! ${imc.toStringAsPrecision(3)}';
      }else if(imc >= 18.6 && imc <29.9){
        _infoText = 'Levemente acima ! ${imc.toStringAsPrecision(3)}';
      }else if(imc >= 29.9 && imc <34.9){
        _infoText = 'Obesidade grau I ${imc.toStringAsPrecision(3)}';
      }else if(imc >= 34.9 && imc <39.9){
        _infoText = 'Obesidade grau II! ${imc.toStringAsPrecision(3)}';
      }else if(imc >= 40){
        _infoText = 'Obesidade grau III! ${imc.toStringAsPrecision(3)}';
      }
    });

  }

  String _infoText = 'Informe seus dados!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: reset,
          )
        ],
      ),
      backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.account_circle, size: 120, color: Colors.redAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontSize:16.0
                  ),
                  labelText: 'Peso (KG)',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                ),
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
                controller: weightController,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Insira um valor válido.';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontSize: 16.0
                  ),
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                ),
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
                controller: heightController,
                validator: (value) {
                  if(value!.isEmpty){
                    return 'Insira um valor válido.';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top:20.0, bottom: 10.0),
                child: Container(
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calcImc();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    style:ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.0),),
            ],
          ),
        ),
      ),
    );
  }
}
