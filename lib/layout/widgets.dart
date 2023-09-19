import 'package:flutter/material.dart';

Widget customGender ({
  bool chose=true,
  required void Function() onTap,
  required IconData icon,
  required Color iconColor,
  required String text,
}){
  return InkWell(
    borderRadius:const BorderRadius.all(Radius.circular(15),),
    onTap: onTap,
    child: Container(
      decoration: chose?BoxDecoration(
        borderRadius:const BorderRadius.all(
          Radius.circular(15),
        ),
        border:Border.all(
          style: BorderStyle.solid,
          color: Colors.black,
          width:3,
        ),
      ):
      BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border:Border.all(
          style: BorderStyle.solid,
          color: Colors.black12,
          width:1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Icon(
            icon,
            color: iconColor,
            size: 100,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    ),
  );
}


Widget customAgeWeight ({
  required void Function() addTap,
  required void Function() minsTap,
  required String text,
  required int number,
}){
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      border:Border.all(
          style: BorderStyle.solid,
          color: Colors.black12,
          width:1,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      Text(
      text,
      style: const TextStyle(
        fontSize: 22,
      ),
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(5),),
              onTap: minsTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  border:Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black12,
                    width:1,
                  ),
                ),
                child:const Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
            Text(
              '${number}',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(5),),
              onTap: addTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  border:Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black12,
                    width:1,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
