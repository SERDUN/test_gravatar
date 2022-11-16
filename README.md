# Flutter gravatar utils

A set of widgets and mixins for working with gravatar API

## Features

- Providing avatar ImageProvider
- Providing avatar url
- Caching avatar image
- Mixins for working with ImageProvider
- Mixins for working with url


## Getting started

#### add the package
```bash
flutter pub add flutter_gravatar_utils
```
#### import the package

```bash
import 'package:flutter_gravatar_utils/gravatar_utils.dart';
```

## Usage

#### GravatarUrlProvider

```dart
GravatarUrlProvider(
                email: 'dmitriiserdun@gmail.com',
                complete: (ctx, url) {
                  return CircleAvatar(
                    child: Image.network(
                      url.toString(),
                      width: 40,
                      height: 40,
                    ),
                  );
                },
                none: (context) => const Text("Non"),
                exception: (context, Exception exception) => const SizedBox(),
                progress: (context) => const CircularProgressIndicator(),
              ),
```
#### GravatarImageProvider
```dart
GravatarImageProvider(
                email: 'dmitriiserdun@gmail.com',
                complete: (ctx, provider) {
                  return Image(
                    width: 80,
                    height: 80,
                    image: provider,
                  );
                },
                none: (context) => const Text("Non"),
                exception: (context, Exception exception) => const SizedBox(),
                progress: (context) => const CircularProgressIndicator(),
              ),
```


#### Cache period for GravatarImageProvider
```dart
  GravatarConfig.init(cachePeriod: const Duration(days: 3));

```


#### GravatarUrlSourceMixin
```dart
class SampleClass with GravatarUrlSourceMixin {
    ...

```

#### GravatarImageSourceMixin
```dart
class SampleClass with GravatarImageSourceMixin {
    ...

```

### Contributing
Contributions are always welcome!
### License
[MIT LICENSE](LICENSE)