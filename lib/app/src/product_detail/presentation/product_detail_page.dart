import 'dart:math' as math;

import 'package:beer_store/app/config/theme/app_colors.dart';
import 'package:beer_store/app/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/utils/image_util.dart';
import '../../../shared/widgets/app_button.dart';
import 'components/circle_product_widget.dart';
import 'components/product_counter_widget.dart';
import 'components/product_info_section_component.dart';
import 'components/product_tile_section_component.dart';

class ProductDetailPage extends StatefulWidget {
  final String id;
  const ProductDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final DraggableScrollableController _scrollableController =
      DraggableScrollableController();
  final ValueNotifier<double> _circleRadius = ValueNotifier<double>(180);
  final ValueNotifier<double> _imageHeight = ValueNotifier<double>(250);
  final double _minSize = 0.44;
  final double _maxSize = 0.76;

  final ValueNotifier<bool> _buttonLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollableController.addListener(_updateCircleRadius);
  }

  @override
  void dispose() {
    _scrollableController.removeListener(_updateCircleRadius);
    super.dispose();
  }

  void _updateCircleRadius() {
    double size = _scrollableController.size.clamp(_minSize, _maxSize);
    double normalizedSize = (size - _minSize) / (_maxSize - _minSize);
    _circleRadius.value = 180 - (normalizedSize * 100);
    _imageHeight.value = 250 - (normalizedSize * 100);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBarWidget(
        onBackPressed: () => context.pop(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(42),
                  bottomRight: Radius.circular(42),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      height: size.height * .5,
                      width: size.width,
                      child: Stack(
                        children: [
                          FutureBuilder(
                            future: ImageUtil.extractDominantColors(
                                'assets/${widget.id}.png'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data as List<Color>;
                                return ValueListenableBuilder(
                                    valueListenable: _circleRadius,
                                    builder: (context, value, _) {
                                      return Positioned(
                                        left: 0,
                                        right: 0,
                                        child: CircleProductWidget(
                                          radius: value,
                                          colors: data,
                                        ),
                                      );
                                    });
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          Positioned(
                            top: 30,
                            left: 0,
                            right: 0,
                            child: ValueListenableBuilder(
                              valueListenable: _imageHeight,
                              builder: (context, value, _) {
                                return SizedBox(
                                  height: _imageHeight.value,
                                  child: Hero(
                                    tag: widget.id,
                                    child: Image.asset(
                                      'assets/${widget.id}.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildDiscoverDrawer(),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProductCounter(initialValue: 1),
                SizedBox(
                  height: 60,
                  width: size.width * .5,
                  child: ValueListenableBuilder(
                    valueListenable: _buttonLoading,
                    builder: (_, value, __) {
                      return AppButton(
                        reverse: true,
                        loading: value,
                        onPressed: () {
                          if (value) {
                            _buttonLoading.value = false;
                          } else {
                            _buttonLoading.value = true;
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '\$30',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor.withOpacity(.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              'ADD TO CART',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _sliverList(int size, int sliverChildCount) {
    List<Widget> widgetList = [];
    widgetList.add(
      SliverPersistentHeader(
        pinned: true,
        delegate: _SliverAppBarDelegate(
          maxHeight: 120,
          minHeight: 120,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(42),
                topRight: Radius.circular(42),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Goose Island 312',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  'Crisp, Fruity Ale, Smooth & Creamy Nationwide',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryColor.withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    widgetList.add(
      SliverFixedExtentList(
        itemExtent: 80,
        delegate: SliverChildBuilderDelegate(
          childCount: sliverChildCount,
          (context, index) {
            return const ProductTileSectionComponent();
          },
        ),
      ),
    );

    widgetList.add(
      SliverFixedExtentList(
        itemExtent: 350,
        delegate: SliverChildBuilderDelegate(
          childCount: sliverChildCount,
          (context, index) {
            return const ProductInfoSectionComponent();
          },
        ),
      ),
    );
    return widgetList;
  }

  Widget _buildDiscoverDrawer() {
    return DraggableScrollableSheet(
      maxChildSize: 0.76,
      minChildSize: 0.44,
      initialChildSize: 0.44,
      snap: true,
      controller: _scrollableController,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(42),
              topRight: Radius.circular(42),
              bottomLeft: Radius.circular(42),
              bottomRight: Radius.circular(42),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: _sliverList(10, 1),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
