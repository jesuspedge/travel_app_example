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
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              height: size.height * 0.65,
              width: size.width,
              child: BackgroundImagesWidget(widget: widget),
            ),
            /*Positioned(
              width: size.width,
              top: 0,
              child: const AppBarWidget(),
            ),
            Positioned(
              top: 100,
              left: 25,
              child: JourneyNameWidget(widget: widget),
            ),
            Positioned(
              height: size.height * 0.5,
              width: size.width,
              bottom: 0,
              child: SocialInfoWidget(widget: widget),
            ),
            Positioned(
              height: (size.height * 0.65),
              width: size.width,
              bottom: -(size.height * 0.21),
              child: JourneyDataInfoWidget(size: size, widget: widget),
            ),
            Positioned(
              width: size.width,
              bottom: 10,
              child: FloatingBottomWidget(
                widget: widget,
              ),
            )*/
          ],
        ),
      ),
    );
  }
}

class FloatingBottomWidget extends StatelessWidget {
  const FloatingBottomWidget({
    super.key,
    required this.widget,
  });

  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    var comments = widget.journey.comments.sublist(0, 3);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: 55,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xFF2F289E),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Stack(
                    children: List.generate(comments.length, (index) {
                      return Positioned(
                        left: index * 10,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: CircleAvatar(
                            radius: 13,
                            backgroundImage: AssetImage(
                                widget.journey.comments[index].profilePicture),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Comments',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.journey.comments.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward,
                  color: Color.fromARGB(255, 16, 14, 54),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              CupertinoIcons.location_solid,
              color: Colors.blue.shade400,
            ),
          )
        ],
      ),
    );
  }
}

class JourneyDataInfoWidget extends StatelessWidget {
  const JourneyDataInfoWidget({
    super.key,
    required this.size,
    required this.widget,
  });

  final Size size;
  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.journey.user.profilePicture),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.journey.user.name,
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                  Text(
                    '${widget.journey.createdAt.day}/${widget.journey.createdAt.month}/${widget.journey.createdAt.year} at ${widget.journey.createdAt.hour}:${widget.journey.createdAt.minute}.',
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.add,
                    color: Colors.grey,
                    size: 13,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Follow',
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.7), fontSize: 15),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.grey.withOpacity(0.7),
                ),
                const SizedBox(width: 5),
                Text(
                  'YUCATÁN, México',
                  style: TextStyle(
                      color: Colors.blue.shade200,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.22,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                widget.journey.description,
                style: Theme.of(context).primaryTextTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'PLACES IN THIS COLLECTION',
              style: Theme.of(context).primaryTextTheme.labelLarge,
            ),
          ),
          SizedBox(
            height: size.height * 0.15,
            child: ListView.separated(
              itemCount: widget.journey.placesInCollection.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              itemBuilder: ((context, index) {
                return Container(
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              widget.journey.placesInCollection[index]),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(15)),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class SocialInfoWidget extends StatelessWidget {
  const SocialInfoWidget({
    super.key,
    required this.widget,
  });

  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFBEEEFD),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(7),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.checkmark_alt_circle,
                    color: Colors.blue.shade400,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Check In',
                    style: TextStyle(
                        color: Colors.blue.shade300,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class JourneyNameWidget extends StatelessWidget {
  const JourneyNameWidget({
    super.key,
    required this.widget,
  });

  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.journey.name,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              gradient: widget.journey.kind == KindJourney.popularPlaces
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
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Text(
            widget.journey.kind == KindJourney.popularPlaces
                ? 'Popular Places'
                : 'Events',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class BackgroundImagesWidget extends StatelessWidget {
  const BackgroundImagesWidget({
    super.key,
    required this.widget,
  });

  final DetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.journey.pictures[0],
      child: Image.asset(
        widget.journey.pictures[0],
        fit: BoxFit.fitHeight,
        color: Colors.black.withOpacity(0.5),
        colorBlendMode: BlendMode.softLight,
      ),
    );
  }
}
