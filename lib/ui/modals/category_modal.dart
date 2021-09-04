import 'package:admin_dashboard/models/models.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/buttons/buttons.dart';
import 'package:admin_dashboard/ui/inputs/inputs.dart';
import 'package:admin_dashboard/ui/labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryModal extends StatefulWidget {
  final Category? category;

  const CategoryModal({Key? key, this.category}) : super(key: key);

  @override
  _CategoryModalState createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String name = '';
  String? id;

  @override
  void initState() {
    super.initState();

    id = widget.category?.id;
    name = widget.category?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoriesProvider>(context, listen: false);

    return Container(
        padding: EdgeInsets.all(30),
        height: 500,
        width: 300,
        decoration: buildBoxDecorarion(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.category?.nombre ?? 'New Category',
                  style: CustomLabels.h1.copyWith(color: Colors.white),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close_outlined,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Divider(color: Colors.white.withOpacity(0.3)),
            SizedBox(height: 20),
            TextFormField(
              initialValue: widget.category?.nombre ?? '',
              onChanged: (value) => name = value,
              decoration: CustomInputs.loginInputDecoration(
                  hint: 'Name of the category',
                  label: 'Name',
                  icon: Icons.new_releases_outlined),
              style: TextStyle(color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: CustomOutlinedButton(
                onPressed: () async {
                  if (id == null) {
                    // Create
                    try {
                      await categoryProvider.createCategory(name);

                      Navigator.of(context).pop();

                      NotificationsService.showSnackbar(
                          'Category created sucessfully');
                    } catch (e) {
                      NotificationsService.showSnackbarError(
                          'Category could not be created');
                    }
                  } else {
                    // Update
                    try {
                      await categoryProvider.updateCategory(id!, name);
                      NotificationsService.showSnackbar(
                          'Category updated sucessfully');
                    } catch (e) {
                      NotificationsService.showSnackbarError(
                          'Category could not be updated');
                    }
                  }
                  Navigator.of(context).pop();
                },
                text: 'Save',
                color: Colors.white,
              ),
            ),
          ],
        ));
  }

  BoxDecoration buildBoxDecorarion() => BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Color(0xFF0F2041),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
          )
        ],
      );
}
