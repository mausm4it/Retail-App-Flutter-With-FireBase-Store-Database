import 'package:flutter/material.dart';
import 'package:ratailapp/App/Screen/AddBalancePage.dart';
import 'package:ratailapp/App/Screen/TransferDaimodImo.dart';
import 'package:ratailapp/Widget/AppEevatedButton.dart';
import 'package:flutter/cupertino.dart';
class TransferScreen extends StatefulWidget {
    const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool m = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:  Padding(
        padding:  EdgeInsets.all(10.0),
        child:Card(
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
                    // ListTile(
                    //     leading: Text("INDEX") ,
                    //     title: Card(
                    //         color: Colors.tealAccent,
                    //         child:SizedBox(
                    //           height: 30,
                    //           width: 20,
                    //           child: AppElevatedButton(onTap: () {
                    //             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    //                 builder: (context) => const TransferDaimondImoScreen()), (route) => true);
                    //
                    //             },
                    //             child: Text("Create +"),),
                    //         )
                    //     )
                    // ),
                     Text("INDEX") ,

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
                                columns: const [
                                  DataColumn(
                                    label: Text('ID'),
                                  ),
                                  DataColumn(
                                    label: Text('To User'),
                                  ),
                                  DataColumn(
                                    label: Text('Daimond Amount'),
                                  ),
                                  DataColumn(
                                    label: Text('Daimond Amount'),
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
                                    DataCell(Text('Insanislam12@gmail.com')),
                                    DataCell(Text('232.0',style: TextStyle(color: Colors.green),)),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(Text('Show',style: TextStyle(color: Colors.amber),),onTap: (){},),
                                    // DataCell(Text('265\$')),
                                  ]),



                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('Insanislam12@gmail.com')),
                                    DataCell(Text('121.34',style: TextStyle(color: Colors.green),)),
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
      ),

    );
  }
}
