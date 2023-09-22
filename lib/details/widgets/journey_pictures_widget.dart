import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';

class JourneyPicturesWidget extends StatefulWidget {
  const JourneyPicturesWidget({
    super.key,
    required this.journey,
  });

  final JourneyModel journey;

  @override
  State<JourneyPicturesWidget> createState() => _JourneyPicturesWidgetState();
}

class _JourneyPicturesWidgetState extends State<JourneyPicturesWidget> {
  int imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.journey.pictures.length,
              onPageChanged: (value) {
                setState(() {
                  imageIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.journey.pictures[index]),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                    ),
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.journey.pictures.length,
              (index) => Container(
                color: imageIndex == index
                    ? Theme.of(context).primaryIconTheme.color
                    : Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 3,
                width: imageIndex == index ? 25 : 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
