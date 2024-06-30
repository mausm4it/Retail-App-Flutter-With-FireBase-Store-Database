import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ratailapp/App/AdminPanel/RechargeAcceptPage.dart';
import 'package:ratailapp/App/AdminPanel/DepositAcceptPage.dart';
import 'package:ratailapp/App/AdminPanel/UserByRatePage.dart';
import 'package:ratailapp/App/Screen/AddBalancePage.dart';
import 'package:ratailapp/App/Screen/CreateTransferPage.dart';
import 'package:ratailapp/App/Screen/HisroryPage.dart';
import 'package:ratailapp/App/Screen/OrdersPage.dart';
import 'package:ratailapp/App/Screen/ProfilePage.dart';
import 'package:ratailapp/App/Screen/ReceiptPage.dart';
import 'package:ratailapp/App/Screen/RequestPage.dart';
import 'package:ratailapp/App/Screen/RequestWhiteListPage.dart';
import 'package:ratailapp/App/Screen/TransferScreen.dart';
import 'package:ratailapp/App/Screen/LogInPage.dart';
import 'package:ratailapp/Widget/AppEevatedButton.dart';
import 'package:ratailapp/Widget/AppTextField.dart';
import 'package:ratailapp/Widget/SnackBar.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen> {
  MySnackBar(message, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  MyAlertDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Expanded(
              child: AlertDialog(
            title: Text("Log Out"),
            content: Text("Are You sure you want to log out?"),
            actions: [
              Center(
                child: Column(
                  children: [
                    AppElevatedButton(
                      Color: Colors.yellow,
                      onTap: () {
                        // Navigator.of(context).pop();
                        //_signOut();
                        //Navigator.push(context, MaterialPageRoute(builder: (context) =>  LogInScreen()));
                      },
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              //fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       // MySnackBar("Thanks", context);
                    //       // Navigator.of(context).pop();
                    //     },
                    //     child: Text("No")),
                    SizedBox(height: 5),
                    AppElevatedButton(
                      onTap: () {
                        Navigator.of(context).pop();
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const MainBottomNavBar()));
                      },
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              //fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
        });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late Future<QuerySnapshot> _depositFuture;
  late Future<QuerySnapshot> _receiptFuture;

  @override
  void initState() {
    super.initState();
    _depositFuture = _getDepositDetails();
    _receiptFuture = _getReceiptDetails();
  }

  Future<QuerySnapshot> _getDepositDetails() async {
    try {
      return await _firestore
          .collection('DepositDetails')
          .where('Status', isEqualTo: 'paid')
          .get();
    } catch (e) {
      throw Exception('Error fetching deposit details: $e');
    }
  }

  Future<QuerySnapshot> _getReceiptDetails() async {
    try {
      return await _firestore
          .collection('ReceiptDetails')
          .where('Status', isEqualTo: 'Approve')
          .get();
    } catch (e) {
      throw Exception('Error fetching receipt details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: Future.wait([_depositFuture, _receiptFuture]),
              builder: (BuildContext context,
                  AsyncSnapshot<List<QuerySnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                double totalUserDiamond = 0;
                num todayDepositAmount = 0;
                double todayUserDiamond = 0;

                snapshot.data![0].docs.forEach((doc) {
                  double userDiamond =
                      double.tryParse(doc['User Diamond'] ?? '0') ?? 0;
                  totalUserDiamond += userDiamond;

                  DateTime now = DateTime.now();
                  DateTime startOfDay = DateTime(now.year, now.month, now.day);
                  DateTime endOfDay =
                      DateTime(now.year, now.month, now.day, 23, 59, 59);

                  Timestamp createdAt = doc['created_at'];
                  if (createdAt.toDate().isAfter(startOfDay) &&
                      createdAt.toDate().isBefore(endOfDay)) {
                    todayUserDiamond += userDiamond;
                  }
                });

                snapshot.data![0].docs.forEach((doc) {
                  int depositAmount = doc['Amount'] ?? '0';

                  DateTime now = DateTime.now();
                  DateTime startOfDay = DateTime(now.year, now.month, now.day);
                  DateTime endOfDay =
                      DateTime(now.year, now.month, now.day, 23, 59, 59);

                  Timestamp createdAt = doc['created_at'];
                  if (createdAt.toDate().isAfter(startOfDay) &&
                      createdAt.toDate().isBefore(endOfDay)) {
                    todayDepositAmount += depositAmount;
                  }
                });

                double totalTransferDiamond = 0;
                double todayTransferDiamond = 0;
                snapshot.data![1].docs.forEach((doc) {
                  double transferDiamond =
                      double.tryParse(doc['TransferDiamond'] ?? '0') ?? 0;
                  totalTransferDiamond += transferDiamond;

                  DateTime now = DateTime.now();
                  DateTime startOfDay = DateTime(now.year, now.month, now.day);
                  DateTime endOfDay =
                      DateTime(now.year, now.month, now.day, 23, 59, 59);

                  Timestamp createdAt = doc['created_at'];
                  if (createdAt.toDate().isAfter(startOfDay) &&
                      createdAt.toDate().isBefore(endOfDay)) {
                    todayTransferDiamond += transferDiamond;
                  }
                });

                int totalResult =
                    (totalUserDiamond - totalTransferDiamond).toInt();

                int todayResult =
                    (todayUserDiamond - todayTransferDiamond).toInt();

                return Column(
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // IconButton(onPressed: (){
                                //
                                //   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                //   //     builder: (context) => SettingScreen()), (route) => true);},
                                //   // icon: Icon(Icons.settings),
                                // ),
                                CircleAvatar(
                                  radius: 10,
                                  //   backgroundImage:AssetImage('assets/images/profile.png'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Today Diamond Availabe"),

                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "$todayResult",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Icon(Icons.ac_unit_outlined)
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 10,
                      child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // IconButton(onPressed: (){
                                //
                                //   // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                //   //     builder: (context) => SettingScreen()), (route) => true);},
                                //   // icon: Icon(Icons.settings),
                                // ),
                                CircleAvatar(
                                  radius: 10,
                                  //   backgroundImage:AssetImage('assets/images/profile.png'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Total Diamond Availabe"),

                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "$totalResult",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Icon(Icons.ac_unit_outlined)
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 40,
                          child: Card(
                            elevation: 10,
                            child: Container(
                                height: 80,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.teal[900],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    //     builder: (context) => TransferDaimondImoScreen()), (route) => true);
                                  },
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Today Deposit", //Diamond
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Text(
                                              "$todayDepositAmount",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Icon(
                                              Icons.ac_unit_outlined,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 40,
                          child: Card(
                            elevation: 10,
                            child: Container(
                                height: 80,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.teal[900],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    //     builder: (context) => TransferDaimondImoScreen()), (route) => true);
                                  },
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Text(
                                          "Total sales Diamond", //Total Diamond
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Text(
                                              "$totalTransferDiamond",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Card(
                            elevation: 10,
                            child: Container(
                                height: 80,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.teal[900],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    //     builder: (context) => TransferDaimondImoScreen()), (route) => true);
                                  },
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Text(
                                          "Total Deposit",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Text(
                                              "$todayDepositAmount",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Icon(
                                              Icons.ac_unit_outlined,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Card(
                            elevation: 10,
                            child: Container(
                                height: 80,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.teal[900],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    //     builder: (context) => TransferDaimondImoScreen()), (route) => true);
                                  },
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Text(
                                          "Total Diposit",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
      // floatingActionButtonLocation:FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 10,
      //   child: Icon(Icons.add,color:Colors.blue) ,
      //   backgroundColor: Colors.green,
      //
      //   onPressed: (){
      //     MySnackBar("I am floating action button",context);
      //   },
      //   foregroundColor:Colors.pink,
      //
      //   focusColor: Colors.brown,
      //
      //   // autoFocus: true,
      // ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text("Main Dachbord",
                      style: TextStyle(color: Colors.black))),

              //UserAccountsDrawerHeader(
              //   decoration: BoxDecoration(color: Colors.white),
              //   accountName: Text("Rabbil Hasan",style: TextStyle(color: Colors.black)),
              //   onDetailsPressed: (){MySnackBar("This is profile",context);},
              // )
            ),
            ListTile(
              title: Text("Navigation"),
            ),
            ListTile(
                leading: Icon(Icons.add_box_outlined),
                title: Text("User By Rate"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserByRateScreen()));
                }),
            ListTile(
                leading: Icon(Icons.add_box_outlined),
                title: Text("Recharge Accept"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RechargeAcceptScreen()));
                }),
            ListTile(
                leading: Icon(Icons.add_box_outlined),
                title: Text("Deposit Request Accept"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DepositAcceptScreen()));
                }),
            ListTile(
                leading: Icon(Icons.add_box_outlined),
                title: Text("Deposit History"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderScreen()));
                }),
            ListTile(
                leading: Icon(Icons.add_box_outlined),
                title: Text("Recharge History"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReceiptAcceptScreen()));
                }),
            ListTile(
                leading: Icon(Icons.work_history_rounded),
                title: Text("Transfer History"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TransferScreen()));
                }),
            ListTile(
                leading: Icon(Icons.dehaze_rounded),
                title: Text("Request Whitelist"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RequestWhiteListScreen()));
                }),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text("Setting"),
                onTap: () {
                  MyAlertDialog(context);
                }),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  MyAlertDialog(context);
                }),
          ],
        ),
      ),
    );
    ;
  }
}

