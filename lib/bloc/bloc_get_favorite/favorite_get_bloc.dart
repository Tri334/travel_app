import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/models/database.dart';

part 'favorite_get_event.dart';
part 'favorite_get_state.dart';

class FavoriteGetBloc extends Bloc<FavoriteGetEvent, FavoriteGetState> {
  FavoriteGetBloc() : super(const FavoriteGetInitial()) {
    on<EventGetFavorite>((event, emit) async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference favorite = firestore.collection('image');
      List<Reference> favoriteData = [];
      try {
        await favorite
            .where('favorite', isEqualTo: true)
            .withConverter<Place>(
              fromFirestore: Place.fromFirestore,
              toFirestore: (value, options) => value.toFireStore(),
            )
            .get()
            .then((value) => value.docs.map((e) {
                  favoriteData.add(Reference(ref: e.id, place: e.data()));
                }).toList());
        emit(FavoriteGetInitial(newDataFavorite: favoriteData));
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
