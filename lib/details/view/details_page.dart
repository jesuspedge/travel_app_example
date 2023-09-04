import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.journey}) : super(key: key);
  final JourneyModel journey;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Hero(
                      tag: widget.journey.pictures[0],
                      child: Image.asset(
                        widget.journey.pictures[0],
                        fit: BoxFit.fitHeight,
                        color: Colors.black.withOpacity(0.5),
                        colorBlendMode: BlendMode.softLight,
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.ellipsis,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.journey.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        gradient:
                            widget.journey.kind == KindJourney.popularPlaces
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
                      widget.journey.kind == KindJourney.popularPlaces
                          ? 'Popular Places'
                          : 'Events',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.5,
                width: size.width,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.heart,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.journey.numOfLikes.toString(),
                        style: Theme.of(context).primaryTextTheme.titleLarge,
                      ),
                      const SizedBox(width: 20),
                      Icon(
                        CupertinoIcons.arrowshape_turn_up_left,
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.journey.numOfShares.toString(),
                        style: Theme.of(context).primaryTextTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: size.height * 0.43,
                width: size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(40))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
