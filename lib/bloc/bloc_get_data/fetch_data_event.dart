part of 'fetch_data_bloc.dart';

abstract class FetchDataEvent extends Equatable {
  const FetchDataEvent({this.docRef = ''});
  final String docRef;

  @override
  List<Object> get props => [docRef];
}

class EventDataInitial extends FetchDataEvent {}

class EventFavorite extends FetchDataEvent {
  const EventFavorite({required this.updateFavorite})
      : super(docRef: updateFavorite);
  final String updateFavorite;

  @override
  List<Object> get props => [updateFavorite];
}
