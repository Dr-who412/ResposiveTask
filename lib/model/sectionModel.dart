class Section{
  String? title;
  String? image;
  Section({this.title,this.image});
  Section.fromJson(Map<String,dynamic> json){
    title=json['title'];
    image=json['image'];
  }
  Map<String,dynamic>? toMap(){
    return{
      'title':title,
      'image':image,
    };
  }
}