import 'package:data_repository/data_repository.dart';

enum KindJourney { popularPlaces, event }

class JourneyModel {
  final String name;
  final KindJourney kind;
  final int numOfLikes;
  final int numOfShares;
  final UserModel user;
  final DateTime createdAt;
  final String description;
  final String long;
  final String lat;
  final List<UserModel> comments;
  final List<String> placesInCollection;
  final List<String> pictures;

  JourneyModel(
      {required this.name,
      required this.kind,
      required this.numOfLikes,
      required this.numOfShares,
      required this.user,
      required this.createdAt,
      required this.description,
      required this.long,
      required this.lat,
      required this.comments,
      required this.placesInCollection,
      required this.pictures});
}

List<JourneyModel> journeys = <JourneyModel>[
  JourneyModel(
    name: 'Ruta Puuc',
    kind: KindJourney.popularPlaces,
    numOfLikes: 467,
    numOfShares: 1356,
    user: users[0],
    createdAt: DateTime.utc(2022, 2, 23, 17, 40),
    description:
        'The Ruta Puuc (Puuc Route) is a fascinating trip to take from Merida, Mexico. This roadway slices through the Yucatan to connect various ancient ruins for such an interesting look into the ancient Mayan culture. Embarking on the Ruta Puuc is a great adventure to take in the Yucatan, whether by bus, tour or driving on your own. The Ruta Puuc can make for an action-packed day trip from Merida or, perhaps even better, a two-day slower roll across those sunny ruin-filled hills. These ancient Mayan ruins, spread across the Ruta Puuc, are not as popular as some of the Yucatan\'s other famous sites like Chichen Itza. So part of the appeal of touring the Ruta Puuc is the ability to enjoy the peaceful environments of these mystical and intriguing structures that have been here for over a millennium. Roaming around the rugged sites that are surrounded by a thick dry jungle is a very tranquil experience. It\'s not uncommon to be the only visitors at the Ruta Puuc ruins.',
    long: '-89.768132',
    lat: '20.359900',
    comments: users.sublist(3),
    placesInCollection: [
      'assets/images/puc4.png',
      'assets/images/puc5.png',
      'assets/images/puc6.png'
    ],
    pictures: [
      'assets/images/puc1.png',
      'assets/images/puc2.png',
      'assets/images/puc3.png'
    ],
  ),
  JourneyModel(
    name: 'Valladolid',
    kind: KindJourney.event,
    numOfLikes: 536,
    numOfShares: 836,
    user: users[1],
    createdAt: DateTime.utc(2023, 6, 12, 11, 23),
    description:
        'The Colonial town of Valladolid (Yucatan) is a must if you are visiting Chichen Itza. Even if you are not, Valladolid is an amazing experience for those who love authentic experiences out of the ordinary you can do in a regular trip. Valladolid is about 30 minutes from Chichen Itza, 1:30 hrs from Merida which is the Capital of the Yucatan State and about 1:45 hrs to 2:00 hrs from Cancun. Valladolid Yucatan was named like this after the capital of Spain at that moment (1543) which was “Valladolid”. Valladolid in Mexico was built atop a Maya town called Zaci and the Spanish used the stones of the temples that were in this town to build the actual Colonial architecture.',
    long: '-88.201900',
    lat: '20.690709',
    comments: users.sublist(3),
    placesInCollection: [
      'assets/images/valladolid4.png',
      'assets/images/valladolid5.png',
      'assets/images/valladolid6.png'
    ],
    pictures: [
      'assets/images/valladolid1.png',
      'assets/images/valladolid2.png',
      'assets/images/valladolid3.png'
    ],
  ),
  JourneyModel(
    name: 'Tizimín',
    kind: KindJourney.popularPlaces,
    numOfLikes: 479,
    numOfShares: 350,
    user: users[2],
    createdAt: DateTime.utc(2023, 4, 21, 8, 52),
    description:
        'Tizimin is a town in the northeast of Yucatan, about two hours from Merida and an hour from Valladolid. It isn\'t on any tourist trail despite being a city around the same size as Valladolid. Tizimin is also known as the City of the Three Kings and when you\'re there you\'ll see plenty of evidence of this other name. Tizimin actually means "tapir" in Maya, in case you were wondering. ',
    long: '-88.152127',
    lat: '21.142997',
    comments: users.sublist(3),
    placesInCollection: [
      'assets/images/tizimin4.png',
      'assets/images/tizimin5.png',
      'assets/images/tizimin6.png'
    ],
    pictures: [
      'assets/images/tizimin1.png',
      'assets/images/tizimin2.png',
      'assets/images/tizimin3.png'
    ],
  ),
];
