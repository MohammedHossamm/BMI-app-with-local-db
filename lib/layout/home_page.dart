import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/layout/widgets.dart';
import 'package:news/screens/bmi_result_screen/bmi_result_screen.dart';
import 'package:news/screens/history_screen/history_screen.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BmiCubit,BmiStates>(
      listener: (context, state) { },
      builder: (context, state) {
        var bmiCubit=BmiCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: const Text(
            'BMI Calculator',
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              Expanded(
                child:Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: customGender(
                            onTap: (){
                              bmiCubit.genderMale();
                            },
                            icon: Icons.male_rounded,
                            iconColor: Colors.deepOrange,
                            text: "Male",
                          chose: bmiCubit.genderIsMale,
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                        child: customGender(
                          onTap: (){
                            bmiCubit.genderFemale();
                          },
                          chose: !bmiCubit.genderIsMale,
                          icon: Icons.female_rounded,
                          text: 'Female',
                          iconColor: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:const BorderRadius.all(
                        Radius.circular(15),
                    ),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Text(
                        "Height",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        "${bmiCubit.height.round()}",
                        style: const TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      SfSlider(
                      showLabels:true,
                      showTicks: true,
                      minorTicksPerInterval: 5,
                      interval: 20,
                      value:bmiCubit.height,
                      min: 140,
                      max: 220,
                      activeColor: Colors.indigo,
                      onChanged:(value){
                        bmiCubit.changeHeight(value);
                      },
              ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),                    child: Row(
                    children: [
                      Expanded(
                        child: customAgeWeight(
                          text:'Weight',
                          addTap:(){
                            bmiCubit.add(isWeight: true);
                          },
                          minsTap: (){
                            bmiCubit.mins(isWeight: true);
                          },
                          number: bmiCubit.weight,
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                        child: customAgeWeight(
                          text:'Age ',
                          addTap:(){
                            bmiCubit.add(isWeight: false);
                          },
                          minsTap: (){
                            bmiCubit.mins(isWeight: false);
                          },
                          number: bmiCubit.age,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(10),),
                onTap: (){
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder:(context) => const BmiResult(),),
                  );
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:const Text(
                    'Calculate',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
      },
    );
  }
}