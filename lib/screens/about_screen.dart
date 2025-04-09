import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCECEC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your actual image path
              height: 100,
            ),
            const SizedBox(height: 24),
            const Text(
              "Welcome to VidMatex, your reliable solution for downloading YouTube videos and audio with ease.\n\n"
              "At VidMatex, our mission is to empower users with a simple, efficient, and ad-free tool for enjoying their favorite content offline. Whether it's music, tutorials, vlogs, or educational videos, VidMatex helps you save what matters most.",
              style: TextStyle(fontSize: 14.5, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD2D2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We Offer",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 12),
                  BulletPoint(
                    text: "A sleek, intuitive interface built with Flutter",
                  ),
                  BulletPoint(
                    text:
                        "Fast and reliable downloads in various formats and resolutions",
                  ),
                  BulletPoint(
                    text: "Full control over your downloaded content",
                  ),
                  BulletPoint(text: "An ad-free experience with no tracking"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text("Version: 1.0.0", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 16)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
