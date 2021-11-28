part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {}

class DetailInitial extends DetailState {
  @override
  List<Object?> get props => [];
}

class DetailLoading extends DetailState {
  @override
  List<Object?> get props => [];
}

class DetailError extends DetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailData extends DetailState {
  final Map<int, Future<ItemModel>> data;

  DetailData(this.data);

  DetailData copy(Map<int, Future<ItemModel>>? data) {
    return DetailData(data ?? this.data);
  }
  @override
  List<Object?> get props => [data];
}




