part of 'filter_data_bloc.dart';

abstract class FilterDataEvent extends Equatable {
  const FilterDataEvent(this.filter);
  final String filter;

  @override
  List<Object> get props => [filter];
}

class EventFilterBy extends FilterDataEvent {
  const EventFilterBy(super.filter);
}
