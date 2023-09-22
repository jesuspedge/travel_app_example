import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/details/details.dart';

class DetailsJourneyWidget extends StatelessWidget {
  const DetailsJourneyWidget({
    super.key,
    required this.widget,
    required this.journey,
  });

  final DetailsPage widget;
  final JourneyModel journey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: widget.size.height * 0.22,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              journey.description,
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
          height: widget.size.height * 0.15,
          child: ListView.separated(
            itemCount: journey.placesInCollection.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemBuilder: ((context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(journey.placesInCollection[index]),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(15)),
              );
            }),
          ),
        ),
      ],
    );
  }
}
