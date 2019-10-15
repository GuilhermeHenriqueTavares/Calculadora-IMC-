import 'package:flutter/material.dart';
import 'package:calculadora_imc/pessoa.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  int groupValue;
  Pessoa pessoa = new Pessoa();

  @override
  void initState() {
    super.initState();
    _resetFields();
  }

  void _resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      pessoa.imc = " ";
      pessoa.result = "Informe seus dados";
      pessoa.cor = Colors.black;
      groupValue = null;
    });
  }

  void mudarBotao(int valor) {
    setState(() {
      if (valor == 1) {
        groupValue = 1;
      } else if (valor == 2) {
        groupValue = 2;
      }
    });
  }

  void calculo() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100.0;
    pessoa.calculateImc(weight, height, groupValue);

    setState(() {
      pessoa.result = pessoa.resultado;
      pessoa.cor = pessoa.cor;
      pessoa.imc = pessoa.imc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora de IMC',
          style: TextStyle(fontSize: 30.0),
        ),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: buildContainer(),
      ),
    );
  }

  Widget buildContainer() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildTextFormField(
                label: "Peso (Kg)",
                error: "Insira seu peso!",
                controller: _weightController),
                Padding(padding: EdgeInsets.symmetric(vertical: 20.4)),
            buildTextFormField(
                label: "Altura (Cm)",
                error: "Insira sua altura!",
                controller: _heightController),
                Padding(padding: EdgeInsets.symmetric(vertical: 8.4)),
                
            Row(
              children: <Widget>[
                Text("Gênero: ", style: TextStyle(fontSize: 18),),
                Radio(
                  onChanged: (int valor) => mudarBotao(valor),
                  activeColor: Colors.blue,
                  value: 1,
                  groupValue: groupValue,
                ),
                GestureDetector(
                  onTap: () {
                    mudarBotao(1);
                  },
                  child: Text("Masculino"),
                ),
                Radio(
                  onChanged: (int valor) => mudarBotao(valor),
                  activeColor: Colors.pink,
                  value: 2,
                  groupValue: groupValue,
                ),
                GestureDetector(
                  onTap: () {
                    mudarBotao(2);
                  },
                  child: Text("Feminino"),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(pessoa.imc,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(pessoa.result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: pessoa.cor,
                    )),
              ),
            ),
            buildCalculateButton(),
          ],
        ),
      ),
    );
  }

  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        color: Colors.blueAccent,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculo();
          }
        },
        child: Text('CALCULAR',
            style: TextStyle(color: Colors.white, fontSize: 22.0)),
      ),
    );
  }

  Widget buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(7),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}
