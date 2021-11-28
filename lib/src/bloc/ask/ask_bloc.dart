import 'dart:async';
import 'package:ask/src/bloc/ask/ask_event.dart';
import 'package:ask/src/bloc/ask/ask_state.dart';
import 'package:ask/src/models/item_model.dart';
import 'package:ask/src/repo/repository.dart';
import 'package:bloc/bloc.dart';

class AskBloc extends Bloc<AskEvent, AskState> {
  final Repository repository;
  AskBloc(this.repository) : super(AskInitial());
  // final NewsApiProvider apiProvider = NewsApiProvider();
  // final NewsDbProvider dbProvider = NewsDbProvider();
  // late Repository repository = Repository(dbProvider, apiProvider);

  @override
  Stream<AskState> mapEventToState(AskEvent event) async* {
    if (event is FetchTopIdsEvent) {
      yield AskLoading();
      try {
        final ids = await repository.fetchTopIds();
        yield AskData(ids);
      } catch (e) {
        // yield AskError("$e");
        yield AskError("Failed to connect to server... please try again");
      }
    }else if (event is RefreshEvent) {
      await repository.clearDatabase();
    }
  }
  Future<ItemModel> getItemById(int id){
    return repository.fetchItem(id);
  }

  Future clearDatabase() {
    return repository.clearDatabase();
  }
}

