import 'package:go_router/go_router.dart';

import '../../src/home/presentation/home_page.dart';
import '../../src/product_detail/presentation/product_detail_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) => ProductDetailPage(
        id: state.params['id'] as String,
      ),
    ),
  ],
);
