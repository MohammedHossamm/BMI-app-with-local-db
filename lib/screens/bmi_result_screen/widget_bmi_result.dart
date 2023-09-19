import 'dart:math';

import 'package:flutter/material.dart';


Widget columText({
  required String result,
  required String keyWord,
  required int number,
  bool isNormal=false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Container(
          padding: const EdgeInsets.all(9),
          decoration:const BoxDecoration(
            color: Colors.deepOrange,
              borderRadius:  BorderRadius.all(Radius.circular(10),),
          ),
          child: Text(
            result,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20,),
      const Text(
        'Healthy BMI range: from 18.5 to 25',
        style: TextStyle(
          fontSize: 17,
        ),
      ),
      Text(
        isNormal?'Nice, your body is perfect':'You should $keyWord: $number kg',
        style:const TextStyle(
          fontSize: 17,
        ),
      ),
    ],
  );
}

Widget bmiTextResult({required double bmiRes,required int height}){
  double weight;
  if(bmiRes<16) {
    weight=(18.5 *pow(height/100, 2))-( bmiRes*pow(height/100, 2));
    return columText(number:weight.round() ,keyWord:"gain" ,result:"Severe thinness" );
  } else if (bmiRes >=16 && bmiRes<17) {
    weight=(18.5 *pow(height/100, 2))-( bmiRes*pow(height/100, 2));
    return columText(number:weight.round() ,keyWord:"gain" ,result:"Moderate Thinness" );
  } else if (bmiRes >=17 && bmiRes<18.5) {
    weight=(18.5 *pow(height/100, 2))-( bmiRes*pow(height/100, 2));
    return  columText(number:weight.round() ,keyWord:"gain" ,result:"Mild Thinness" );
  } else if (bmiRes >=18.5 && bmiRes<25) {
    return  columText(number:25 ,keyWord:"" ,result:"Normal",isNormal: true );
  } else if (bmiRes >=25 && bmiRes<30) {
    weight=( bmiRes*pow(height/100, 2))-(25.0 *pow(height/100, 2));
    return columText(number:weight.round() ,keyWord:"lose" ,result:"Overweight" );
  } else if (bmiRes >=30 && bmiRes<35) {
    weight=( bmiRes*pow(height/100, 2))-(25.0 *pow(height/100, 2));
    return columText(number:weight.round() ,keyWord:"lose" ,result:"Obese Class I" );
  } else if (bmiRes >=35 && bmiRes<40) {
    weight=( bmiRes*pow(height/100, 2))-(25.0 *pow(height/100, 2));
    return columText(number:weight.round() ,keyWord:"lose" ,result:"Obese Class II" );
  } else {
    weight=( bmiRes*pow(height/100, 2))-(25.0 *pow(height/100, 2));
    return columText(number:weight.round() ,keyWord:"lose" ,result:"Obese Class III" );
  }
}
