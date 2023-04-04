import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ImageUtil {
  static Future<List<Color>> extractDominantColors(String image) async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(image),
      size: const Size(200, 200),
      maximumColorCount: 10,
    );

    return paletteGenerator.colors.toList().sublist(0, 3);
  }
}
