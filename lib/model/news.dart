import 'package:cloud_firestore/cloud_firestore.dart';
class News {
  Timestamp createdAt;
  String newsHeading;
  String newsCategory;
  String newsImageUrl;
  String shortDescription;
  String paragraphTitle1;
  String paragraph1;
  String image1;
  String paragraphTitle2;
  String paragraph2;
  String image2;
  String paragraphTitle3;
  String paragraph3;
  String image3;
  String paragraphTitle4;
  String paragraph4;
  String image4;

  News(  this.createdAt,
  this.newsHeading,
      this.newsCategory,
      this.newsImageUrl,
      this.shortDescription,
      this.paragraphTitle1,
      this.paragraph1,
      this.paragraphTitle2,
      this.paragraph2,
      this.image2,
      this.paragraphTitle3,
      this.paragraph3,
      this.image3,
      this.paragraphTitle4,
      this.paragraph4,
      this.image4);

  News.fromMap(Map<String, dynamic> data) {
    createdAt = data['createdAt'];

    newsHeading = data['newsHeading'];
    newsCategory = data['newsCategory'];
    newsImageUrl = data['newsImageUrl'];
    shortDescription = data['shortDescription'];

    paragraphTitle1 = data['paragraphTitle1'];
    paragraph1 = data['paragraph1'];
    image1 = data['image1'];

    paragraphTitle2 = data['paragraphTitle2'];
    paragraph2 = data['paragraph2'];
    image2 = data['image2'];


    paragraphTitle3 = data['paragraphTitle1'];
    paragraph3 = data['paragraph3'];
    image3 = data['image3'];

    paragraphTitle4 = data['paragraphTitle4'];
    paragraph4 = data['paragraph4'];
    image4 = data['image4'];



  }

  Map<String, dynamic> toMap() {
    return {

      'createdAt': createdAt,

      'newsCategory': newsCategory,
      'newsHeading': newsHeading,
      'newsImageUrl': newsImageUrl,
      'shortDescription': shortDescription,

      'paragraphTitle1': paragraphTitle1,
      'paragraph1': paragraph1,
      'image1': image1,

      'paragraphTitle2': paragraphTitle2,
      'paragraph2': paragraph2,
      'image2': image2,

      'paragraphTitle3': paragraphTitle3,
      'paragraph3': paragraph3,
      'image3': image3,

      'paragraphTitle4': paragraphTitle4,
      'paragraph4': paragraph4,
      'image4': image4,

    };
  }
}