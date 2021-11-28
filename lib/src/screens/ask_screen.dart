import 'package:ask/src/bloc/ask/ask_bloc.dart';
import 'package:ask/src/bloc/ask/ask_event.dart';
import 'package:ask/src/bloc/ask/ask_state.dart';
import 'package:ask/src/repo/repository.dart';
import 'package:ask/src/widgets/ask_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AskScreen extends StatelessWidget {
  const AskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<Repository>(context);
    return BlocProvider<AskBloc>(
      create: (context) => AskBloc(repository),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Trending Ask"),
            centerTitle: true,
          ),
          body: buildasklist(),
        ),
      ),
    );
  }

  Builder buildasklist() {
    return Builder(builder: (context) {
      /// add event to the bloc
      final askBloc = BlocProvider.of<AskBloc>(context);
      askBloc.add(FetchTopIdsEvent());
      return BlocBuilder<AskBloc, AskState>(
        builder: (context, state) {
          if (state is AskInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AskLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AskError) {
            return Center(
              child: Text(state.message),
            );
          }
          AskData data = state as AskData;
          final ids = data.ids;
          return _buildAskContent(ids, askBloc);
        },
      );
    });
  }

  Container _buildAskContent(List<int> ids, AskBloc askBloc) {
    print("Total ask items ${ids.length}");
    return Container(
      padding: EdgeInsets.all(8),
      child: RefreshIndicator(
        onRefresh: () async {
          // Todo clear local database
          /// fetch top ids
          askBloc.add(RefreshEvent());
          askBloc.add(FetchTopIdsEvent());

        },
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print("Current index ${ids[index]}");

            final item = askBloc.getItemById(ids[index]);

            return AskItem(item: item, id: ids[index]);
          },
          itemCount: ids.length,
        ),
      ),
    );
  }
}
