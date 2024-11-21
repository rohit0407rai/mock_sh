
import 'package:go_router/go_router.dart';
import 'package:sih_finals/screens/auth_screen/pages/login_page.dart';



class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}
