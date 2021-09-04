import 'package:admin_dashboard/models/models.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/services.dart';
import 'package:admin_dashboard/ui/modals/modals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesDTS extends DataTableSource {
  final List<Category> categories;
  final BuildContext context;

  CategoriesDTS({
    required this.categories,
    required this.context,
  });

  @override
  DataRow getRow(int index) {
    final category = this.categories[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(category.id)),
      DataCell(Text(category.nombre)),
      DataCell(Text(category.usuario.nombre)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => CategoryModal(
                    category: category,
                  ),
                );
              },
              icon: Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text('Dashboard - Confirm'),
                  content: Text(
                      'Do you want to permanently delete the category "${category.nombre}"?'),
                  actions: [
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Yes, delete'),
                      onPressed: () async {
                        try {
                          await Provider.of<CategoriesProvider>(context,
                                  listen: false)
                              .deleteCategory(category.id);
                          Navigator.of(context).pop();

                          NotificationsService.showSnackbar(
                              'Category deleted sucessfully');
                        } catch (err) {
                          Navigator.of(context).pop();

                          NotificationsService.showSnackbarError(
                              'Could not delete category');
                        }
                      },
                    ),
                  ],
                );

                showDialog(context: context, builder: (_) => dialog);
              },
              icon: Icon(Icons.delete_outlined,
                  color: Colors.red.withOpacity(0.5))),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
