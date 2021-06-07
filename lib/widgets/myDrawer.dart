
import 'package:flutter/material.dart';
import 'package:mix_center/config.dart';
import 'package:mix_center/functions/move_to.dart';
import 'package:mix_center/screens/ordersScreen.dart';
import '../providers/auth_user.dart';
import '../screens/cartScreen.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    final auth =Provider.of<Auth>(context);
    return Container(
      child: Drawer(
        child: Directionality(
          textDirection: TextDirection.rtl,
           child: ListView(
             children: [
               UserAccountsDrawerHeader(
                   currentAccountPicture: CircleAvatar(
                          backgroundColor: Colors.white,
                         child: Icon(
                          Icons.person,
                         ),
                   ),   //
                   accountName: Text( auth.isAuth==false ?" أهلا بك في متجرنا يسعدنا تلبية طلباتك"
                       : " أهلا بك :   ${auth.userName}"  ),
                   accountEmail:userAuthed==null?
                     Text("")
                    :Text("رقم هاتفك : ${auth.userMobile} "),
               ),
               //الصفحة الرئيسية
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     InkWell(
                       onTap: () {
                         Navigator.of(context).pushReplacementNamed("home");
                         // Navigator.push(
                         //     context,
                         //     MaterialPageRoute(
                         //         builder: (context) => HomePage()));
                       },
                       child: ListTile(
                         title: Text(
                           "الصفحة الرئيسية",
                           style: TextStyle(
                             color: Colors.black,
                           ),
                         ),
                         trailing: Icon(
                           Icons.navigate_next,
                           color: Colors.black,
                           size: 20.0,
                         ),
                         leading: Icon(Icons.home,
                             color: Colors.purple
                         ),
                       ),
                     ),
                     Divider(
                       color: Colors.grey,
                     )
                   ],
                 ),
               ), //my  طلباتي


               //السلة
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     InkWell(
                       onTap: () {
                         Navigator.of(context).pushReplacementNamed(CartScreen.routeName);

                         // Navigator.push(
                         //     context,
                         //     MaterialPageRoute(
                         //         builder: (context) => CartScreen()));
                       },
                       child: ListTile(
                         title: Text(
                           "سلتي",
                           style: TextStyle(
                             color: Colors.black,
                           ),
                         ),
                         trailing: Icon(
                           Icons.navigate_next,
                           color: Colors.black,
                           size: 20.0,
                         ),
                         leading: Icon(Icons.shopping_cart,
                             color: Theme.of(context).primaryColor
                         ),
                       ),
                     ),
                     Divider(
                       color: Colors.grey,
                     )
                   ],
                 ),
               ),

               //my  طلباتي

               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     InkWell(
                       onTap: () {
                         //Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);

                        moveTO(context, OrderScreen());
                       },
                       child: ListTile(
                         title: Text(
                           "طلباتي",
                           style: TextStyle(
                             color: Colors.black,
                           ),
                         ),
                         trailing: Icon(
                           Icons.navigate_next,
                           color: Colors.black,
                           size: 20.0,
                         ),
                         leading: Icon(Icons.list_alt,
                             color: Theme.of(context).primaryColor
                         ),
                       ),
                     ),
                     Divider(
                       color: Colors.grey,
                     )
                   ],
                 ),
               ),

               //تسجيل الدخول او  الخروج
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: auth.isAuth==false
                   ?ListTile(
                   title: Text(
                     "تسجيل الدخول",
                     style: TextStyle(
                       color: Colors.black,
                     ),
                   ),
                   trailing: Icon(
                     Icons.navigate_next,
                     color: Colors.black,
                     size: 20.0,
                   ),
                   leading: Icon(Icons.exit_to_app,
                       color: Theme.of(context).primaryColor
                   ),
                   onTap: (){
                     Navigator.pushReplacementNamed(context, "login");
                   },
                 )
                   : ListTile(
                   title: Text(
                     "تسجيل خروج",
                     style: TextStyle(
                       color: Colors.black,
                     ),
                   ),
                   trailing: Icon(
                     Icons.navigate_next,
                     color: Colors.black,
                     size: 20.0,
                   ),
                   leading: Icon(Icons.exit_to_app,
                       color: Theme.of(context).primaryColor
                   ),
                   onTap: () async {
                     //Navigator.pushNamed(context, "login");

                     auth.logout();
                     Navigator.of(context).pushReplacementNamed("login") ;

                   },
                 ),
               ),
               Divider(
                 color: Colors.grey,
               ),

               // //my  account
               // ExpansionTile(
               //   title: Text(
               //     "حسابي",
               //     style: TextStyle(
               //       color: Colors.black,
               //     ),
               //   ),
               //   children: [
               //
               //     Padding(
               //       padding: const EdgeInsets.all(8.0),
               //       child: Column(
               //         children: [
               //           InkWell(
               //             onTap: () {
               //               Navigator.pushNamed(context, "login");
               //             },
               //             child: ListTile(
               //               title: Text(
               //                 "تسجيل الدخول",
               //                 style: TextStyle(
               //                   color: Colors.black,
               //                 ),
               //               ),
               //               trailing: Icon(
               //                 Icons.navigate_next,
               //                 color: Colors.black,
               //                 size: 20.0,
               //               ),
               //               leading: Icon(Icons.person,
               //                   color: Theme.of(context).primaryColor
               //               ),
               //             ),
               //           ),
               //
               //         ],
               //       ),
               //     ),
               //
               //     //تغيير الاعدادات
               //     Padding(
               //       padding: const EdgeInsets.all(8.0),
               //       child: Column(
               //         children: [
               //           InkWell(
               //             onTap: () {
               //               // Navigator.push(
               //               //     context,
               //               //     MaterialPageRoute(
               //               //         builder: (context) => MyProfile()));
               //             },
               //             child: ListTile(
               //               title: Text(
               //                 "تغيير الاعدادات الشخصية",
               //                 style: TextStyle(
               //                   color: Colors.black,
               //                 ),
               //               ),
               //               trailing: Icon(
               //                 Icons.navigate_next,
               //                 color: Colors.black,
               //                 size: 20.0,
               //               ),
               //               leading: Icon(Icons.settings,
               //                   color: Theme.of(context).primaryColor
               //               ),
               //             ),
               //           ),
               //           // Divider(
               //           //   color: Colors.grey,
               //           // )
               //         ],
               //       ),
               //     ),
               //     //change password
               //     Padding(
               //       padding: const EdgeInsets.all(8.0),
               //       child: Column(
               //         children: [
               //           InkWell(
               //             onTap: () {
               //               // Navigator.push(
               //               //     context,
               //               //     MaterialPageRoute(
               //               //         builder: (context) => ChangePassword()));
               //             },
               //             child: ListTile(
               //               title: Text(
               //                 "تغيير كلمة المرور",
               //                 style: TextStyle(
               //                   color: Colors.black,
               //                 ),
               //               ),
               //               trailing: Icon(
               //                 Icons.navigate_next,
               //                 color: Colors.black,
               //                 size: 20.0,
               //               ),
               //               leading: Icon(Icons.lock_open,
               //                   color: Theme.of(context).primaryColor
               //               ),
               //             ),
               //           ),
               //           // Divider(
               //           //   color: Colors.grey,
               //           // )
               //         ],
               //       ),
               //     ),
               //   ],
               // ),




               //my  من نحن


               //حول التطبيق
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     InkWell(
                       onTap: () {
                         Navigator.of(context).pushReplacementNamed("aboutMe");

                       },
                       child: ListTile(
                         title: Text(
                           "حول التطبيق",
                           style: TextStyle(
                             color: Colors.black,
                           ),
                         ),
                         trailing: Icon(
                           Icons.navigate_next,
                           color: Colors.black,
                           size: 20.0,
                         ),
                         leading: Icon(Icons.info,
                             color: Theme.of(context).primaryColor
                         ),
                       ),
                     ),
                     Divider(
                       color: Colors.grey,
                     )
                   ],
                 ),
               ),

               //my  الاشعارات

               // Padding(
               //   padding: const EdgeInsets.all(8.0),
               //   child: Column(
               //     children: [
               //       InkWell(
               //         onTap: () {
               //           Navigator.push(
               //               context,
               //               MaterialPageRoute(
               //                   builder: (context) => NotifyScreen()),
               //           );
               //           },
               //         child: ListTile(
               //           title: Text(
               //             "الاشعارات",
               //             style: TextStyle(
               //               color: Colors.black,
               //             ),
               //           ),
               //           trailing: Icon(
               //             Icons.navigate_next,
               //             color: Colors.black,
               //             size: 20.0,
               //           ),
               //           leading: Icon(Icons.notifications,
               //               color: Theme.of(context).primaryColor
               //           ),
               //         ),
               //       ),
               //       Divider(
               //         color: Colors.grey,
               //       )
               //     ],
               //   ),
               // ),
             ],
           ),
        ),
      ),
    );
  }
}
