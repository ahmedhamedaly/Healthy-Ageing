final List<Profile> demoProfiles = [
  new Profile(
    photos: [
      "assets/photo_1.jpg",
      "assets/photo_2.jpg",
      "assets/photo_3.jpg",
      "assets/photo_4.jpg",
    ],
    name: "Coco + Thomas",
    bio: "Loves to eat and play.",
    distance: "1km away",
  ),
  new Profile(
    photos: [
      "assets/photo_4.jpg",
      "assets/photo_3.jpg",
      "assets/photo_2.jpg",
      "assets/photo_1.jpg",
    ],
    name: "Max + Laura",
    bio: "Shy dog with a big heart.",
    distance: "2km away",
  ),
];

class Profile {
  final List<String> photos;
  final String name;
  final String bio;
  final String distance;

  Profile({this.photos, this.name, this.bio, this.distance});
}