class AdminDepositScreen extends StatefulWidget {
  const AdminDepositScreen({Key? key}) : super(key: key);

  @override
  State<AdminDepositScreen> createState() => _AdminDepositScreenState();
}

class _AdminDepositScreenState extends State<AdminDepositScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<DocumentSnapshot> _documentFuture;

  @override
  void initState() {
    super.initState();
    _documentFuture = _getDocument();
  }

  Future<DocumentSnapshot> _getDocument() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      print(user!.uid);
      return await _firestore
          .collection('ReceiptDetails')
          .doc("user?.uid")
          .get();
    } catch (e) {
      throw Exception('Error fetching document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
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
              padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Receipt List"),
                  Row(
                    children: [
                      Expanded(flex: 25, child: Text("Receipt Id")),
                      Expanded(flex: 25, child: Text(" Amount")),
                      Expanded(flex: 25, child: Text("Status")),
                      Expanded(flex: 25, child: Text("CreateTime")),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream:
                          _firestore.collection('ReceiptDetails').snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData) {
                          return Center(child: Text('No data found'));
                        }

                        final documents = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final document = documents[index];
                            var date = document['created_at'].toDate();
                            var formattedDate = DateFormat.yMMMd().format(date);

                            return Row(
                              children: [
                                Expanded(
                                    flex: 25,
                                    child: Text("${document['ReceiptId']}")),
                                Expanded(
                                    flex: 25,
                                    child: Text("${document['TransferA']}")),
                                Expanded(
                                    flex: 25,
                                    child: Text("${document['Status']}")),
                                Expanded(
                                    flex: 25,
                                    child: Text(
                                      "$formattedDate",
                                      //   "CreateTime"
                                    )),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         flex:25,
                  //         child: Text("Receipt Id")),
                  //     Expanded(
                  //         flex:25,
                  //         child: Text("${data['TransferA']}")),
                  //     Expanded(
                  //         flex:25,
                  //         child: Text("Pending")),
                  //     Expanded(
                  //         flex:25,
                  //         child: Text(
                  //             "${data['created_at'].toDate()}",
                  //          //   "CreateTime"
                  //         )),
                  //   ],
                  // ),
                ],
              ),
            )),
      ),
    ));
  }
}

