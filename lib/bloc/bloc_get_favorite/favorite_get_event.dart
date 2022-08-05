part of 'favorite_get_bloc.dart';

abstract class FavoriteGetEvent extends Equatable {
  const FavoriteGetEvent();

  @override
  List<Object> get props => [];
}

class EventGetFavorite extends FavoriteGetEvent {}
