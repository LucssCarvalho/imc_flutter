import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";
  double result_imc = 0;
  String resul_ideal;

  void _resetFilds() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      double idealMin = 18.6 * (height * height);
      double ideialMax = 24.9 * (height * height);

      if (imc < 18.6) {
        _infoText = 'Abaixo do Peso';
        result_imc = imc;
        resul_ideal = 'Seu peso ideial está entre: ' +
            idealMin.toStringAsPrecision(4) +
            ' e ' +
            ideialMax.toStringAsPrecision(4);
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso Ideal';
        result_imc = imc;
        resul_ideal = 'Parabéns';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente Acima do Peso';
        result_imc = imc;
        resul_ideal = 'Seu peso ideial está entre: ' +
            idealMin.toStringAsPrecision(4) +
            ' e ' +
            ideialMax.toStringAsPrecision(4);
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I';
        result_imc = imc;
        resul_ideal = 'Seu peso ideial está entre: ' +
            idealMin.toStringAsPrecision(4) +
            ' e ' +
            ideialMax.toStringAsPrecision(4);
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II';
        result_imc = imc;
        resul_ideal = 'Seu peso ideial está entre: ' +
            idealMin.toStringAsPrecision(4) +
            ' e ' +
            ideialMax.toStringAsPrecision(4);
      } else if (imc >= 40) {
        _infoText = 'Obesidade Grau III';
        result_imc = imc;
        resul_ideal = 'Seu peso ideial está entre: ' +
            idealMin.toStringAsPrecision(4) +
            ' e ' +
            ideialMax.toStringAsPrecision(4);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFilds,
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'imc_logo.png',
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      'IMC - Índice de Massa Corporal',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.cyan[600],
                          fontSize: 25.0,
                          fontFamily: 'RobotoMono'),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(
                          color: Colors.blue[900],
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue[800], fontSize: 25.0),
                      controller: weightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira seu Peso!";
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(
                          color: Colors.blue[900],
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue[800], fontSize: 25.0),
                      controller: heightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua Altura!";
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    _infoText,
                                    result_imc,
                                    resul_ideal,
                                  ),
                                ),
                              );
                            }
                            _calculate();
                          },
                          child: Text(
                            'Calcular',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                    Text(
                      'Informe seus dados!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue[900], fontSize: 25.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  String _infoText;
  double imc;
  String idealPeso;
  DetailPage(this._infoText, this.imc, this.idealPeso);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          ('Dados:'),
        ),
      ),
      body: Container(
        color: Colors.blue[800],
        padding: EdgeInsets.all(25),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(
              const Radius.circular(40.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Seu IMC é: ' + widget.imc.toStringAsPrecision(4),
                style: TextStyle(fontSize: 30.0, color: Colors.blueGrey[900]),
              ),
              aparecerImagem(widget.imc),
              Text(
                widget._infoText,
                style: TextStyle(fontSize: 20.0, color: Colors.blue),
              ),
              Text(
                widget.idealPeso,
                style: TextStyle(fontSize: 15.0, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget aparecerImagem(double imc) {
  String corp_1 = 'corp_1.png';
  String corp_2 = 'corp_2.png';
  String corp_3 = 'corp_3.png';
  String corp_4 = 'corp_4.png';
  String corp_5 = 'corp_5.png';
  String corp_6 = 'corp_6.png';

  if (imc < 18.6) {
    return Center(
      child: Container(
        child: Image.asset(
          corp_1,
          fit: BoxFit.contain,
        ),
      ),
    );
  } else if (imc >= 18.6 && imc < 24.9) {
    return Center(
      child: Container(
        child: Image.asset(
          corp_2,
          fit: BoxFit.contain,
        ),
      ),
    );
  } else if (imc >= 24.9 && imc < 29.9) {
    return Center(
      child: Container(
        child: Image.asset(
          corp_3,
          fit: BoxFit.contain,
        ),
      ),
    );
  } else if (imc >= 29.9 && imc < 34.9) {
    return Center(
      child: Container(
        child: Image.asset(
          corp_4,
          fit: BoxFit.contain,
        ),
      ),
    );
  } else if (imc >= 34.9 && imc < 39.9) {
    return Center(
      child: Container(
        child: Image.asset(
          corp_5,
          fit: BoxFit.contain,
        ),
      ),
    );
  } else if (imc >= 40) {
    return Center(
      child: Container(
        child: Image.asset(
          corp_6,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
