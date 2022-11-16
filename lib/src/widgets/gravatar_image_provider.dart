import 'dart:async';

import '../config/gravatar_api_option.dart';
import '../mixin/gravatar_image_source_mixin.dart';
import '../mixin/gravatar_url_source_mixin.dart';

import 'package:flutter/widgets.dart';
import 'options.dart';

class GravatarImageProvider extends StatelessWidget with GravatarUrlSourceMixin, GravatarImageSourceMixin {
  const GravatarImageProvider({
    Key? key,
    required this.email,
    required this.complete,
    required this.none,
    required this.exception,
    required this.progress,
    this.options = const Options(),
    this.gravatarOptions = const GravatarOptions(),
  }) : super(key: key);

  final String email;

  final Options options;
  final GravatarOptions gravatarOptions;

  final Widget Function(BuildContext context)? progress;
  final Widget Function(BuildContext contextr)? none;
  final Widget Function(BuildContext context, Exception exception)? exception;
  final Widget Function(BuildContext context, ImageProvider provider) complete;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageProvider?>(
      future: _loadImage(),
      builder: (BuildContext context, AsyncSnapshot<ImageProvider?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return progress?.call(context) ?? const SizedBox();
        } else {
          if (snapshot.hasError) {
            return exception?.call(context, snapshot.error as Exception) ?? const SizedBox();
          } else if (!snapshot.hasData) {
            return none?.call(context) ?? const SizedBox();
          } else {
            return complete(context, snapshot.data!);
          }
        }
      },
    );
  }

  Future<ImageProvider?> _loadImage() async {
    var url = await getUrl(email, gravatarOptions: gravatarOptions);
    if (url != null) {
      return getImage(email: email, url: url, isEnabledCache: options.isCacheEnabled);
    } else {
      throw Exception('Url not provided');
    }
  }
}
