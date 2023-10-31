import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:short_it/functions/api_services.dart';
import 'package:short_it/functions/functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final urlController = TextEditingController();
  String? _shortenedUrl;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ShortIt',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.1,
          right: size.width * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'Enter yoour URL here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            height(30),
            ElevatedButton(
              onPressed: () async {
                if (isValidUrl(urlController.text)) {
                  final shortenedUrl =
                      await shortenUrl(url: urlController.text);
                  setState(() {
                    _shortenedUrl = shortenedUrl;
                    urlController.clear();
                  });
                  await FirebaseFirestore.instance.collection('urls').add({
                    'originalUrl': urlController.text,
                    'shortenedUrl': shortenedUrl,
                  });
                } else {
                  showSnackbar(context, 'Please enter a valid url');
                }
              },
              child: const Text('Short URL'),
            ),
            height(10),
            if (_shortenedUrl != null)
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.65,
                    child: GestureDetector(
                      onTap: () => redirectUrl('$_shortenedUrl'),
                      child: Text(
                        'Shortened Url : $_shortenedUrl',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: '$_shortenedUrl'))
                          .then(
                        (value) => showSnackbar(
                          context,
                          'Url copied to clipboard',
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.copy,
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
