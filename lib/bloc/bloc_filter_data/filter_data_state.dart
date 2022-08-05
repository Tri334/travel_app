part of 'filter_data_bloc.dart';

abstract class FilterDataState extends Equatable {
  const FilterDataState({this.dataFilter = const [], this.filter = '-'});
  final List<Reference> dataFilter;
  final String filter;

  @override
  List<Object> get props => [dataFilter, filter];
}

class FilterDataInitial extends FilterDataState {}

class FilteringDataState extends FilterDataState {
  const FilteringDataState(
      {required this.newDataFilter, required this.newFilter})
      : super(dataFilter: newDataFilter, filter: newFilter);
  final List<Reference> newDataFilter;
  final String newFilter;

  @override
  List<Object> get props => [newDataFilter, newFilter];
}
