import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class UniversalBlock extends StatelessWidget {
  const UniversalBlock({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.isSquared = false,
    this.isFlexible = false,
  });
  final IconData icon;
  final String title;
  final Widget content;
  final bool isSquared;
  final bool isFlexible;
  @override
  Widget build(BuildContext context) {
    return isSquared
        ? AspectRatio(
            aspectRatio: 1,
            child: BlurryContainer(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(15),
                blur: 90,
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(icon,
                              size: 14,
                              applyTextScaling: true,
                              color: Colors.white.withOpacity(0.8)),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      indent: 8,
                      endIndent: 8,
                      thickness: 1,
                      height: 16,
                      color: Colors.white30,
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: content,
                      ),
                    )
                  ],
                )),
          )
        : BlurryContainer(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(15),
            blur: 90,
            height: isFlexible ? 150 : null,
            color: Colors.black.withOpacity(0.1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(icon,
                          size: 14,
                          applyTextScaling: true,
                          color: Colors.white.withOpacity(0.8)),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            height: 1),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  indent: 8,
                  endIndent: 8,
                  thickness: 1,
                  height: 16,
                  color: Colors.white30,
                ),
                isFlexible
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
                          child: content,
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: content,
                      ),
              ],
            ));
  }
}
