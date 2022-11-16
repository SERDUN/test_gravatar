import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../config/gravatar_config.dart';

mixin GravatarImageSourceMixin {
  static const _keyGravatarImageNotDefined = 404;

  String imageKey(String email) => 'image:$email';

  Future<ImageProvider?> getImage({
    required String email,
    required Uri url,
    bool isEnabledCache = true,
  }) async {
    return (isEnabledCache && !kIsWeb) ? getCacheImage(email: email, url: url) : getImageFromNetwork(url);
  }

  Future<ImageProvider?> getImageFromNetwork(Uri url) async {
    return Image.network(url.toString()).image;
  }

  Future<ImageProvider?> getCacheImage({
    required String email,
    required Uri url,
  }) async {
    Completer<ImageProvider?> completer = Completer<ImageProvider?>();
    var cachedImage = await GravatarCacheManager.instance.getFileFromCache(imageKey(email), ignoreMemCache: false);

    if (cachedImage != null) {
      completer.complete(Image.file(cachedImage.file).image);
    } else {
      try {
        final result = await GravatarCacheManager.instance.downloadFile(url.toString(), key: imageKey(email));
        completer.complete(Image.file(result.file).image);
      } on HttpExceptionWithStatus catch (e) {
        if (e.statusCode == _keyGravatarImageNotDefined) {
          completer.complete(null);
        } else {
          completer.completeError(e);
        }
      } catch (e) {
        completer.completeError(e);
      }
    }
    return completer.future;
  }
}
