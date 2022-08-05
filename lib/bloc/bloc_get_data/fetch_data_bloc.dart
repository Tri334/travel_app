import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:travel_app/models/database.dart';

part 'fetch_data_event.dart';
part 'fetch_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  FetchDataBloc() : super(const FetchDataInitial(refs: [])) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('image');
    on<EventDataInitial>(
      (event, emit) async {
        try {
          List<Reference> dataWithRef = [];
          await collection
              .withConverter(
                  fromFirestore: Place.fromFirestore,
                  toFirestore: (value, options) => value.toFireStore())
              .get()
              .then((value) => value.docs.map((e) {
                    dataWithRef.add(Reference(ref: e.id, place: e.data()));
                  }).toList());
          emit(FetchDataInitial(refs: dataWithRef));
        } catch (e) {
          print(e.toString());
        }
      },
    );
    on<EventFavorite>((event, emit) async {
      try {
        bool values = false;
        await collection.doc(event.docRef).get().then((value) =>
            value['favorite'] == values ? values = true : values = false);
        await collection.doc(event.docRef).update({'favorite': values});
        List<Reference> dataWithRef = [];
        await collection
            .withConverter(
                fromFirestore: Place.fromFirestore,
                toFirestore: (value, options) => value.toFireStore())
            .get()
            .then((value) => value.docs.map((e) {
                  dataWithRef.add(Reference(ref: e.id, place: e.data()));
                }).toList());
        emit(FetchDataInitial(refs: dataWithRef));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
