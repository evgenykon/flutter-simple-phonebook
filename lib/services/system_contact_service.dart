import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class SystemContactService {

  static Future<List<Contact>> getPhoneContacts() async {
    return await FlutterContacts.getContacts(withThumbnail: true, withPhoto: true, withAccounts: true, withProperties: true);
  }
  
}