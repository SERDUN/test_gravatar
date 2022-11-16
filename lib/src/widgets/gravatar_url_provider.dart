import 'package:flutter/widgets.dart';

import '../config/gravatar_api_option.dart';
import '../mixin/gravatar_url_source_mixin.dart';

import 'options.dart';

class GravatarUrlProvider extends StatelessWidget with GravatarUrlSourceMixin {
  const GravatarUrlProvider({
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
  final Widget Function(BuildContext context, Uri url) complete;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uri?>(
      future: getUrl(email),
      builder: (BuildContext context, AsyncSnapshot<Uri?> snapshot) {
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
}
