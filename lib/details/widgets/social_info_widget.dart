import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialInfoWidget extends StatelessWidget {
  const SocialInfoWidget({
    super.key,
    required this.journey,
    required this.visible,
  });

  final JourneyModel journey;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Visibility(
        visible: visible,
        child: Row(
          children: [
            Icon(
              CupertinoIcons.heart,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            const SizedBox(width: 10),
            Text(
              journey.numOfLikes.toString(),
              style: Theme.of(context).primaryTextTheme.titleLarge,
            ),
            const SizedBox(width: 20),
            Icon(
              CupertinoIcons.arrowshape_turn_up_left,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            const SizedBox(width: 10),
            Text(
              journey.numOfShares.toString(),
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
