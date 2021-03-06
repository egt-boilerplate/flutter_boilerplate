import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

void previewImages(BuildContext context, List<String> images) {
  showCupertinoModalPopup(
    context: context,
    builder: (ctx) => PhotoViewGallery.builder(
      scrollPhysics: BouncingScrollPhysics(),
      enableRotation: true,
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(images[index]),
          // initialScale: PhotoViewComputedScale.contained * 0.8,
          heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
          onTapUp: (ctx, detail, controllerValue) {
            Navigator.of(context).pop();
          },
        );
      },
      itemCount: images.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      ),
      // backgroundDecoration: widget.backgroundDecoration,
      // pageController: widget.pageController,
      // onPageChanged: onPageChanged,
    ),
  );
}
