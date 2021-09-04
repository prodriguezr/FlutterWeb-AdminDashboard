import 'package:admin_dashboard/api/api.dart';
import 'package:admin_dashboard/models/category.dart';
import 'package:admin_dashboard/models/http/http.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Category> categories = [];

  getCategories() async {
    final response = await CafeApi.httpGet('/categorias');
    final categoriesResponse = CategoriesResponse.fromMap(response);

    categories = [...categoriesResponse.categories];

    notifyListeners();
  }

  Future createCategory(String name) async {
    final data = {
      'nombre': name,
    };

    try {
      final json = await CafeApi.httpPost('/categorias', data);
      final category = Category.fromMap(json);

      categories.add(category);
    } catch (err) {
      throw ('Error creating new category');
    }

    notifyListeners();
  }

  Future updateCategory(String id, String name) async {
    final data = {
      'nombre': name,
    };

    try {
      final json = await CafeApi.httpPut('/categorias/$id', data);

      print(json);

      this.categories = categories.map((category) {
        if (category.id != id) return category;

        category.nombre = name;

        return category;
      }).toList();
    } catch (err) {
      throw ('Error updating category');
    }

    notifyListeners();
  }

  Future deleteCategory(String id) async {
    try {
      await CafeApi.httpDelete('/categorias/$id');

      categories.removeWhere((c) => c.id == id);
    } catch (err) {
      throw ('Error deleting category');
    }

    notifyListeners();
  }
}
