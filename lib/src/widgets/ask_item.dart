import 'package:ask/src/models/item_model.dart';
import 'package:ask/src/screens/ask_detail_screen.dart';
import 'package:ask/src/widgets/loading_container.dart';
import 'package:flutter/material.dart';

class AskItem extends StatelessWidget {
  final Future<ItemModel> item;
  final int id;

  const AskItem({Key? key, required this.item, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: item,
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return LoadingContainer();
        }
        final model = snapshot.data;
        print("Is the model null $id");
        return ListTile(
          title:  Text(model!.title!),
          subtitle: Text("${model.score!} votes"),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text("${model.descendants ?? 0 }"),
            ],
          ),
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return AskDetailScreen(item: model);
                },
              ),
            );
          },
        );
      },
    );
  }
}
