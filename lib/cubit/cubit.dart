import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/states.dart';
import 'package:news/shared/const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BmiCubit extends Cubit<BmiStates>{
  BmiCubit():super(BmiIntState());
  static BmiCubit get(context)=>BlocProvider.of(context);
  int height = 160;
  int weight = 60;
  int age = 25;
  bool genderIsMale = true;
  Database? bmiData;
  List<Map> dataList=[];
  TextEditingController titleController=TextEditingController();

  void genderMale(){
    genderIsMale=true;
    emit(BmiChangeGender());
  }
  void genderFemale(){
    genderIsMale=false;
    emit(BmiChangeGender());
  }
  void changeHeight(double value){
    height=value.round();
    emit(BmiChangeHeight());
  }
  void add({required bool isWeight}){
    if(isWeight==true){
      weight++;
      emit(BmiChangeWeight());
    }
    else{
      age++;
      emit(BmiChangeAge());
    }
  }
  void mins({required bool isWeight}){
    if(isWeight==true){
      weight--;
      emit(BmiChangeWeight());
    }
    else{
      age--;
      emit(BmiChangeAge());
    }
  }

  double bmiCalculate(int height,int weight){
    double result=weight/pow(height/100, 2);
    return result;
  }

  //create database
  Future<void> createData()  async {
    String dataPath=  await getDatabasesPath();
    String path= join(dataPath,'bmi_note.db');
    openDatabase(
      path,
      version: 1,
      onCreate:(db, version) async {
        await db.execute('''
        CREATE TABLE $dbTableName (
        $id INTEGER PRIMARY KEY,
        $titleDb TEXT,
        $dateDb TEXT,
        $weightDb INTEGER,
        $heightDb INTEGER,
        $bmiResultDb TEXT
        )''');
      },
      onOpen: (db)  {
        getDb(db).then((value){
          dataList=value;
        });
      },
    ).then((value) {
      bmiData=value;
      emit(BmiCreateDb());
    });
  }

  // insert data
  void insert({
    required String titleInsert,
    required int heightInsert,
    required int weightInsert,
    required String resultInsert,
    required String dateInsert,
  })async {
    int response =await bmiData!.rawInsert('''
    INSERT INTO $dbTableName ($titleDb,$heightDb,$weightDb,$bmiResultDb,$dateDb)
    VALUES("$titleInsert","$heightInsert","$weightInsert","$resultInsert","$dateInsert")
    ''');
    emit(BmiInsertDb());
    dataList= await getDb(bmiData);
    emit(BmiGetDb());
  }

  // delete data
  void delete(int id)async{
    int response =await bmiData!.rawDelete('''
    DELETE FROM $dbTableName WHERE id = $id
    ''');
    emit(BmiDeleteDb());
    dataList= await getDb(bmiData);
    emit(BmiGetDb());
  }

  // update data
  Future<int> update({
    required String titleUpdate,
    required int id,
  })async{
    int response =await bmiData!.rawUpdate(
        'UPDATE $dbTableName SET $titleDb = ? WHERE id = $id',
        [titleUpdate]
    );
    emit(BmiUpdateDb());
    dataList= await getDb(bmiData);
    emit(BmiGetDb());
    return response;
  }

  // show data
  Future<List<Map>> getDb(Database? data)async{
    List<Map> dataResponse = await data!.rawQuery(
        'SELECT * FROM $dbTableName'
    );
    return dataResponse;
  }
}
