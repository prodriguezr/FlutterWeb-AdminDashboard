import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activeUser = Provider.of<AuthProvider>(context).user!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Dashboard View', style: CustomLabels.h1),
          SizedBox(height: 10),
          WhiteCard(
              title: activeUser.nombre, child: Text('${activeUser.correo}'))
        ],
      ),
    );
  }
}
