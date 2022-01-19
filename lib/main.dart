import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsfeed/model/news.dart';
import 'package:newsfeed/screens/news_feed.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notifier/news_notifier.dart';

Future<void> main() async {
  //This are for intiliazing firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //shared preferences is to know app is opening for the first time or not
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //in isCategorySelected bool is setted to tru if categories are choosen
  var isCategorySelected = (prefs.getBool('isCategorySelected') == null) ? false : prefs.getBool('isCategorySelected');
  //provider fir statemanagement
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => NewsNotifier(),
      ),

    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coding with Curry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue,
      ),
      //if isCategorySelected bool is true means categories are selected then it will open the home page
      home: isCategorySelected?Scaffold(resizeToAvoidBottomInset:false,body: SafeArea(child: Feed())):Scaffold(resizeToAvoidBottomInset:false,body: SafeArea(child: HomePage())),

    ),
  ));
}
// list for making chips to select (option type)
List<String> chipList = [
  "Politics",
  "Education",
  "Sports",
  "Business",
  "Technology",
  "Science",
  "Travel",
  "Fashion"
];
// here i have created 2 home pages one opened when app is opened for the 1st time that means before selecting categories and other is after selecting catagories
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//choices selected from choicechips stored in a list
  List<String> selectedItemsList = List();



  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
      SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Container(
              child: Text(
                "newsfeed",
                style: GoogleFonts.rochester(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 28)),
              ),
            ),
            SizedBox(height: 50,),
            Container(
              child: Text(
                "Choose Interest",
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),
              ),
            ),
            SizedBox(height:20,),
            // multiple choice chips
            Wrap(
              spacing: 8,
              children: List.generate(chipList.length, (index) {
                return Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: ChoiceChip(

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding:EdgeInsets.all(0),
                    label: Container(
                      width: width/2.5,
                      height: height/13,
                      child: Center(
                        child: selectedItemsList.contains(chipList[index])?Text(
                          chipList[index],
                          style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black)),
                        ):Text(
                          chipList[index],
                          style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black)),
                        ),
                      ),
                    ),
                    selectedColor:Colors.redAccent,
                    selectedShadowColor: Colors.redAccent.shade700,
                    shadowColor: Colors.black12,
                    selected: selectedItemsList.contains(chipList[index]),
                    onSelected: (selected) {
                      setState(() {
                        selectedItemsList.contains(chipList[index])
                            ? selectedItemsList.remove(chipList[index])
                            : selectedItemsList.add(chipList[index]);

                      });
                    },
                  ),
                );
              }),),
            //choicechips

          ],
        ),
      ),
      bottomSheet: Container(
        height: 50,

        margin: EdgeInsets.only(bottom: 20),
        child:Center(
          child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            height: height/10,
            minWidth: width/2.5,
            padding: EdgeInsets.all(4),
            color: Colors.black,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              selectedItemsList.isNotEmpty?prefs.setStringList("selectedItemsList", selectedItemsList):null;

              prefs?.setBool("isCategorySelected", true);
              selectedItemsList.isNotEmpty?Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext con) {return Feed(selectedCategoryList: selectedItemsList,);})):null;
            },
            child: Text(
              "Proceed",
              style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white)),
            ),
          ),
        ),
      ),


    );
  }
}

class HomePageForSwipe extends StatefulWidget {
  //this will send selected category to feed page
  final List<String> selectedCategoryList;

  const HomePageForSwipe({Key key, this.selectedCategoryList}) : super(key: key);
  @override
  _HomePageStateForSwipe createState() => _HomePageStateForSwipe();
}

class _HomePageStateForSwipe extends State<HomePageForSwipe> {


  List<String> selectedItemsList = List();

  @override
  void initState() {
    if(widget.selectedCategoryList.isNotEmpty)
      selectedItemsList=widget.selectedCategoryList;
    else
      selectedItemsList=[];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
        int sensitivity = 8;
        if (details.delta.dx > sensitivity) {
          // Right Swipe




        } else if(details.delta.dx < -sensitivity){
          //Left Swipe
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body:SafeArea(
          child:Column(
            children: [
              SizedBox(height: 50,),
              Container(
                child: Text(
                  "newsfeed",
                  style: GoogleFonts.rochester(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 28)),
                ),
              ),
              Text(widget.selectedCategoryList.toString()),
              SizedBox(height: 50,),
              Container(
                child: Text(
                  "Choose Interest",
                  style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),
                ),
              ),
              SizedBox(height:20,),
              Wrap(
                spacing: 8,
                children: List.generate(chipList.length, (index) {
                  return Padding(

                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding:EdgeInsets.all(0),
                      label: Container(
                        width: width/2.5,
                        height: height/13,
                        child: Center(
                          child: selectedItemsList.contains(chipList[index])?Text(
                            chipList[index],
                            style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black)),
                          ):Text(
                            chipList[index],
                            style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.black)),
                          ),
                        ),
                      ),
                      selectedColor:Colors.redAccent,
                      selectedShadowColor: Colors.redAccent.shade700,
                      shadowColor: Colors.black12,
                      selected: selectedItemsList.contains(chipList[index]),
                      onSelected: (selected) {
                        setState(() {
                          selectedItemsList.contains(chipList[index])
                              ? selectedItemsList.remove(chipList[index])
                              : selectedItemsList.add(chipList[index]);

                        });
                      },
                    ),
                  );
                }),),

            ],
          ),),

        bottomSheet: Container(
          height: 50,

          margin: EdgeInsets.only(bottom: 20),
          child:Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              height: height/10,
              minWidth: width/2.5,
              padding: EdgeInsets.all(4),
              color: Colors.black,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                selectedItemsList.isNotEmpty?prefs.setStringList("selectedItemsList", selectedItemsList):null;
                selectedItemsList.isNotEmpty?Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext con) {return Feed(selectedCategoryList: selectedItemsList);})):null;
              },
              child: Text(
                "Proceed",
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white)),
              ),
            ),
          ),
        ),


      ),
    );
  }
}
