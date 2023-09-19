import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/states.dart';
import 'package:news/layout/home_page.dart';

import 'cubit/cubit.dart';

void main() async {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiCubit()..createData(),
      child: BlocConsumer<BmiCubit,BmiStates>(
        listener: (context, state) { },
        builder: (context, state) =>MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: HomePage(),
        ),
      ),
    ) ;

  }
}