import 'dart:developer';

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final PageController controller;

  const Button({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            log('${details.delta.dx}');
            log('${details.localPosition.dx}');
            const radius = 125.0;
            // Location on the wheel
            final bool onTop = details.localPosition.dy <= radius;
            final bool onLeftSide = details.localPosition.dx <= radius;
            final bool onRightSide = !onLeftSide;
            final bool onBottom = !onTop;

            // Movements
            final bool panUp = details.delta.dy <= 0.0;
            final bool panLeft = details.delta.dx <= 0.0;
            final bool panRight = !panLeft;
            final bool panDown = !panRight;

            // Absoulte change on axis
            double yChange = details.delta.dy.abs();
            double xChange = details.delta.dx.abs();

            double verticalRotation =
                (onRightSide && panDown) || (onLeftSide && panUp)
                    ? yChange
                    : (-1 * yChange);

            double horizontalRotation =
                (onTop && panRight) || (onBottom && panLeft)
                    ? xChange
                    : (-1 * xChange);

            // Total computed change
            double rotationlChange = (verticalRotation + horizontalRotation) *
                (details.delta.distance * 0.2);

            // Move the page view scroller
            controller.jumpTo(controller.offset + rotationlChange);
          },
          child: Container(
            height: 250.0,
            width: 250.0,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(200.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('MENU',
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear,
                        );
                      },
                      icon: const Icon(
                        Icons.fast_rewind,
                        color: Colors.white,
                        size: 36.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear,
                        );
                      },
                      icon: const Icon(
                        Icons.fast_forward,
                        color: Colors.white,
                        size: 36.0,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.play_arrow, color: Colors.white, size: 36.0),
              ],
            ),
          ),
        ),
        Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(200.0),
          ),
        ),
      ],
    );
  }
}
