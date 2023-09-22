import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TabItem extends StatelessWidget {
  const TabItem({super.key, required this.title});

  final title;

  @override
  Widget build(BuildContext context) {
    return Tab(icon: Text(title));
  }
}

class TabViewListView extends StatelessWidget {
  const TabViewListView({
    super.key,
    required this.addAssetList,
    required this.onTap,
  });

  final List addAssetList;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: addAssetList.length,
        itemBuilder: (context, index) {
          final asset = addAssetList[index];
          return GestureDetector(
              onTap: () => onTap(asset),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(asset),
              ));
        });
  }
}

class MobileDesignWidget extends StatelessWidget {
  final maxWebAppRatio = 4.8 / 6.0;
  final minWebAppRatio = 9.0 / 16.0;

  final Widget child;

  const MobileDesignWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight < constraints.maxWidth) {
          return Container(
            alignment: Alignment.center,
            child: ClipRect(
              child: AspectRatio(
                aspectRatio: getCurrentWebAppRatio(),
                child: child,
              ),
            ),
          );
        }
        return child;
      },
    );
  }

  double getCurrentWebAppRatio() {
    double webAppRatio = minWebAppRatio;

    var screenSize = PlatformDispatcher.instance.implicitView?.physicalSize;
    var screenWidth = screenSize?.width ?? 1200;
    var screenHeight = screenSize?.height ?? 900;

    webAppRatio = screenWidth / screenHeight;
    if (webAppRatio > maxWebAppRatio) {
      webAppRatio = maxWebAppRatio;
    } else if (webAppRatio < minWebAppRatio) {
      webAppRatio = minWebAppRatio;
    }
    return webAppRatio;
  }
}
