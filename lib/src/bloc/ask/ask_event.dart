

import 'package:equatable/equatable.dart';

abstract class AskEvent extends Equatable {
  const AskEvent();
}

class FetchTopIdsEvent extends AskEvent {
  @override
  List<Object?> get props => [];

  @override
  NewsEvent() {
    // TODO: implement NewsEvent
    throw UnimplementedError();
  }

}

class RefreshEvent extends AskEvent {
  @override
  List<Object?> get props => [];

  @override
  NewsEvent() {
    // TODO: implement NewsEvent
    throw UnimplementedError();
  }

}


