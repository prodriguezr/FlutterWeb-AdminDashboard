import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';

import 'package:admin_dashboard/providers/providers.dart';

import 'package:admin_dashboard/ui/views/no_page_found_view.dart';

class NotFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('/404');

    return NoPageFoundView();
  });
}
