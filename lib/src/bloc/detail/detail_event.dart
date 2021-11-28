part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {}

class FetchItemDetailEvent extends DetailEvent {
  final int id;
  FetchItemDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}