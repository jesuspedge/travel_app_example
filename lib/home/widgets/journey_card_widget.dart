import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JourneyCard extends StatelessWidget {
  const JourneyCard({
    super.key,
    required this.size,
    required this.journey,
    required this.last,
  });

  final Size size;
  final JourneyModel journey;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: last
          ? const EdgeInsets.fromLTRB(20, 10, 20, kBottomNavigationBarHeight)
          : const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        height: size.height * 0.4,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(journey.pictures[0]),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.softLight)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage(journey.user.profilePicture),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            journey.user.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            '${journey.createdAt.day}/${journey.createdAt.month}/${journey.createdAt.year} at ${journey.createdAt.hour}:${journey.createdAt.minute}.',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        CupertinoIcons.ellipsis,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const Spacer(flex: 2),
                  Text(
                    journey.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        gradient: journey.kind == KindJourney.popularPlaces
                            ? LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.amber.shade300,
                                  Colors.amber.shade700,
                                ],
                              )
                            : LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.green.shade300,
                                  Colors.green.shade700,
                                ],
                              ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      journey.kind == KindJourney.popularPlaces
                          ? 'Popular Places'
                          : 'Events',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.heart,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        journey.numOfLikes.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        CupertinoIcons.arrowshape_turn_up_left,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        journey.numOfShares.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
