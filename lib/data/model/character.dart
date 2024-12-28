class Character{
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusOfDeadOrAlive;
  late List<dynamic> appearanceOfSeason;
  late String actorName;
  late String categoryForTwoSerson;
  late List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String,dynamic>json){
   charId=json['char_id'];
   name=json['name'];
   nickName=json['nickname'];
   image=json['img'];
   jobs=json['occupation'];
   statusOfDeadOrAlive=json['status'];
   appearanceOfSeason=json['apperance'];
   actorName=json['portrayed'];
   categoryForTwoSerson=json['category'];
   betterCallSaulAppearance=json['better_call_saul_appearance'];
   charId=json['char_id'];
  





  }













}