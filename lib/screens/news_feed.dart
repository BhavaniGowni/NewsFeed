import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsfeed/main.dart';
import 'package:newsfeed/model/news.dart';
import 'package:newsfeed/notifier/news_notifier.dart';
import 'package:newsfeed/screens/full_article.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feed extends StatefulWidget {

//from home page selecetedlist collected
  final List<String> selectedCategoryList;

  const Feed({Key key, this.selectedCategoryList}) : super(key: key);
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  SwiperController s=new SwiperController();
  BouncingScrollPhysics p;
  ScrollDirection sd;
  int index ;
  List categoryList;
  @override
  void initState() {

    getListAtFirstTime();

    NewsNotifier newsNotifier = Provider.of<NewsNotifier>(context, listen: false);
// to get newsarticle
    getNews(newsNotifier);
    index=0;
    s.animation=true;

    super.initState();



  }

  Future<void> getListAtFirstTime() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("isCategorySelected")&&prefs.getStringList("selectedItemsList").isNotEmpty){
      setState(() {
        categoryList=prefs.getStringList("selectedItemsList");
      });
    }
    else{
      categoryList=widget.selectedCategoryList;
    }


  }

  @override
  Widget build(BuildContext c) {

    NewsNotifier newsNotifier = Provider.of<NewsNotifier>(c);

    Future<void> _refreshList() async {
      //if screen is refreshed refreshed list will come
      getNews(newsNotifier);


    }

    print("building Feed");
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
        int sensitivity = 8;
        if (details.delta.dx > sensitivity) {
          // Right Swipe
          Navigator.of(c).push(MaterialPageRoute(builder: (BuildContext con) {return HomePageForSwipe(selectedCategoryList:categoryList);}));


        } else if(details.delta.dx < -sensitivity){
          //Left Swipe

        }
      },
      child: Scaffold(

        body: SafeArea(
          child: Container(
            height: MediaQuery.of(c).size.height,
            width: MediaQuery.of(c).size.width,
            alignment: Alignment.center,
            child: newsNotifier.newsList.isNotEmpty?RefreshIndicator(
              onRefresh: _refreshList,
              //SwiperList
              child: Swiper(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                controller: s,
                loop: true,
                itemBuilder:(BuildContext c, int index,) {
                  return _buildSwiperList(c,newsNotifier,index);
                },
                itemCount: newsNotifier.newsList.length,
                //pagination: new SwiperPagination(),
                layout: SwiperLayout.DEFAULT,
                itemWidth: MediaQuery.of(c).size.width,
                itemHeight: MediaQuery.of(c).size.height,
                duration: 10,
                index: index,
              ),
            ):Container(child:Center(child: Text("Empty",style: TextStyle(fontSize: 30,),)),),
          ),
        ),
      ),
    );
  }

  getNews(NewsNotifier newsNotifier) async {
//in new list every document will be added
    List<News> _newsList = [];
    List<News> _mainList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Feed')

        .orderBy("createdAt", descending: true)
        .get();



    snapshot.docs.forEach((document) {

      News news = News.fromMap(document.data());

      //print(news.newsCategory);
      //check each item in category list

      //add articles according to selected category
      _newsList.add(news);

    });
    _newsList.forEach((element) {
      for(int i=0;i<categoryList.length;i++){
        print(element.newsCategory==categoryList[i].toString());
        if(element.newsCategory==categoryList[i].toString()){
          //add articles according to selected category
          _mainList.add(element);
        }
      }
    });
    print("outl");
    _newsList.shuffle();
    newsNotifier.newsList = _mainList;



  }

  Widget _buildSwiperList(BuildContext c,NewsNotifier newsNotifier, int index) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
        int sensitivity = 8;
        if (details.delta.dx > sensitivity) {
          // Right Swipe
          Navigator.of(c).push(MaterialPageRoute(builder: (BuildContext con) {return HomePageForSwipe(selectedCategoryList:categoryList);}));


        } else if(details.delta.dx < -sensitivity){
          //Left Swipe
          newsNotifier.currentNewsArticle = newsNotifier.newsList[index];
          setState(() {
            this.index=index;
          });
          Navigator.of(c).push(MaterialPageRoute(builder: (BuildContext con) {return FullArticle();}));
        }
      },

      child: Scaffold(
        body: Container(
          //margin: EdgeInsets.only(left: 1, right: 1),
          padding: EdgeInsets.only(left: 1,right: 1),
          height: MediaQuery.of(context).size.height,
          child: ClipRRect(
            //borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Column(
              children: [
                newsNotifier.newsList[index].newsImageUrl!=null?Container(


                  child: Image.network(newsNotifier.newsList[index].newsImageUrl,

                    width: MediaQuery.of(context).size.width,
                    height: height/2,
                    fit: BoxFit.cover,
                  ),
                ):Container(),

                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(newsNotifier.newsList[index].newsHeading,style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 19,height: 1.3)),),
                      Text(newsNotifier.newsList[index].shortDescription,style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,height: 1.2)),),

                    ],
                  ),
                ),



                SizedBox(height: 50,),

              ],
            ),
          ),
        ),
        bottomSheet:   Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade200 ,
            borderRadius: BorderRadius.circular(50),

          ),
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10),
          margin: EdgeInsets.only(bottom: 20),
          child: ListTile(
              dense: true,

              leading:  Text("newsfeed",style: GoogleFonts.rochester(textStyle: TextStyle(fontWeight: FontWeight.w600,fontSize: 24)),),
              minLeadingWidth: 10,
              contentPadding:EdgeInsets.all(0),

              title: Container(padding:EdgeInsets.only(left: width/5,top:5),child: Text("Read Full Article",style: GoogleFonts.roboto(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),)),

              onTap: () {
                newsNotifier.currentNewsArticle = newsNotifier.newsList[index];
                setState(() {
                  this.index=index;
                });
                Navigator.of(c).push(MaterialPageRoute(builder: (BuildContext con) {return FullArticle();}));}
          ),
        ),

      ),
    );
  }

}