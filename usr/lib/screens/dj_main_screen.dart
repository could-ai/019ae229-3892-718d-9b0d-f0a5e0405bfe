import 'package:flutter/material.dart';
import '../widgets/deck_widget.dart';
import '../widgets/mixer_widget.dart';

class DJMainScreen extends StatelessWidget {
  const DJMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIRTUAL DJ FLUTTER'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Library feature coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[900]!, Colors.black],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Check orientation
              bool isLandscape = constraints.maxWidth > constraints.maxHeight;

              if (isLandscape) {
                return Row(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: DeckWidget(
                        deckName: 'DECK A',
                        color: Colors.cyanAccent,
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: MixerWidget(),
                    ),
                    const Expanded(
                      flex: 4,
                      child: DeckWidget(
                        deckName: 'DECK B',
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                );
              } else {
                // Portrait Layout (Stacked)
                return Column(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: DeckWidget(
                        deckName: 'DECK A',
                        color: Colors.cyanAccent,
                      ),
                    ),
                    Container(
                      height: 80,
                      color: Colors.black54,
                      child: const Center(
                        child: Text(
                          "Rotate device for full mixer controls",
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 4,
                      child: DeckWidget(
                        deckName: 'DECK B',
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
