import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.path,
    this.bundle,
    this.frameBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.scale,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.centerSlice,
    this.package,
    this.cacheWidth,
    this.cacheHeight,
    this.placeholder,
    this.removeColor = false,
    this.lottieRepeat,
    this.matchTextDirection = false,
  });
  final String path;
  final AssetBundle? bundle;
  final ImageFrameBuilder? frameBuilder;
  final ImageErrorWidgetBuilder? errorBuilder;
  final String? semanticLabel;
  final bool excludeFromSemantics = false;
  final double? scale;
  final double? width;
  final double? height;
  final Color? color;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment = Alignment.center;
  final ImageRepeat repeat = ImageRepeat.noRepeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback = false;
  final bool isAntiAlias = false;
  final String? package;
  final FilterQuality filterQuality = FilterQuality.low;
  final int? cacheWidth;
  final int? cacheHeight;
  final Widget? placeholder;
  final bool removeColor;
  final bool? lottieRepeat;

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http') || path.startsWith('https')) {
      if (path.contains(".svg")) {
        return SvgPicture.network(
          path,
          key: key,
          fit: fit ?? BoxFit.contain,
          width: width,
          height: height,
          alignment: alignment,
          color: color,
        );
      }
      if (path.contains(".json")) {
        return Lottie.network(
          path,
          fit: fit,
          height: height,
          width: width,
          alignment: alignment,
          repeat: lottieRepeat,
          errorBuilder: errorBuilder,
          filterQuality: filterQuality,
        );
      }
      // Cached network image with shimmer placeholder
      return CachedNetworkImage(
        imageUrl: path,
        key: key,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment as Alignment,
        errorWidget: (_, __, ___) => errorBuilder != null
            ? const Icon(Icons.error)
            : const Icon(Icons.error),
        placeholder: (_, __) =>
            placeholder ??
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: width ?? double.infinity,
                height: height ?? double.infinity,
                color: Colors.white,
              ),
            ),
      );
    } else if (path.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        key: key,
        fit: fit ?? BoxFit.contain,
        width: width,
        height: height,
        alignment: alignment,
        package: package,
        color: color,
      );
    } else if (path.endsWith('.json')) {
      return Lottie.asset(
        path,
        bundle: bundle,
        errorBuilder: errorBuilder,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        package: package,
        filterQuality: filterQuality,
        repeat: lottieRepeat,
      );
    } else {
      return Image.asset(
        path,
        key: key,
        bundle: bundle,
        frameBuilder: frameBuilder,
        errorBuilder: errorBuilder,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        scale: scale,
        width: width,
        height: height,
        color: color,
        opacity: opacity,
        colorBlendMode: colorBlendMode,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
        centerSlice: centerSlice,
        matchTextDirection: matchTextDirection,
        gaplessPlayback: gaplessPlayback,
        isAntiAlias: isAntiAlias,
        package: package,
        filterQuality: filterQuality,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
    }
  }
}
