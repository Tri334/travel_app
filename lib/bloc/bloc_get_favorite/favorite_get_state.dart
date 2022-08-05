part of 'favorite_get_bloc.dart';

abstract class FavoriteGetState extends Equatable {
  const FavoriteGetState({this.dataFavorite = const []});
  final List<Reference> dataFavorite;

  @override
  List<Object> get props => [dataFavorite];
}

class FavoriteGetInitial extends FavoriteGetState {
  const FavoriteGetInitial({this.newDataFavorite = const []})
      : super(dataFavorite: newDataFavorite);
  final List<Reference> newDataFavorite;

  @override
  List<Object> get props => [newDataFavorite];
}
