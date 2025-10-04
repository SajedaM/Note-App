import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/note.dart';
import 'add_note_page.dart';
import 'dart:ui' as ui;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  final List<Color> cardColors = [
    Color(0xff00b894),
    Color(0xfffaca24),
    Color(0xff00b894),
    Color(0xff092462),
  ];

  int? selectedIndex;

  void _addNewNote(Note note) {
    setState(() {
      notes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff092462),
      appBar: AppBar(
        title:  Text(
          'My Notes'.tr(),
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30),
        ),
        backgroundColor: Color(0xff092462),
      ),
      body: Container(
        color: Color(0xff092462),
        child: Column(
          children: [
            if (selectedIndex != null)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notes[selectedIndex!].title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () async {
                        if (selectedIndex == null) return;
        
                        final editedNote = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNotePage(note: notes[selectedIndex!]),
                          ),
                        );
        
                        if (editedNote != null) {
                          setState(() {
                            notes[selectedIndex!] = editedNote;
                            selectedIndex = null;
                          });
                        }
                      },
                    ),
        
                    SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          selectedIndex = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: const Color(0xff152e6e),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: notes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      final color = cardColors[Random().nextInt(cardColors.length)];
                      //final isSelected = selectedIndex == index;
        
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          color: color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  note.content,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                Text(
                                  "${note.timestamp.day}/${note.timestamp.month}/${note.timestamp.year}",
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
        
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0c2c83),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNotePage()),
          );
          if (newNote != null) _addNewNote(newNote);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xff092462),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Directionality(
          textDirection: ui.TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(-80, 0),
              child: const Icon(Icons.notifications,
                  color: Colors.white, size: 28),
            ),
            const SizedBox(width: 25),
            Transform.translate(
              offset: const Offset(-50, 0),
              child: const Icon(Icons.search, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 25),
            Transform.translate(
              offset: const Offset(-20, 0),
              child:
              const Icon(Icons.credit_card, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 25),
            Transform.translate(
              offset: const Offset(10, 0),
              child: const Icon(Icons.settings, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),)
    );
  }
}
