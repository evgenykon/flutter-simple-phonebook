import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phonebook/components/contact_item.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:phonebook/detailed_contact.dart';
import 'package:phonebook/services/app_contact_service.dart';
import 'package:phonebook/services/system_contact_service.dart';

import 'entities/pb_contact.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(showColors: true),
    logOptions: const LogOptions(LogLevel.all, stackTraceLevel: LogLevel.off),
    filters: []
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhoneBook',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Phonebook'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PhContact> _contacts = [];
  bool _loadingError = false;
  bool _loading = false;

  @override
  void initState() {
    setState(() => _loading = true);
    try {
      super.initState();
      _fetchContacts();
    } catch (e) {
      setState(() => _loadingError = true);
      logError('loading error', e);
    } finally {
      setState(() => _loading = false);
    }
  }

  Future _fetchContacts() async {
    WidgetsFlutterBinding.ensureInitialized();
    Hive.init((await getApplicationDocumentsDirectory()).path);
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      throw Exception('System contacts permission not granted');
    } else {
      List<Contact>? phoneContacts = await SystemContactService.getPhoneContacts();
      _contacts = await AppContactService.mergeContacts(phoneContacts);
      setState(() => _contacts = _contacts);
    }
  }

  void _openContactPage({required PhContact contact}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedContact(contact: contact),
      ),
    );
  }

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_loadingError) return const Center(child: Text('Error while loading an App'));
    return ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, i) => ContactItem(contact: _contacts[i], callback: _openContactPage,)
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _body(),
    );
  }
}
