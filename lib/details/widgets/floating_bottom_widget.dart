import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingBottomWidget extends StatelessWidget {
  const FloatingBottomWidget({
    super.key,
    required this.journey,
  });

  final JourneyModel journey;

  @override
  Widget build(BuildContext context) {
    var comments = journey.comments.sublist(0, 3);
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
                                journey.comments[index].profilePicture),
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
                  journey.comments.length.toString(),
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
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    CupertinoIcons.location_solid,
                    color: Colors.blue.shade400,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
