
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:phonebook/services/app_contact_service.dart';
import 'package:phonebook/services/system_contact_service.dart';

import 'adapters/enum_class_adapter.dart';
import 'adapters/ph_contact_adapter.dart';
import 'adapters/ph_direct_contact_adapter.dart';
import 'components/contact_item.dart';
import 'detailed_contact.dart';
import 'entities/ph_contact.dart';
import 'enums/ph_enum_direct_contact_type.dart';

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
    Hive.registerAdapter<PhDirectContactType>(EnumClassAdapter<PhDirectContactType>(1, PhDirectContactType.values));
    Hive.registerAdapter(PhDirectContactAdapter());
    Hive.registerAdapter(PhContactAdapter());
    Hive.initFlutter();
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
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, i) => ContactItem(contact: _contacts[i], callback: _openContactPage,)
            ),)
          ],
        )
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title, style: const TextStyle(fontSize: 18),),
          elevation: 0,
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return {'Settings', 'Refresh database'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.favorite)),
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.label)),
            ],
          ),
        ),
        body: _body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      )
    );



  }
}