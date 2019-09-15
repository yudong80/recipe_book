import 'package:flutter/material.dart';
import '../../widgets/ui_elements/elements.dart';

import '../../widgets/ui_elements/comment_bar.dart';

class RecipeShow extends StatelessWidget {
  final _commentContentController = TextEditingController();
  String recipeId;

  RecipeShow(this.recipeId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$recipeId 레시피 '),
      ),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: _recipeDetail(),
        ),
        CommentBar(() {}, _commentContentController),
      ],
    ),
    );
  }

  Widget _recipeDetail() {
    return Container(
        color: Colors.black12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.network(
                "https://assets3.thrillist.com/v1/image/2797371/size/tmg-article_default_mobile.jpg",
                fit: BoxFit.fitWidth,
              ),
            ),
            Panel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'this is title Area',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
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
}
