import 'package:dinamik_ortalama_hesaplama/helper/data_helper.dart';
import 'package:dinamik_ortalama_hesaplama/models/ders.dart';
import 'package:dinamik_ortalama_hesaplama/widgets/ders_listesi.dart';
import 'package:dinamik_ortalama_hesaplama/widgets/harf_dropdown_widget.dart';
import 'package:dinamik_ortalama_hesaplama/widgets/kredi_dropdown_widget.dart';
import 'package:dinamik_ortalama_hesaplama/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({Key? key}) : super(key: key);

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Sabitler.baslikText,
              style: Sabitler.baslikStyle,
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //form
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                    ortalama: DataHelper.ortalamaHesapla(),
                    dersSayisi: DataHelper.tumEklenenDerslerListesi.length),
              ),
            ],
          ),
          //liste
          Expanded(
            child: DersListesi(
              onElemanCikarildiginda: (index) {
                DataHelper.tumEklenenDerslerListesi.removeAt(index);
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Form _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 4),
                child: _buildTextFormField()),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: Sabitler.yatayPadding8,
                    child: HarfDropdownWidget(onHarfSecildi: (harf) {
                      secilenHarfDegeri = harf;
                    }),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: Sabitler.yatayPadding8,
                    child: KrediDropdownWidget(onKrediSecildi: (kredi) {
                      secilenKrediDegeri = kredi;
                    }),
                  ),
                ),
                IconButton(
                  onPressed: _dersEkleVeOrtalamaHesapla,
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                  color: Sabitler.anaRenk,
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ));
  }

  TextFormField _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Ders adı giriniz";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        hintText: "Matematik",
        border: OutlineInputBorder(borderRadius: Sabitler.borderRadius),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3),
      ),
    );
  }

  void _dersEkleVeOrtalamaHesapla() {
    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);
      DataHelper.dersEkle(eklenecekDers);
      _formKey.currentState!.reset();
      setState(() {});
    }
  }
}
