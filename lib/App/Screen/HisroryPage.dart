import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratailapp/Widget/AppEevatedButton.dart';
import 'package:ratailapp/Widget/AppTextField.dart';

class TransferDaimondScreen extends StatefulWidget {
  const TransferDaimondScreen({Key? key}) : super(key: key);

  @override
  State<TransferDaimondScreen> createState() => _TransferDaimondScreenState();
}

class _TransferDaimondScreenState extends State<TransferDaimondScreen> {
  final TextEditingController AmountETController = TextEditingController();
  // final TextEditingController AmountETController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child:Column(
            children: [
              Card(
                elevation: 5,
                child: Container
                  (
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Column(
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [

                          AppTextFieldWidget(
                            controller: AmountETController,

                            obscureText: true,
                            validator: (value) {
                              if ((value?.isEmpty ?? true) &&
                                  ((value?.length ?? 0) < 6)) {
                                return 'Enter password more than 6';
                              }
                              return null;
                            },
                            onChanged: (value){
                              //email=value!;

                            }, hintText: 'Type',
                          ),
                          SizedBox(height: 5,),


                          AppTextFieldWidget(
                            controller: AmountETController,
                            hintText: "",
                            obscureText: true,
                            validator: (value) {
                              if ((value?.isEmpty ?? true) &&
                                  ((value?.length ?? 0) < 6)) {
                                return 'Enter password more than 6';
                              }
                              return null;
                            },
                            onChanged: (value){
                              //email=value!;

                            },
                          ),
                          SizedBox(height: 5,),
                          AppTextFieldWidget(
                            controller: AmountETController,
                            hintText: "",
                            obscureText: true,
                            validator: (value) {
                              if ((value?.isEmpty ?? true) &&
                                  ((value?.length ?? 0) < 6)) {
                                return 'Enter password more than 6';
                              }
                              return null;
                            },
                            onChanged: (value){
                              //email=value!;

                            },
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 25,
                                width: 80,
                                child: AppElevatedButton(
                                  Color: Colors.green,
                                  onTap: () {
                                    //   Navigator.of(context).pop();
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) =>  LogInScreen()));
                                  },
                                  child: Center(
                                    child: Text(
                                      "Reset",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          //fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),









                        ],
                      ),
                    )),
              ),
              Card(
                elevation: 5,
                child: Container
                  (
                    height: 800,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Column(
                        crossAxisAlignment:  CrossAxisAlignment.start,
                        children: [
                          Text("INDEX"),


                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(

                              children: [
                                Container(
                                    color: Colors.white,
                                    // padding: EdgeInsets.all(20.0),
                                    width: MediaQuery.of(context).size.width,
                                    child: DataTable(
                                      columnSpacing:.2,
                                      columns: [
                                        DataColumn(
                                          label: Text('Type'),
                                        ),
                                        DataColumn(
                                          label: Text('Reference'),
                                        ),
                                        DataColumn(
                                          label: Text('Before Balance'),
                                        ),
                                        DataColumn(
                                          label: Text('After Balance'),
                                        ),
                                        DataColumn(
                                          label: Text('Action'),
                                        ),
                                        // DataColumn(
                                        //   label: Text('Amount'),
                                        // ),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('564.00')),
                                          DataCell(Text('PAID',style: TextStyle(color: Colors.green),)),
                                          DataCell(Text('01-06-2024')),
                                          DataCell(Text('Show',style: TextStyle(color: Colors.amber),),onTap: (){},),
                                          // DataCell(Text('265\$')),
                                        ]),



                                        DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('564.00')),
                                          DataCell(Text('PAID',style: TextStyle(color: Colors.green),)),
                                          DataCell(Text('01-06-2024')),
                                          DataCell(Text('Show',style: TextStyle(color: Colors.amber),),onTap: (){},),
                                          //DataCell(Text('\$265')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('564.00')),
                                          DataCell(Text('PAID',style: TextStyle(color: Colors.green),)),
                                          DataCell(Text('01-06-2024')),
                                          DataCell(Text('Show',style: TextStyle(color: Colors.amber),),onTap: (){},),
                                          //DataCell(Text('\$265')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('564.00')),
                                          DataCell(Text('PAID',style: TextStyle(color: Colors.green),)),
                                          DataCell(Text('01-06-2024')),
                                          DataCell(Text('Show',style: TextStyle(color: Colors.amber),),onTap: (){},),
                                          // DataCell(Text('\$265')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('564.00')),
                                          DataCell(Text('PAID',style: TextStyle(color: Colors.green),)),
                                          DataCell(Text('01-06-2024')),
                                          DataCell(Text('Show',style: TextStyle(color: Colors.amber),),onTap: (){},),
                                          // DataCell(Text('\$265')),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('1')),
                                          DataCell(Text('564.00')),
                                          DataCell(Text('PAID',style: TextStyle(color: Colors.green),)),
                                          DataCell(Text('01-06-2024')),
                                          DataCell(Text('Show',style: TextStyle(color: Colors.amber),),onTap: (){},),
                                          // DataCell(Text('\$265')),
                                        ]),
                                      ],



                                    )
                                ),
                              ],
                            ),
                          )







                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
