import 'package:flutter/material.dart';
import 'dart:math';

class DeckWidget extends StatefulWidget {
  final String deckName;
  final Color color;

  const DeckWidget({super.key, required this.deckName, required this.color});

  @override
  State<DeckWidget> createState() => _DeckWidgetState();
}

class _DeckWidgetState extends State<DeckWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPlaying = false;
  double _pitch = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.deckName,
                style: TextStyle(
                  color: widget.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: widget.color.withOpacity(0.3)),
                ),
                child: Text(
                  "BPM: ${(128 * _pitch).toStringAsFixed(1)}",
                  style: TextStyle(
                    color: widget.color,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 10),

          // Vinyl Record
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double size = min(constraints.maxWidth, constraints.maxHeight);
                return GestureDetector(
                  onTap: _togglePlay,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * pi,
                        child: child,
                      );
                    },
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                        gradient: RadialGradient(
                          colors: [
                            Colors.black,
                            Colors.grey[850]!,
                            Colors.black,
                            Colors.grey[900]!,
                          ],
                          stops: const [0.05, 0.4, 0.95, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 15,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Grooves
                          Container(
                            width: size * 0.9,
                            height: size * 0.9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[800]!, width: 1),
                            ),
                          ),
                          Container(
                            width: size * 0.7,
                            height: size * 0.7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[800]!, width: 1),
                            ),
                          ),
                          // Label
                          Container(
                            width: size * 0.35,
                            height: size * 0.35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.color,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  widget.color,
                                  widget.color.withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Icon(Icons.music_note, color: Colors.white, size: 32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Transport Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(Icons.skip_previous, () {}),
              _buildPlayButton(),
              _buildControlButton(Icons.skip_next, () {}),
            ],
          ),
          
          const SizedBox(height: 10),
          
          // Pitch Slider
          Row(
            children: [
              Text('PITCH', style: TextStyle(color: Colors.grey[500], fontSize: 10, fontWeight: FontWeight.bold)),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: widget.color,
                    inactiveTrackColor: Colors.grey[800],
                    thumbColor: Colors.white,
                    trackHeight: 2,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                  ),
                  child: Slider(
                    value: _pitch,
                    min: 0.8,
                    max: 1.2,
                    onChanged: (value) {
                      setState(() {
                        _pitch = value;
                        if (_isPlaying) {
                          _controller.duration = Duration(milliseconds: (2000 / value).round());
                          _controller.repeat();
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white70,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildPlayButton() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: _isPlaying ? widget.color : Colors.grey[800],
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (_isPlaying ? widget.color : Colors.black).withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: _isPlaying ? Colors.white : Colors.transparent,
          width: 2,
        ),
      ),
      child: IconButton(
        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
        color: Colors.white,
        iconSize: 32,
        onPressed: _togglePlay,
      ),
    );
  }
}
