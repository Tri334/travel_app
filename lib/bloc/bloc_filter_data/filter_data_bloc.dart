import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/models/database.dart';

part 'filter_data_event.dart';
part 'filter_data_state.dart';

class FilterDataBloc extends Bloc<FilterDataEvent, FilterDataState> {
  FilterDataBloc() : super(FilterDataInitial()) {
    on<EventFilterBy>((event, emit) async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference image = firestore.collection('image');
      Query<Object?> filter;
      bool search = false;

      switch (event.filter) {
        case 'Highest Price':
          filter = image.orderBy('harga', descending: true);
          break;
        case 'Lowest Price':
          filter = image.orderBy('harga', descending: false);
          break;
        case 'Place':
          filter = image.orderBy('judul', descending: false);
          break;
        case 'Review':
          filter = image.orderBy('star', descending: true);
          break;
        default:
          filter = image;
          search = true;
      }
      if (event.filter == '') {
        emit(const FilteringDataState(newDataFilter: [], newFilter: '-'));
      } else if (event.filter != '-') {
        try {
          List<Reference> storage = [];
          await filter
              .withConverter(
                  fromFirestore: Place.fromFirestore,
                  toFirestore: (value, options) => value.toFireStore())
              .get()
              .then((value) => value.docs.map((e) {
                    storage.add(Reference(ref: e.id, place: e.data()));
                  }).toList());
          List<Reference> filterPlace = [];
          RegExp regExp =
              RegExp(r'' + event.filter, caseSensitive: false, multiLine: true);
          if (search == true) {
            for (var element in storage) {
              if (regExp.hasMatch(element.place.judul)) {
                filterPlace
                    .add(Reference(ref: element.ref, place: element.place));
              }
            }
          } else {
            filterPlace = storage;
          }
          emit(FilteringDataState(
              newDataFilter: filterPlace,
              newFilter: search ? '-' : event.filter));
        } catch (e) {
          print(e.toString());
          // emit(const FilteringDataState(newDataFilter: [], newFilter: '-'));
        }
      } else {
        emit(FilteringDataState(
            newDataFilter: const [], newFilter: event.filter));
      }
    });
  }
}
