import 'dart:io';

import 'package:agenda_telefone/helpers/contacts_help.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

//construtor
// chaves deixa ele opcional
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool user_Edited = false;
  Contact editedContact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      editedContact = Contact();
    } else {
      editedContact = Contact.fromMap(widget.contact.toMap());

      nomeController.text = editedContact.nome;
      emailController.text = editedContact.email;
      phoneController.text = editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(editedContact.nome ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (editedContact.nome.isNotEmpty) {
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: editedContact.photo != null
                          ? FileImage(File(editedContact.photo))
                          : AssetImage("images/person.png"),
                    )),
              ),
            ),
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: "nome"),
              onChanged: (text) {
                user_Edited = true;
                setState(() {
                  editedContact.nome = text;
                });
              },
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              onChanged: (text) {
                user_Edited = true;
                editedContact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              onChanged: (text) {
                user_Edited = true;
                editedContact.phone = text;
              },
              keyboardType: TextInputType.phone,
            )
          ],
        ),
      ),
    );
  }
}
