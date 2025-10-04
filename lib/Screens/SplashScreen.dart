import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:notes_app/Screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentIndex = 0;

  final List<String> images = [
    'assets/images/IMG-20250927-WA0003.jpg',
    'assets/images/IMG-20250927-WA0004.jpg',
    'assets/images/IMG-20250927-WA0005.jpg',
    'assets/images/IMG-20250927-WA0006.jpg'
  ];

  void _changeLanguage(){
    final currentLocale = context.locale;
    final newLocale = currentLocale.languageCode == 'en'
    ? const Locale('ar') : const Locale('en');

    context.setLocale(newLocale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            actions:  [
              TextButton(
                onPressed: (){
                  context.setLocale(Locale('en'));
                },
                child: Text('English',
                  style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                  ),
              ),
              TextButton(
                onPressed: (){
                  context.setLocale(Locale('ar'));
                },
                child: Text('عربي',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider(
                  items: images.map((path) => Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(path, fit: BoxFit.cover),
                  )).toList(),
                  options: CarouselOptions(
                    height: 400,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Text("Create Your Notes & Share\nWith your team".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text("For Your Daily Tasks Set Reminders.".tr(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: images.asMap().entries.map((entry) {
                                return Container(
                                  height: 12,
                                  width: 12,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == entry.key ? Colors.white
                                        : Colors.grey,
                                  ),
                                );
                              }).toList(),
                            ),
                    const SizedBox(width: 60),
                    ElevatedButton(
                      onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 20),
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: Size(100, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      child: Text("Next".tr()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}

