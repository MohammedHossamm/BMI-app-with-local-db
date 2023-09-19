import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/screens/history_screen/history_widget.dart';
import 'package:news/shared/const.dart';

import '../../shared/component/shared component.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
        ),
      ),
      body: BlocConsumer<BmiCubit,BmiStates>(
        listener: (context, state) {},
        builder: (context, state) {
          BmiCubit dataCubit=BmiCubit.get(context);
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                var dataDb=dataCubit.dataList[index];
                return listViewItem(
                  title: dataDb[titleDb],
                  bmiResult: dataDb[bmiResultDb],
                  date:  dataDb[dateDb],
                  height:  dataDb[heightDb],
                  weight:  dataDb[weightDb],
                  onTapDelete:(){
                    showDialog(
                      context: context,
                      builder:(context) {
                        return AlertDialog(
                          content: Text(
                            'Are you sure to delete this note ?',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: (){
                                dataCubit.delete(dataDb['id']);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child:const Text(
                                'Cencel',
                                style: TextStyle(
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    } ,
                  onTapEdit: (){
                    dataCubit.titleController=TextEditingController(text:dataDb[titleDb] );
                    dialog(
                      text: 'Edit title :',
                      titleController: dataCubit.titleController,
                      context: context,
                      onTapOk: ()async{
                        await dataCubit.update(titleUpdate: dataCubit.titleController.text, id:dataDb['id'] );
                        Navigator.pop(context);
                      },
                      onTapCencel: (){
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                   height: 16,
                );
              },
              itemCount: dataCubit.dataList.length,
          ),
        );
        },
      ),
    );
  }
}

