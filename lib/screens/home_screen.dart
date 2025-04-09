import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_video_downloader/screens/download_progress_screen.dart';
import 'package:youtube_video_downloader/screens/download_complete_screen.dart';
import 'package:youtube_video_downloader/screens/library_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _linkController = TextEditingController();
  bool _isLoading = false;
  bool _showDownloadOptions = false;
  int _currentIndex = 0;

  void _pasteLink() async {
    final data = await Clipboard.getData('text/plain');
    if (data != null && data.text != null) {
      setState(() {
        _linkController.text = data.text!;
        _isLoading = true;
        _showDownloadOptions = false;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _showDownloadOptions = true;
      });
    }
  }

  void _search() {
    final link = _linkController.text.trim();
    if (link.isNotEmpty) {
      print("Searching for: $link");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter a link")));
    }
  }

  TableRow _buildTableRow(String quality) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(quality)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => DownloadProgressScreen(
                        quality: quality,
                        videoLink: _linkController.text.trim(),
                      ),
                ),
              );
            },
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text(
              'Download',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadOptions() {
    return Column(
      children: [
        const SizedBox(height: 24),
        Table(
          border: TableBorder.all(color: Colors.grey),
          children: [
            const TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Audio',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(),
              ],
            ),
            _buildTableRow("MP3"),
            const TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Video',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(),
              ],
            ),
            _buildTableRow("1080p"),
            _buildTableRow("720p"),
            _buildTableRow("480p"),
            _buildTableRow("360p"),
          ],
        ),
      ],
    );
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "YouTube Video Downloader",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _linkController,
            decoration: InputDecoration(
              hintText: 'Paste link here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _pasteLink,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.paste, color: Colors.white),
                  label: const Text(
                    "Paste Link",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _search,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.search, color: Colors.white),
                  label: const Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "Note: Please respect original works and the intellectual property rights.",
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (_showDownloadOptions && !_isLoading) _buildDownloadOptions(),
        ],
      ),
    );
  }

  // Updated tab widgets
  Widget _buildLibraryTab() => const DownloadCompleteScreen();
  Widget _buildSettingsTab() => const Center(child: Text("Settings Page"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCECEC),
      body: SafeArea(
        child: _buildHomeContent(), // Always show home here
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            // Navigate to Library Screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LibraryScreen()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
