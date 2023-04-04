import 'package:flutter/material.dart';

import 'line_product_info_widget.dart';

class ProductInfoSectionComponent extends StatelessWidget {
  const ProductInfoSectionComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 52),
      child: Column(
        children: const [
          LineProductInfoWidget(
            title: 'HOPS',
            description: '2 Row, Torrified Wheat',
          ),
          SizedBox(height: 14),
          LineProductInfoWidget(
            title: 'MALTS',
            description: 'Cascade, First Gold, Mt.Hood',
          ),
          SizedBox(height: 14),
          LineProductInfoWidget(
            title: 'HOPS',
            description: '2 Row, Torrified Wheat',
          ),
          SizedBox(height: 14),
          LineProductInfoWidget(
            title: 'MALTS',
            description: 'Cascade, First Gold, Mt.Hood',
          ),
          SizedBox(height: 14),
          LineProductInfoWidget(
            title: 'HOPS',
            description: '2 Row, Torrified Wheat',
          ),
          SizedBox(height: 14),
          LineProductInfoWidget(
            title: 'MALTS',
            description: 'Cascade, First Gold, Mt.Hood',
          ),
          SizedBox(height: 14),
          LineProductInfoWidget(
            title: 'MALTS',
            description: 'Cascade, First Gold, Mt.Hood',
          ),
          SizedBox(height: 14),
          LineProductInfoWidget(
            title: 'MALTS',
            description: 'Cascade, First Gold, Mt.Hood',
          ),
          SizedBox(height: 14),
        ],
      ),
    );
  }
}
