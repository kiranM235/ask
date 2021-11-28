import 'package:ask/src/bloc/detail/detail_bloc.dart';
import 'package:ask/src/models/item_model.dart';
import 'package:ask/src/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class Comment extends StatelessWidget {
  final Map<int, Future<ItemModel>> items;
  final int id;
  final DetailBloc bloc;
  final int depth;

  const Comment(
      {Key? key, required this.items, required this.id, required this.bloc, required this.depth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items[id] == null) {
      bloc.add(FetchItemDetailEvent(id));
    }
    return FutureBuilder(
      future: items[id],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingContainer();
        }
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        print("Snapshot has data ${snapshot.hasData}");
        final model = snapshot.data;
        return _buildNestedComments(model);
      },
    );
  }

  Widget _buildNestedComments(ItemModel? model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          // title: Text(model!.text ?? ""),
          title: Html(data: model!.text ?? ""),
        ),
        Divider(thickness: 2,),
        if(model.kids != null && model.kids!.isNotEmpty)
          ListView.builder(
            itemCount: model.kids!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Comment(
                bloc: bloc,
                items: items,
                id: model.kids![index],
                depth: depth + 1,
              );
            },
          ),

      ],
    );
  }
}
