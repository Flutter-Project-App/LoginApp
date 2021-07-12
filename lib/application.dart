import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import './data/blocs/authentication/authentication_bloc.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/splash/view/splash_page.dart';
import 'themes.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '';

// class Application extends StatefulWidget {
//   static const ROUTE_NAME = 'Application';
//   @override
//   _ApplicationState createState() => _ApplicationState();
// }
//
// class _ApplicationState extends State<Application> {
//   static const TAG = 'Application';
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: light(context),
//       darkTheme: dark(context),
//     );
//   }
// }

class Application extends StatelessWidget {
  const Application(
      {Key? key,
      required this.authenticationRepository,
      required this.userRepository})
      : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil(
                    HomePage.route(), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(), (route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
