import 'package:flutter/material.dart';

import '../models/ders.dart';

class DataHelper {
  static List<Ders> tumEklenenDerslerListesi = [];
  static dersEkle(Ders eklenecekDers) {
    tumEklenenDerslerListesi.add(eklenecekDers);
  }

  static double ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var element in tumEklenenDerslerListesi) {
      toplamNot = toplamNot + (element.harfDegeri * element.krediDegeri);
      toplamKredi += element.krediDegeri;
    }
    return toplamNot / toplamKredi;
  }

  static List<String> _tumDerslerinHarfleri() {
    return ["AA", "AB", "BA", "BB", "BC", "CB", "CC", "DC", "FD", "FF"];
  }

  static double _harfiNotaCevir(String harf) {
    switch (harf) {
      case "AA":
        return 4;
      case "AB":
        return 3.7;
      case "BA":
        return 3.4;
      case "BB":
        return 3.0;
      case "BC":
        return 2.7;
      case "CB":
        return 2.3;
      case "CC":
        return 2.0;
      case "DC":
        return 1.5;
      case "DD":
        return 1;
      case "FF":
        return 0;
      default:
        return 1;
    }
  }

  static List<DropdownMenuItem<double>> tumDerslerinHarfleri() {
    return _tumDerslerinHarfleri()
        .map((e) => DropdownMenuItem(child: Text(e), value: _harfiNotaCevir(e)))
        .toList();
  }

  static List<int> _tumKrediler() {
    return List.generate(10, (index) => index + 1).toList();
  }

  static List<DropdownMenuItem<double>> tumDerslerinKredileri() {
    return _tumKrediler()
        .map((e) => DropdownMenuItem(
              child: Text(e.toString()),
              value: e.toDouble(),
            ))
        .toList();
  }
}
