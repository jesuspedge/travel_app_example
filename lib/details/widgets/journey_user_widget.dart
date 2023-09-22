import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JourneyUserWidget extends StatelessWidget {
  const JourneyUserWidget({
    super.key,
    required this.journey,
  });

  final JourneyModel journey;

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
                backgroundImage: AssetImage(journey.user.profilePicture),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    journey.user.name,
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                  Text(
                    '${journey.createdAt.day}/${journey.createdAt.month}/${journey.createdAt.year} at ${journey.createdAt.hour}:${journey.createdAt.minute}.',
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
        ],
      ),
    );
  }
}
