import 'package:admin_dashboard/api/api.dart';
import 'package:admin_dashboard/models/http/http.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/services.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    this.isAuthenticated();
  }

  login({required String email, required String password}) {
    final data = {
      'correo': email,
      'password': password,
    };

    CafeApi.httpPost('/auth/login', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);

      this.user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);

      NavigationService.replaceTo(CustomFluroRouter.dashboardRoute);

      CafeApi.configureDio();

      notifyListeners();
    }).catchError((err) {
      print('Error in: $err');
      NotificationsService.showSnackbarError('Invalid credentials');
    });
  }

  register(
      {required String name, required String email, required String password}) {
    final data = {'nombre': name, 'correo': email, 'password': password};

    CafeApi.httpPost('/usuarios', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);

      this.user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);

      NavigationService.replaceTo(CustomFluroRouter.dashboardRoute);

      CafeApi.configureDio();

      notifyListeners();
    }).catchError((err) {
      print('Error in: $err');
      NotificationsService.showSnackbarError('Invalid credentials');
    });
  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final response = await CafeApi.httpGet('/auth');

      final authResponse = AuthResponse.fromMap(response);

      this.user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;

      LocalStorage.prefs.setString('token', authResponse.token);

      CafeApi.configureDio();

      notifyListeners();

      return true;
    } catch (err) {
      print(err);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }
}
