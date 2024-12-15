import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
     return SingleChildScrollView(
       child: SizedBox(
        height: MediaQuery.of(context).size.height*0.6,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(onPressed: (){},
                  child:Text('Find Restaurant')
              ),
            ),
          ],
        ),
           ),
     );}

  }


// show() {
//   var context;
//   showModalBottomSheet(context: context,
//       builder: (BuildContext context){
//         return Container(
//           height: MediaQuery.of(context).size.height*0.45,
//           width: double.infinity,
//           child: Center(child: Text('ban gayi')),
//         );});
// }

// yaha pr custom bnega