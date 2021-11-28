import 'package:ask/src/models/item_model.dart';
import 'package:ask/src/repo/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final Repository repository;

  DetailBloc(this.repository) : super(DetailInitial());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    FetchItemDetailEvent fetchEvent = event as FetchItemDetailEvent;
    final item = repository.fetchItem(fetchEvent.id);
    Map<int, Future<ItemModel>> tempData = {};
    if(state is DetailData) {
      DetailData data = state as DetailData;
      tempData = Map.from(data.data);
    }
    tempData.addAll({fetchEvent.id: item});
    yield DetailData(tempData);
  }
}
