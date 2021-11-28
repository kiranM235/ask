

import 'package:equatable/equatable.dart';

abstract class AskState extends Equatable {
  const AskState();
}

class AskInitial extends AskState {
  @override
  List<Object> get props => [];
}

class AskLoading extends AskState {
  @override
  List<Object?> get props => [];
}

class AskError extends AskState {
  final String message;
  AskError(this.message);

  @override
  List<Object?> get props => [message];

}

class AskData extends AskState {
  final List<int> ids;
  AskData(this.ids);

  AskData copy(List<int>? ids) {
    return AskData(ids ?? this.ids);
  }

  @override
  List<Object?> get props => [ids];
}