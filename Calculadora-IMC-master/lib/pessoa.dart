import 'package:flutter/material.dart';


class Pessoa{
  double height, weight, imcCalculo;
  Color cor;
  String resultado = "", imc = "";

  var result;

  void calculateImc(double weight, double height, int groupValue) {
    double imcCalculo = weight / (height * height);

    imc = "IMC = ${imcCalculo.toStringAsFixed(2)}";

     if (groupValue == 1) {
      if (imcCalculo < 20.7) {
        resultado = "Abaixo do peso";
        cor = Colors.blue;
      } else if (imcCalculo < 26.4) {
        resultado = "Peso ideal";
        cor = Colors.green;
      } else if (imcCalculo < 27.8) {
        resultado = "Pouco acima do peso";
        cor = Colors.yellow;
      } else if (imcCalculo < 31.1) {
        resultado = "Acima do peso";
        cor = Colors.orange;
      } else {
        resultado = "Obesidade";
        cor = Colors.red;
      }
    } else if (groupValue == 2) {
      if (imcCalculo < 19.1) {
        resultado = "Abaixo do peso";
        cor = Colors.blue;
      } else if (imcCalculo < 25.8) {
        resultado = "Peso ideal";
        cor = Colors.green;
      } else if (imcCalculo < 27.3) {
        resultado = "Pouco acima do peso";
        cor = Colors.yellow;
      } else if (imcCalculo < 32.3) {
        resultado = "Acima do peso";
        cor = Colors.orange;
      } else {
        resultado = "Obesidade";
        cor = Colors.red;
      }
    }

  }
}