import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Reference {
  final String ref;
  final Place place;

  Reference({required this.ref, required this.place});
}

class Place extends Equatable {
  final String agen, dsc, img, judul, lokasi;
  final List<String> fasilitas;
  final double harga, star;
  bool favorite;
  final Tag tag;

  Place({
    required this.img,
    required this.judul,
    required this.agen,
    required this.dsc,
    required this.favorite,
    required this.harga,
    required this.fasilitas,
    required this.lokasi,
    required this.star,
    required this.tag,
  });

  factory Place.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Place(
      img: data?['img'],
      judul: data?['judul'],
      agen: data?['agen'],
      dsc: data?['dsc'],
      favorite: data?['favorite'],
      harga: data?['harga'],
      fasilitas: data?['fasilitas'].split(','),
      lokasi: data?['lokasi'],
      star: data?['star'],
      tag: Tag.fromFirestrore(snapshot, options),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "img": img,
      "judul": judul,
      "agen": agen,
      "dsc": dsc,
      "favorite": favorite,
      "harga": harga,
      "fasilitas": fasilitas.join(','),
      "lokasi": lokasi,
      "star": star,
      "tag": tag.toFireStore(),
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        agen,
        dsc,
        img,
        judul,
        lokasi,
        fasilitas,
        harga,
        star,
        favorite,
        tag,
      ];
}

class Tag {
  bool popular;
  bool recom;
  Tag({required this.popular, required this.recom});

  factory Tag.fromFirestrore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Tag(popular: data?['tag']['popular'], recom: data?['tag']['recom']);
  }

  Map<String, dynamic> toFireStore() {
    return {"popular": popular, "recom": recom};
  }
}
