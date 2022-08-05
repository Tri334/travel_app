part of 'fetch_data_bloc.dart';

enum Update { noUpdate, newUpdate }

abstract class FetchDataState extends Equatable {
  const FetchDataState({
    this.ref = const [],
  });
  final List<Reference> ref;
  @override
  List<Object> get props => [ref];
}

class FetchDataInitial extends FetchDataState {
  const FetchDataInitial({required this.refs}) : super(ref: refs);
  final List<Reference> refs;

  @override
  List<Object> get props => [
        refs,
      ];
}
