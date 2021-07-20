import 'package:clean_arc_proj/feature/presentation/widgets/persons_list_widget.dart';
import 'package:flutter/material.dart';

class MyhomePage extends StatelessWidget {
  const MyhomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
          )
        ],
      ),
      body: PersonsList(),
    );
  }
}
