
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../functions/validInput.dart';
import '../../providers/auth_user.dart';
import '../../widgets/showAlertDialog.dart';

class Login extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var  deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            //background   color
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                      Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1],
                  )),
            ),
            SingleChildScrollView(
              child: Container(
                      height: deviceSize.height,
                      width: deviceSize.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          //  mix  center   name
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              padding:
                              EdgeInsets.symmetric(vertical: 8.0, horizontal: 80.0),
                                transform: Matrix4.rotationZ(-8 * 3.14 / 180)..translate(-10.0),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepOrange.shade900,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                              child: Text(
                                'mix center',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  //fontFamily: kfont_turk,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                             //  card
                          Flexible(
                            flex: deviceSize.width > 600 ? 2 : 1,
                            child: LoginCard(),
                          ),
                        ],
                          ),
                ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {

  bool  _logMode=true ;

  final GlobalKey<FormState> _formKey=GlobalKey();

  TapGestureRecognizer _changeLogMode;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  String  _token;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Firebase.initializeApp();   //  im main function used
    _firebaseMessaging.getToken()
        .then((String token) {
           assert (token!=null)   ;
          setState(() {
            _token=token;
          });
          print(" token is :$_token");
     });


    _changeLogMode=new TapGestureRecognizer()..onTap =(){
      setState(() {
        _logMode=!_logMode;
      });
    };

  }
  @override
  Widget build(BuildContext context) {
    var  deviceSize = MediaQuery.of(context).size;
    final auth = Provider.of<Auth>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,

      child: AnimatedContainer(
           height: _logMode?deviceSize.height*0.40
               :deviceSize.height*0.5,
               // :deviceSize.height*0.5,
        width: deviceSize.width * 0.85,
        padding: EdgeInsets.all(10.0),
       duration: Duration(milliseconds: 600),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.0,),

                textFormFieldForAll(mobileController,'رقم الموبايل 5xxxx',
                    Icons.phone_android_outlined,TextInputType.phone,"mobile",false),
                SizedBox(height: 10.0,),

                textFormFieldForAll(passwordController,'كلمة المرور',
                    Icons.lock,TextInputType.phone,"password",false),
                SizedBox(height: 10.0,),

                _logMode==false?textFormFieldForAll(usernameController,'الاسم',
                    Icons.person_add,TextInputType.text,"username",false)
                    :Container(height: 1.0,) ,

                SizedBox(
                  height: 20,
                ),

                //signin or  signup  btn

                ElevatedButton(
                  onPressed: () {
                       var formdata = _formKey.currentState;
                       if (formdata.validate()) {
                         formdata.save();
                         showLoading(context);

                        _logMode?
                         auth.login(mobileController.text,passwordController.text,context,_token)
                             :auth.signUp(mobileController.text,
                             passwordController.text,usernameController.text,context,_token);

                       }else {
                         print("not valid");
                       }

                  },
                  child:Text(  _logMode?  'تسجيل دخول':'إنشاء حساب'
                ),),

               Container(
                 margin: EdgeInsets.only(top: 10),
                 child: RichText(
                   text: TextSpan(
                     style: TextStyle(
                         color: Colors.black,
                         fontSize: 16,
                         ),
                       children: <TextSpan>[
                       TextSpan(text: _logMode ? "في حال ليس لديك حساب يمكنك "
                                         : "اذا كان لديك حساب يمكنك"),

                         TextSpan(
                           recognizer: _changeLogMode,
                             text: _logMode
                             ? " انشاء حساب من هنا  "
                             : " تسجيل الدخول من هنا  ",
                             style: TextStyle(
                                 color: Theme.of(context).primaryColor,
                                 fontWeight: FontWeight.w700)
                         ),


                       ]

                   ),)

                 )

              ],
            ),
          ),
        ),

      )

    );
  }

  Widget textFormFieldForAll (TextEditingController  controller,
      String label, icon ,TextInputType inputType ,validType,bool  pwd){
    return Container(
      height: MediaQuery.of(context).size.height*0.08,
      child: TextFormField(
        controller:controller,
        keyboardType: inputType,
        obscureText: pwd,
        validator: (value) {
          if(validType== "mobile"){
            return validInput(value, 10, 10, "يكون رقم الهاتف ","mobile");
          }
          if (validType == "password") {
            return validInput(value, 20, 3, "تكون كلمة  المرور","");
          }
          if (validType == "username") {
            return validInput(value, 20, 3, "يكون الاسم","");
          }
         return null;
        },
        // onSaved: (value) {
        //   //_authData['email'] = value;
        //   _email = value;
        // },
        decoration:InputDecoration(
          labelText: label,
          // filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, style: BorderStyle.solid, width: 1)),
          prefixIcon: Icon(
              icon,
              color: Theme.of(context).primaryColor
          ),
        ),
      ),
    );
  }


}
