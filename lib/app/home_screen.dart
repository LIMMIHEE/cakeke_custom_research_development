import 'dart:convert';

import 'package:cakeke_custom_research_development/app/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LindiController controller = LindiController(
    borderColor: Colors.pinkAccent,
    iconColor: Colors.white,
    showDone: true,
    showClose: true,
    shouldScale: true,
    shouldRotate: true,
    shouldMove: true,
    minScale: 0.5,
    maxScale: 4,
  );

  final stickerImages = [];
  final backgroundImages = [];
  String background = 'assets/images/back_version1_white.png';

  Future _initImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final stickerPaths = manifestMap.keys
        .where((String key) => key.contains('images/sticker'))
        .toList();
    final backgroundPaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('back_'))
        .toList();

    setState(() {
      backgroundImages.addAll(backgroundPaths);
      stickerImages.addAll(stickerPaths);
    });
  }

  @override
  void initState() {
    _initImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: LindiStickerWidget(
              controller: controller,
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    background,
                    fit: BoxFit.fitWidth,
                  )),
            ),
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    TabItem(title: '배경'),
                    TabItem(title: '스티커'),
                    TabItem(title: '문자'),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: TabBarView(children: [
                    TabViewListView(
                        addAssetList: backgroundImages,
                        onTap: (asset) {
                          setState(() {
                            background = asset;
                          });
                        }),
                    TabViewListView(
                      addAssetList: stickerImages,
                      onTap: (asset) {
                        if (mounted) {
                          controller.addWidget(
                            Image.asset(asset),
                          );
                        }
                      },
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.all(12),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: '문자를 입력해주세요.',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 18),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (text) {
                            if (text.isNotEmpty && mounted) {
                              controller.addWidget(
                                Text(text),
                              );
                            }
                          },
                        )),
                  ]),
                )
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
