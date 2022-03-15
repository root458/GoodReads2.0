part of training_utils;

class TrainingRouter {
  static const String decisionRoute = '/';
  static const String listingRoute = '/listing';
  static const String formRoute = '/form';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final _args = settings.arguments;

    switch (settings.name) {
      case decisionRoute:
        return _route(
          const DecisionPage(),
        );
      case listingRoute:
        return _route(
          const ItemListingPage(),
        );
      case formRoute:
        return _route(
          const FormPage(),
        );
      default:
        return _route(
          Scaffold(
            appBar: AppBar(
              title: const Text('Training'),
            ),
            body: const Center(
              child: Text('Unknown page'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _route(Widget page, {bool fullscreen = false}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
      fullscreenDialog: fullscreen,
    );
  }
}
