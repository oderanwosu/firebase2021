class Article {
   String? uid;
  final String ownerID;
  final String imageURL;
  final String title;
  final String text;
  Article(
      { this.uid,
      required this.ownerID,
      required this.imageURL,
      required this.title,
      required this.text});
}
