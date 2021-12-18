import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:weetz/screens/home/header.dart';
import 'package:weetz/services/api.dart';
import 'package:weetz/utils/styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

import 'body.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  final appBar = AppBar(
    backgroundColor: Colors.indigo,
    toolbarHeight: 0,
  );

  final _snackBar = SnackBar(
    content: Row(
      children: const [Text('Procurando pin...')],
    ),
  );

  final api = Api();
  final dio = Dio();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _url;
  bool _isFounded = false;
  final _controller = TextEditingController();
  WebViewController? _webViewController;

  // Id pin
  late String id;

  Future<void> _requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _floatingButton = FloatingActionButton(
      onPressed: _download,
      backgroundColor: Colors.indigo,
      child: const Icon(Icons.file_download_outlined),
    );

    return Scaffold(
      floatingActionButton: _isFounded ? _floatingButton : null,
      appBar: widget.appBar,
      body: ListView(
        children: [
          Header(search: _search()),
          _url == null ? const Body() : _buildVideo(_url!),
        ],
      ),
    );
  }

  // Search for pins
  Widget _search() {
    final button = GestureDetector(
      onTap: _searchPin,
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[900]!,
              blurRadius: 2,
            )
          ],
        ),
        child: const Center(
            child: Text(
          'Go',
          style: Style.button,
        )),
      ),
    );

    final input = TextField(
      controller: _controller,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Pin...',
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900]!,
            offset: const Offset(1, 1),
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 10),
          Flexible(child: input),
          const SizedBox(width: 10),
          button,
        ],
      ),
    );
  }

  // Display video in web
  Widget _buildVideo(String url) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 0.7 * MediaQuery.of(context).size.height,
        child: WebView(
          javascriptMode: JavascriptMode.disabled,
          initialUrl: url,
          onWebViewCreated: (WebViewController controller) {
            _webViewController = controller;
            _webViewController!.loadUrl(url);
          },
        ),
      );

  // https://br.pinterest.com/pin/688487861794120285/
  // https://pin.it/3IrXqcc
  Future<String> _getUrlVideo(String url) async {
    if (url.contains('pin.it')) {
      url = await widget.api.unshort(url);
    }
    id = Api.getPinID(url);
    return await widget.api.get(url);
  }

  Future<void> _searchPin() async {
    if (_controller.text == '') return;

    ScaffoldMessenger.of(context).showSnackBar(widget._snackBar);
    var text = _controller.text;
    _url = await _getUrlVideo(text);
    _isFounded = true;
    setState(() {
      _webViewController?.loadUrl(_url!);
    });
  }

  Future<void> _download() async {
    await _requestStoragePermission();
    final url = _url!;
    const androidPath = '/storage/emulated/0/Download';

    final file = File('$androidPath/$id.mp4');
    if (await file.exists()) {
      await file.delete();
    }

    await widget.dio.download(
      url,
      file.path,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          var progress = (received / total * 100).toInt();
          _sendNotification(progress);
        }
      },
    );
    //await _downloadDone();
  }

  void _sendNotification(int progress) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      title: progress >= 99 ? 'Pin downloaded' : 'Downloading pin...',
      id: 10,
      channelKey: 'progress_bar',
      progress: progress,
      notificationLayout: progress >= 99 ? NotificationLayout.Default : NotificationLayout.ProgressBar,
    ));
  }
}
