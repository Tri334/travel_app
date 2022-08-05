import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/bloc/bloc_filter_data/filter_data_bloc.dart';
import 'package:travel_app/bloc/bloc_get_data/fetch_data_bloc.dart';
import 'package:travel_app/bloc/bloc_get_favorite/favorite_get_bloc.dart';
import 'package:travel_app/screens/login_page.dart';
import 'package:travel_app/firebase/firebase_options.dart';
import 'package:travel_app/screens/explore/explore_page.dart';
import 'package:travel_app/screens/home/home_page.dart';
import 'package:travel_app/screens/landing_page.dart';
import 'package:travel_app/screens/profile.dart';
import 'package:travel_app/screens/selector_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<FetchDataBloc>(
                  create: (context) => FetchDataBloc()..add(EventDataInitial()),
                ),
                BlocProvider<FilterDataBloc>(
                  create: (context) => FilterDataBloc(),
                ),
                BlocProvider<FavoriteGetBloc>(
                  create: (context) =>
                      FavoriteGetBloc()..add(EventGetFavorite()),
                ),
              ],
              child: MaterialApp(
                initialRoute: HomeSelector.routeName,
                routes: {
                  LandingPage.routeName: (context) => const LandingPage(),
                  LoginPage.routeName: (context) => const LoginPage(),
                  PageSelector.routeName: (context) => PageSelector(),
                  HomePage.routeName: (context) => const HomePage(),
                  ExplorePage.routeName: (context) => ExplorePage(),
                  ProfilePage.routeName: (context) => const ProfilePage(),
                  HomeSelector.routeName: (context) => const HomeSelector(),
                },
              ),
            );
          });
    });
  }
}

class HomeSelector extends StatelessWidget {
  const HomeSelector({Key? key}) : super(key: key);
  static String routeName = '/homeselector';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageSelector();
          } else {
            return const LandingPage();
          }
        },
      ),
    );
  }
}
