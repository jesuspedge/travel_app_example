import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';

class KindJourneyWidget extends StatelessWidget {
  const KindJourneyWidget({
    super.key,
    required this.journey,
  });

  final JourneyModel journey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Text(
        journey.kind == KindJourney.popularPlaces ? 'Popular Places' : 'Events',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}
