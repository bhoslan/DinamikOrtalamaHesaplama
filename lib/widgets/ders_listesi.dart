import 'package:dinamik_ortalama_hesaplama/helper/data_helper.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/ders.dart';

class DersListesi extends StatelessWidget {
  final Function onElemanCikarildiginda;
  const DersListesi({required this.onElemanCikarildiginda, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDerslerListesi;

    return tumDersler.length > 0
        ? _derslerinListesi(tumDersler)
        : _dersListesiBossaGosterilecek();
  }

  ListView _derslerinListesi(List<Ders> tumDersler) {
    return ListView.builder(
        itemCount:
            tumDersler.length, //itemCount vermezsen liste boşken hata alırsın
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,
            onDismissed: ((direction) {
              onElemanCikarildiginda(index);
            }),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                child: ListTile(
                  title: Text(tumDersler[index].ad),
                  leading: CircleAvatar(
                    maxRadius: 24,
                    backgroundColor: Sabitler.anaRenk,
                    child: Text((tumDersler[index].harfDegeri *
                            tumDersler[index].krediDegeri)
                        .toStringAsFixed(2)),
                  ),
                  subtitle: Text(
                      "${tumDersler[index].krediDegeri} kredi, not değeri : ${tumDersler[index].harfDegeri}"),
                ),
              ),
            ),
          );
        });
  }

  Container _dersListesiBossaGosterilecek() {
    return Container(
        child: Center(
      child: Text(
        "Lütfen ders ekleyin!",
        style: Sabitler.baslikStyle,
      ),
    ));
  }
}
