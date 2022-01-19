import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsfeed/notifier/news_notifier.dart';
import 'package:provider/provider.dart';

class FullArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NewsNotifier newsNotifier = Provider.of<NewsNotifier>(context);
  ScrollController _c;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
        int sensitivity = 8;
        if (details.delta.dx > sensitivity) {
          // Right Swipe
          Navigator.pop(context);
        } else if(details.delta.dx < -sensitivity){
          //Left Swipe
        }
      },
      child: Scaffold(

        body: SafeArea(
          child: SingleChildScrollView(
            controller: _c,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,0,10,10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "newsfeed",
                        style: GoogleFonts.rochester(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 28)),
                      ),
                      Container(height: 10,margin: EdgeInsets.fromLTRB(10,0,10,0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide( //                   <--- left side
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),),),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:5.0,right: 5),
                        child: ClipRRect(

                          borderRadius: BorderRadius.circular(25.0),
                          child: Image.network(

                                newsNotifier.currentNewsArticle.newsImageUrl,

                            width: MediaQuery.of(context).size.width,

                            fit: BoxFit.fitWidth,
                          ),),
                      ),


                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          newsNotifier.currentNewsArticle.newsHeading,
                          style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 19,height: 1.3)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          newsNotifier.currentNewsArticle.shortDescription,
                          style: GoogleFonts.openSans(textStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 16,fontStyle: FontStyle.normal),),
                        ),
                      ),
                     Container(

                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [

                           newsNotifier.currentNewsArticle.paragraphTitle1.isNotEmpty?Container(
                             margin: EdgeInsets.only(top: 15),

                             child: Text(
                               newsNotifier.currentNewsArticle.paragraphTitle1,
                               style: GoogleFonts.openSans(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,fontStyle: FontStyle.normal),),
                             ),
                           ):Container(),
                           newsNotifier.currentNewsArticle.paragraph1.isNotEmpty?Container(
                             margin: EdgeInsets.only(top: 10),

                             child: Text(
                               newsNotifier.currentNewsArticle.paragraph1,
                               style: GoogleFonts.openSans(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,fontStyle: FontStyle.normal),),
                             ),
                           ):Container(),

                           newsNotifier.currentNewsArticle.image1.isNotEmpty?Container(
                             margin: EdgeInsets.only(top:10),

                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(20),
                               child: Image.network(newsNotifier.currentNewsArticle.image1,

                                 width: MediaQuery.of(context).size.width,

                                 fit: BoxFit.fitWidth,
                               ),
                             ),
                           ):Container(),

                         ],
                       ),
                     ),
                      Container(

                        child: Column(
                          children: [
                            newsNotifier.currentNewsArticle.paragraphTitle2.isNotEmpty?Container(
                              margin: EdgeInsets.only(top: 15),

                              child: Text(
                                newsNotifier.currentNewsArticle.paragraphTitle2,
                                style: GoogleFonts.openSans(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,fontStyle: FontStyle.normal),),
                              ),
                            ):Container(),
                            newsNotifier.currentNewsArticle.paragraph2.isNotEmpty?Container(
                              margin: EdgeInsets.only(top: 10),

                              child: Text(
                                newsNotifier.currentNewsArticle.paragraph2,
                                style: GoogleFonts.openSans(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,fontStyle: FontStyle.normal),),
                              ),
                            ):Container(),

                            newsNotifier.currentNewsArticle.image2.isNotEmpty?Container(
                              margin: EdgeInsets.only(top: 10),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(newsNotifier.currentNewsArticle.image2,

                                  width: MediaQuery.of(context).size.width,

                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ):Container(),


                          ],
                        ),
                      ),
                      Container(

                        child: Column(
                          children: [
                            newsNotifier.currentNewsArticle.paragraphTitle3.isNotEmpty?Container(
                              margin: EdgeInsets.only(top: 15),

                              child: Text(
                                newsNotifier.currentNewsArticle.paragraphTitle3,
                                style: GoogleFonts.openSans(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,fontStyle: FontStyle.normal),),
                              ),
                            ):Container(),
                            newsNotifier.currentNewsArticle.paragraph3.isNotEmpty?Container(
                              margin: EdgeInsets.only(top: 10),

                              child: Text(
                                newsNotifier.currentNewsArticle.paragraph3,
                                style: GoogleFonts.openSans(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,fontStyle: FontStyle.normal),),
                              ),
                            ):Container(),

                            newsNotifier.currentNewsArticle.image3.isNotEmpty?Container(
                              margin: EdgeInsets.only(top: 10),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(newsNotifier.currentNewsArticle.image3,

                                  width: MediaQuery.of(context).size.width,

                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ):Container(),


                          ],
                        ),
                      ),
                      Container(

                        child: Column(
                          children: [
                            newsNotifier.currentNewsArticle.paragraphTitle4.isNotEmpty?Container(
                              margin: EdgeInsets.only(top: 15),

                              child: Text(
                                newsNotifier.currentNewsArticle.paragraphTitle4,
                                style: GoogleFonts.openSans(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,fontStyle: FontStyle.normal),),
                              ),
                            ):Container(),
                            newsNotifier.currentNewsArticle.paragraph4.isNotEmpty?Container(
                              margin: EdgeInsets.only(top: 10),

                              child: Text(
                                newsNotifier.currentNewsArticle.paragraph4,
                                style: GoogleFonts.openSans(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,fontStyle: FontStyle.normal),),
                              ),
                            ):Container(),

                            newsNotifier.currentNewsArticle.image4.isNotEmpty?Container(
                              margin: EdgeInsets.only(top: 10),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),

                                child: Image.network(newsNotifier.currentNewsArticle.image4,

                                  width: MediaQuery.of(context).size.width,

                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ):Container(),


                          ],
                        ),
                      ),
                      TextButton(onPressed: (){Navigator.pop(context);}, child: Text("<<<< Swipe to go back")),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}