class AdminReachargeScreen extends StatefulWidget {
  const AdminReachargeScreen({Key? key}) : super(key: key);

  @override
  State<AdminReachargeScreen> createState() => _AdminReachargeScreenState();
}

class _AdminReachargeScreenState extends State<AdminReachargeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          child: Container(
              //height: 800,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                columnSpacing: .2,
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
                                    DataCell(Text(
                                      '232.0',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    // DataCell(Text('265\$')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('Insanislam12@gmail.com')),
                                    DataCell(Text(
                                      '121.34',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    //DataCell(Text('\$265')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('564.00')),
                                    DataCell(Text(
                                      'PAID',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    //DataCell(Text('\$265')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('564.00')),
                                    DataCell(Text(
                                      'PAID',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    // DataCell(Text('\$265')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('564.00')),
                                    DataCell(Text(
                                      'PAID',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    // DataCell(Text('\$265')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('564.00')),
                                    DataCell(Text(
                                      'PAID',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    // DataCell(Text('\$265')),
                                  ]),
                                ],
                              )),
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

class AdminTransferScreen extends StatefulWidget {
  const AdminTransferScreen({Key? key}) : super(key: key);

  @override
  State<AdminTransferScreen> createState() => _AdminTransferScreenState();
}

class _AdminTransferScreenState extends State<AdminTransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          child: Container(
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
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                columnSpacing: .2,
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
                                    DataCell(Text('In@gmail.com')),
                                    DataCell(Text(
                                      '232.0',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    // DataCell(Text('265\$')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('In@gmail.com')),
                                    DataCell(Text(
                                      '121.34',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    //DataCell(Text('\$265')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('564.00')),
                                    DataCell(Text(
                                      'PAID',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    //DataCell(Text('\$265')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('564.00')),
                                    DataCell(Text(
                                      'PAID',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    // DataCell(Text('\$265')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('564.00')),
                                    DataCell(Text(
                                      'PAID',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    // DataCell(Text('\$265')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('564.00')),
                                    DataCell(Text(
                                      'PAID',
                                      style: TextStyle(color: Colors.green),
                                    )),
                                    DataCell(Text('01-06-2024')),
                                    DataCell(
                                      Text(
                                        'Show',
                                        style: TextStyle(color: Colors.amber),
                                      ),
                                      onTap: () {},
                                    ),
                                    // DataCell(Text('\$265')),
                                  ]),
                                ],
                              )),
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
