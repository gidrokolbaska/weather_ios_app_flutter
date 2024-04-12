
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';
import 'package:sliver_tools/sliver_tools.dart';

class WeatherList extends StatefulWidget {
  const WeatherList({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList> {
  final List<String> itemList = List.generate(30, (index) => 'Index: $index');
  final List<String> itemList2 = List.generate(7, (index) => 'Index: $index');
  final ScrollController controller = ScrollController();

  double maxHeight = 250;
  double collapsedHeight = 65;
  double collapsedHeightForBigTemp = 120;
  double collapsedHeightForWeatherMain = 140;
  double collapsedHeightForWeatherMaxMin = 160;

  ValueNotifier<double> opacity1 = ValueNotifier<double>(1.0);
  ValueNotifier<double> opacity2 = ValueNotifier<double>(1.0);
  ValueNotifier<double> opacity3 = ValueNotifier<double>(1.0);
  ValueNotifier<double> opacity4 = ValueNotifier<double>(1.0);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBarBuilder(
          backgroundColorAll: Colors.transparent,
          backgroundColorBar: Colors.transparent,
          barHeight: collapsedHeight,
          initialContentHeight: maxHeight,
          collapseLeadingActions: true,
          pinned: true,
          stretch: true,
          stretchConfiguration: OverScrollHeaderStretchConfiguration(),
          leadingActions: [
            (context, expandRatio, barHeight, overlapsContent) {
              return const SizedBox.shrink();
            }
          ],
          contentBuilder: (context, expandRatio, contentHeight, centerPadding,
              overlapsContent) {
            double subtitleOpacity = contentHeight > 80
                ? 0
                : -(contentHeight - 80) / (80 - collapsedHeight);
            double bigTemperatureOpacity =
                ((contentHeight - 130) / (130 - collapsedHeightForBigTemp))
                    .clamp(0, 1);
            double weatherMainOpacity =
                ((contentHeight - 150) / (150 - collapsedHeightForWeatherMain))
                    .clamp(0, 1);
            double weatherMainMaxMinOpacity = ((contentHeight - 170) /
                    (170 - collapsedHeightForWeatherMaxMin))
                .clamp(0, 1);

            return Column(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Opacity(
                  opacity: subtitleOpacity,
                  child: const Text(
                    'test',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.0,
                    ),
                  ),
                ),
                Opacity(
                  opacity: bigTemperatureOpacity,
                  child: Transform.translate(
                    offset: const Offset(16, 0),
                    child: const Text(
                      '5°',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 80,
                          height: 0.8,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Opacity(
                  opacity: weatherMainOpacity,
                  child: const Text(
                    'Облачно',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 1),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Opacity(
                  opacity: weatherMainMaxMinOpacity,
                  child: const Text(
                    'Макс.: 5°, мин.:0°',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 1),
                  ),
                )
              ],
            );
          },
        ),
        SliverStack(
          insetOnOverlap: true,
          children: [
            SliverPositioned.fill(
              child: _CardBackground(
                opacity: opacity1,
              ),
            ),
            SliverStickyHeader.builder(
              builder: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  opacity1.value = state.scrollPercentage;
                });

                return Opacity(
                  opacity: 1 - state.scrollPercentage,
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      right: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Header #1',
                          style: TextStyle(color: Colors.white),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    ),
                  ),
                );
              },
              sliver: SliverClip(
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => ListTile(
                      leading: const CircleAvatar(
                        child: Text('0'),
                      ),
                      title: Text('List tile #$i'),
                    ),
                    childCount: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverStack(
          insetOnOverlap: true,
          children: [
            SliverPositioned.fill(
              child: _CardBackground(
                opacity: opacity2,
              ),
            ),
            SliverStickyHeader.builder(
              builder: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  opacity2.value = state.scrollPercentage;
                });

                return Opacity(
                  opacity: 1 - state.scrollPercentage,
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      right: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Header #1',
                          style: TextStyle(color: Colors.white),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    ),
                  ),
                );
              },
              sliver: SliverClip(
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => ListTile(
                      leading: const CircleAvatar(
                        child: Text('0'),
                      ),
                      title: Text('List tile #$i'),
                    ),
                    childCount: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverStack(
          insetOnOverlap: true,
          children: [
            SliverPositioned.fill(
              child: _CardBackground(
                opacity: opacity3,
              ),
            ),
            SliverStickyHeader.builder(
              builder: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  opacity3.value = state.scrollPercentage;
                });

                return Opacity(
                  opacity: 1 - state.scrollPercentage,
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      right: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Header #1',
                          style: TextStyle(color: Colors.white),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    ),
                  ),
                );
              },
              sliver: SliverClip(
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => ListTile(
                      leading: const CircleAvatar(
                        child: Text('0'),
                      ),
                      title: Text('List tile #$i'),
                    ),
                    childCount: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverStack(
          insetOnOverlap: true,
          children: [
            SliverPositioned.fill(
              child: _CardBackground(
                opacity: opacity4,
              ),
            ),
            SliverStickyHeader.builder(
              builder: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  opacity4.value = state.scrollPercentage;
                });

                return Opacity(
                  opacity: 1 - state.scrollPercentage,
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      right: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Header #1',
                          style: TextStyle(color: Colors.white),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    ),
                  ),
                );
              },
              sliver: SliverClip(
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => ListTile(
                      leading: const CircleAvatar(
                        child: Text('0'),
                      ),
                      title: Text('List tile #$i'),
                    ),
                    childCount: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverList.separated(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return Text(itemList[index]);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
        ),
        // SliverStack(
        //   insetOnOverlap: true,
        //   children: [
        //     SliverPositioned.fill(
        //       child: _CardBackground(
        //         opacity: opacity,
        //       ),
        //     ),
        //     SliverStickyHeader.builder(
        //       builder: (context, state) {
        //         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //           opacity.value = state.scrollPercentage;
        //         });

        //         return Opacity(
        //           opacity: 1 - state.scrollPercentage,
        //           child: const Padding(
        //             padding: EdgeInsets.only(
        //               left: 8.0,
        //               top: 8.0,
        //               right: 8.0,
        //             ),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   'Header #1',
        //                   style: const TextStyle(color: Colors.white),
        //                 ),
        //                 Divider(
        //                   height: 1,
        //                 )
        //               ],
        //             ),
        //           ),
        //         );
        //       },
        //       sliver: SliverClip(
        //         child: SliverList(
        //           delegate: SliverChildBuilderDelegate(
        //             (context, i) => ListTile(
        //               leading: CircleAvatar(
        //                 child: Text('0'),
        //               ),
        //               title: Text('List tile #$i'),
        //             ),
        //             childCount: 4,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class _CardBackground extends StatelessWidget {
  final ValueNotifier<double> opacity;

  const _CardBackground({required this.opacity});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: opacity,
      builder: (BuildContext context, value, Widget? child) {
        return BlurryContainer(
          color: Colors.white.withOpacity(0.15 * (1 - value - 0.4).clamp(0, 1)),
          blur: 150 * (1 - value),
          elevation: 0,
          height: 100,
          child: child!,
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}

// class _CardHeader extends StatelessWidget {
//   final String title;
//   const _CardHeader({
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       padding: const EdgeInsets.only(
//         left: 8.0,
//         top: 8.0,
//         right: 8.0,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 15,
//             ),
//           ),
//           Transform.translate(
//             offset: const Offset(0, 0.5),
//             child: const Divider(
//               indent: 6,
//               endIndent: 6,
//               height: 1,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
