import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  //TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

body:  Padding(
  padding:  EdgeInsets.all(30.0),
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
              Text("INDEX"),
              ListTile(
                leading: Text("search"),
                title: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  //controller: _searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.black45,
                    hintText: 'Search...',
                    // suffixIcon: IconButton(
                    //   icon: Icon(Icons.clear),
                    //   onPressed: () {
                    //    // _searchController.clear();
                    //     setState(() {});
                    //   },
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),

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
                              label: Text('ID'),
                            ),
                            DataColumn(
                              label: Text('Amount'),
                            ),
                            DataColumn(
                              label: Text('Stutas'),
                            ),
                            DataColumn(
                              label: Text('Created Time'),
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
),

    );
  }
}
