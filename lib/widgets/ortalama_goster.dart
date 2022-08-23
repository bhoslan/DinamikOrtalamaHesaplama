import 'package:dinamik_ortalama_hesaplama/constants/app_constants.dart';
import 'package:flutter/material.dart';

class OrtalamaGoster extends StatelessWidget {
  final double ortalama;
  final int dersSayisi;

  const OrtalamaGoster(
      {required this.ortalama, required this.dersSayisi, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dersSayisi > 0 ? "$dersSayisi ders seçildi" : "Ders Seçiniz",
          style: Sabitler.ortalamaGosterBody,
        ),
        Text(
          ortalama > 0 ? ortalama.toStringAsFixed(2) : "0.00",
          style: Sabitler.ortalamaStyle,
        ),
        Text(
          "Ders Sayısı",
          style: Sabitler.ortalamaGosterBody,
        ),
      ],
    );
  }
}
