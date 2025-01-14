import 'package:flutter/material.dart';
import 'package:recipe_book/src/resources/comment_fire_resource.dart';
import '../../widgets/ui_elements/elements.dart';

import '../../widgets/ui_elements/comment_bar.dart';
import '../../resources/recipe_fire_resource.dart';

class RecipeShow extends StatefulWidget {
  String recipeId;

  RecipeShow(this.recipeId);

  @override
  _RecipeShowState createState() => _RecipeShowState();
}

class _RecipeShowState extends State<RecipeShow> {
  RecipeFireResource resource = RecipeFireResource();
  CommentFireResource commentResource = CommentFireResource();
  final _commentContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: resource.getItemOne(widget.recipeId),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('${snapshot.data['title']}'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.favorite_border),
              backgroundColor: Colors.blue,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: _buildCustomList(context, snapshot),
                ),
                CommentBar(() {
                  _commentWrite(context);
                }, _commentContentController),
              ],
            ),
          );
        });
  }

  Widget _buildCustomList(context, snapshot) {
    final children = <Widget>[];
    children.add(_recipeDetail(snapshot));

    return StreamBuilder<QuerySnapshot>(
        stream: commentResource.getComments(widget.recipeId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<ListTile> commentList =
              snap.data.documents.map((DocumentSnapshot document) {
            return ListTile(
              title: Text('${document['content']}'),
            );
          }).toList();
          children.addAll(commentList);
          return ListView(children: children);
        });
  }

  Widget _recipeDetail(snapshot) {
    return Container(
      color: Colors.black12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 11,
            child: Image.network(
              snapshot.data['image'],
              fit: BoxFit.fitWidth,
            ),
          ),
          Panel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data['title'],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Text(
                  'sub title',
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Panel(
              child: Text(
            'sub title',
            textAlign: TextAlign.start,
          )),
        ],
      ),
    );
  }

  void _commentWrite(context) async {
    CommentModel comment = CommentModel.fromJson(
        {"target": widget.recipeId, 'content': _commentContentController.text});
    DocumentReference docref = await commentResource.createComment(comment);
    resource.attachComment(widget.recipeId, docref.documentID);

    _commentContentController.text = '';
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
