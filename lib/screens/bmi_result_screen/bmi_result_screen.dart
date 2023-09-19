import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/screens/history_screen/history_screen.dart';
import 'package:news/shared/component/shared%20component.dart';
import 'widget_bmi_result.dart';

class BmiResult extends StatelessWidget {
  const BmiResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BmiCubit,BmiStates>(
      listener: (context, state) { },
      builder:(context, state) {
        BmiCubit resultCubit=BmiCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title:const Text(
            'BMI Result',
          ),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(
                    builder:(context) => const HistoryScreen(),),
                );
              },
              icon:const Icon(
                  Icons.save,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10),),
                      border: Border.all()
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textListViewItem(
                              text: resultCubit.genderIsMale?'Gender : Male':'Gender : Female',
                              size: 18,
                            ),
                            textListViewItem(
                              text: 'Age : ${resultCubit.age}',
                              size: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textListViewItem(
                              text: 'Height : ${resultCubit.height.round()}',
                              size: 18,
                            ),
                            textListViewItem(
                              text: 'Weight : ${resultCubit.weight}',
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
                textListViewItem(
                  text: 'BMI : ${resultCubit.bmiCalculate(resultCubit.height, resultCubit.weight).toStringAsFixed(2)}',
                  size: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
                const SizedBox(height: 30,),
                bmiTextResult(
                    bmiRes: resultCubit.bmiCalculate(resultCubit.height, resultCubit.weight),
                    height: resultCubit.height,
                ),
                const SizedBox(height: 90,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius:const BorderRadius.all(Radius.circular(10),),
                      onTap: (){
                        resultCubit.titleController=TextEditingController();
                        dialog(
                          text: 'Add title :',
                          titleController: resultCubit.titleController,
                          context: context,
                          onTapOk: (){
                            resultCubit.insert(
                              titleInsert: resultCubit.titleController.text,
                              dateInsert: DateFormat.yMMMd().format(DateTime.now()),
                              heightInsert: resultCubit.height.round(),
                              resultInsert: resultCubit.bmiCalculate(resultCubit.height, resultCubit.weight).toStringAsFixed(2),
                              weightInsert: resultCubit.weight,
                            );
                            Navigator.pop(context);
                          },
                          onTapCencel: (){
                            Navigator.pop(context);
                          },
                        );

                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius:const BorderRadius.all(Radius.circular(10),),
                          border: Border.all()
                        ),
                        child: textListViewItem(
                          text: 'Save',
                          size: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(10),),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10),),
                            border: Border.all()
                        ),
                        child: textListViewItem(
                          text: 'Again',
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      },
    );
  }
}
