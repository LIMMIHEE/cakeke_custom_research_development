import 'package:flutter/material.dart';

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
