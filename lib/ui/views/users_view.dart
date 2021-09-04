import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';

class UsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Users', style: CustomLabels.h1),
          SizedBox(height: 10),
          WhiteCard(title: 'Users View', child: Text('Hola Mundo!!'))
        ],
      ),
    );
  }
}
