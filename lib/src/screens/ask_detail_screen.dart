import 'package:ask/src/bloc/detail/detail_bloc.dart';
import 'package:ask/src/models/item_model.dart';
import 'package:ask/src/repo/repository.dart';
import 'package:ask/src/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AskDetailScreen extends StatelessWidget {
  final ItemModel item;

  const AskDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<Repository>(context);

    return BlocProvider<DetailBloc>(
      create: (context) => DetailBloc(repository),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ask Show Job Stories Detail"),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Builder(builder: (context) {
      final bloc = BlocProvider.of<DetailBloc>(context);
      bloc.add(FetchItemDetailEvent(item.id!));
      return BlocConsumer<DetailBloc, DetailState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print("State ${state is DetailInitial}");
          if(state is DetailInitial) {
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is DetailLoading) {
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is DetailError) {
            return Center(child: Text(state.message),);
          }
          DetailData detailData = state as DetailData;
          return _buildComments(context, detailData, bloc);
        },
      );
    });
  }

  Widget _buildComments(BuildContext context, DetailData detailData, DetailBloc bloc) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: Text(
              item.title!,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
          ),
          if(item.kids != null && item.kids!.isNotEmpty)
            Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Comment(
                    items: detailData.data,
                    id: item.kids![index],
                    bloc: bloc,
                    depth: 1,
                  );
                },
                itemCount: item.kids?.length,
              ),
            ),

        ],
      ),
    );
  }
}
