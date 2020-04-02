import 'package:Healthy_Ageing/models/match.dart';
List<Match> getMatches(){
  return[
    Match(
      id: '0',
      OwnerName: "Geoff",
      PetName: "Zorro",
      profile_photo: "https://pawsh-magazine.com/wp-content/uploads/2014/06/men-and-dogs-1.jpg",
      matched_back: true,
    ),
    Match(
        id: '1',
      OwnerName: "Emily",
      PetName: "Lulu",
        profile_photo: "https://media.mnn.com/assets/images/2017/12/woman_dog_bed.jpg.838x0_q80.jpg",
        matched_back: true,
    ),
    Match(
      id: '2',
      OwnerName: "Mark",
      PetName: "Dipsy",
      profile_photo: "https://media.fromthegrapevine.com/assets/images/2015/2/man-and-his-dog.jpg.824x0_q71_crop-scale.jpg",
      matched_back: true,
    ),
    Match(
      id: '3',
      OwnerName: "Lucy",
      PetName: "Sushi + Sashimi",
      profile_photo: "https://i.pinimg.com/564x/24/d7/f1/24d7f118ef40f866195735d11eeae704.jpg",
      matched_back: true,
    ),
  ];
}

List<Match> getDisMatches(){
  return[
    Match(
      id: '0',
      OwnerName: "Rebecca",
      PetName: "Mittens",
      profile_photo: "https://pawsh-magazine.com/wp-content/uploads/2014/06/men-and-dogs-1.jpg",
      matched_back: false,
    ),
    Match(
      id: '1',
      OwnerName: "Lucas",
      PetName: "Frankie",
      profile_photo: "https://media.mnn.com/assets/images/2017/12/woman_dog_bed.jpg.838x0_q80.jpg",
      matched_back: false,
    ),

  ];
}