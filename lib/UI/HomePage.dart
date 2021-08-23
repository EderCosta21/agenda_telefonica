import 'dart:io';

import 'package:agenda_telefone/UI/contact_page.dart';
import 'package:agenda_telefone/helpers/contacts_help.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contatos = [];

  @override
  void initState() {
    super.initState();

    _getAllContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: _goToContactPage,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            return contactCards(context, index);
          }),
    );
  }

  Widget contactCards(BuildContext context, int index) {
    return GestureDetector(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: contatos[index].photo != null
                            ? FileImage(File(contatos[index].photo))
                            : AssetImage("images/person.png"),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contatos[index].nome ?? "",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        contatos[index].email ?? "",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        contatos[index].phone ?? "",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          _goToContactPage(contact: contatos[index]);
        });
  }

  Future<void> _goToContactPage({Contact contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));

    if (recContact != null) {
      if (contatos != null) {
        await helper.updateContact(recContact);
      } else {
        helper.saveContact(recContact);
      }

      _getAllContact();
    }
  }

  void _getAllContact() {
    helper.getAllContacts().then((value) => {
          setState(() {
            contatos = value;
          })
        });
  }
}
