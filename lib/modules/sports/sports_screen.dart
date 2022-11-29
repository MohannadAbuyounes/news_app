
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit_news_app.dart';
import 'package:news_app/shared/component/components.dart';
import '../../../layout/news_app/cubit/states_news_app.dart';


class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){},
      builder: (context,state){
         var list = NewsCubit.get(context).sports;

        return articleBuilder(list, context);
      },
    );
  }
}