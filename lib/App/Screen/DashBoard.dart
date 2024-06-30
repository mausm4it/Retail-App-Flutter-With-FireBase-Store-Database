import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ratailapp/Widget/AppEevatedButton.dart';


import 'LoginPage.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child:   Padding(

          padding: const EdgeInsets.all(24.0),

          child:   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Center(

                  child: Container(

                    height: 120,

                    width: 200,

                    child:Text("image"),//SvgPicture.asset('assets/images/classroom-icon.svg',height: 100, width: 128,

                   //   fit: BoxFit.scaleDown,

                     // color: Color(0xFF333A51),

                   // ),

                  )

              ),



              const SizedBox(

                height: 100,

              ),

              AppElevatedButton(

                onTap: ()  {



                 // Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInSreen()));



                },

                child:  Center(

                  child: Text("GET STARED",

                    style: GoogleFonts.poppins(

                      textStyle: const TextStyle(

                        color: Color(0xFFFFFFFF),

                        fontSize: 14,

                        //fontWeight: FontWeight.w700,



                      ),

                    ),



                  ),

                ),

              ),

              SizedBox(

                height:14,

              ),





              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Text("Don't have an account?"),

                  TextButton(

                    onPressed: () {

                     // Navigator.push(context, MaterialPageRoute(builder: (context) =>Register_Page()));

                    },

                    child: const Text(

                      'Sign Up',

                      style: TextStyle(color: Colors.green),

                    ),

                  )

                ],

              ),





            ],



          ),

        ),
      ),




    );
  }
}
