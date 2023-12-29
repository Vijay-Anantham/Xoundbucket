import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(), 
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String authUrl =
      'http://localhost:3000/'; // Replace with your actual authentication provider URL
  final String redirectUri =
      'http://localhost:3000/callback'; // Replace with your custom URL scheme

  Future<void> launchAuth() async {
    try {
      if (await canLaunchUrl(Uri.parse(authUrl))) {
        await launchUrl(Uri.parse(authUrl));
      } else {
        print('Cannot launch URL');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  void handleRedirect(String url) {
    // Handle the redirect URL, extract parameters, and complete the authentication process
    print('Redirect URL: $url');

    // Assuming successful authentication, navigate to a different page in your app
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication Example'),
      ),
      body: WebView(
        initialUrl: authUrl,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith(redirectUri)) {
            handleRedirect(request.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => launchAuth(),
        tooltip: 'Authenticate',
        child: Icon(Icons.lock),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Page'),
      ),
      body: Center(
        child: Text('Authentication successful!'),
      ),
    );
  }
}
