import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/News_layout.dart';
import 'package:news_app/layout/news_app/cubit/cubit_news_app.dart';
import 'package:news_app/layout/news_app/cubit/states_news_app.dart';

import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';


void main() async {
  // for be sure to done all of things in method and run the app
  WidgetsFlutterBinding.ensureInitialized();
    // options: DefaultFirebaseOptions.currentPlatform,

  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  // bool? onBoarding  = CacheHelper.getData(key: 'onBoarding');

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark: isDark!,
        // onBoarding: onBoarding!,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  // final bool onBoarding;

  MyApp(
      {
         required this.isDark,
        // required this.onBoarding,
      });

  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),

      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
    throw UnimplementedError();
  }
}
