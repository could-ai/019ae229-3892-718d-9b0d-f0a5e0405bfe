import 'package:flutter/material.dart';

class MixerWidget extends StatefulWidget {
  const MixerWidget({super.key});

  @override
  State<MixerWidget> createState() => _MixerWidgetState();
}

class _MixerWidgetState extends State<MixerWidget> {
  double _crossfaderValue = 0.5;
  double _volLeft = 0.8;
  double _volRight = 0.8;
  
  // EQ Values
  double _high = 0.5;
  double _mid = 0.5;
  double _low = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          // EQ Section (Visual Only)
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKnobRow("HIGH", _high, (v) => setState(() => _high = v)),
                _buildKnobRow("MID", _mid, (v) => setState(() => _mid = v)),
                _buildKnobRow("LOW", _low, (v) => setState(() => _low = v)),
              ],
            ),
          ),
          
          const Divider(color: Colors.white10),

          // Volume Faders
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildVerticalFader(_volLeft, Colors.cyanAccent, (v) => setState(() => _volLeft = v)),
                // Level Meters (Visual)
                Container(
                  width: 10,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(10, (index) {
                      return Container(
                        height: 8,
                        margin: const EdgeInsets.only(top: 2),
                        color: index < 7 ? Colors.green : (index < 9 ? Colors.yellow : Colors.red),
                      );
                    }),
                  ),
                ),
                _buildVerticalFader(_volRight, Colors.redAccent, (v) => setState(() => _volRight = v)),
              ],
            ),
          ),
          
          const SizedBox(height: 10),
          
          // Crossfader
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                const Text("CROSSFADER", style: TextStyle(color: Colors.white38, fontSize: 8, letterSpacing: 1)),
                SizedBox(
                  height: 30,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white,
                      thumbColor: Colors.grey[300],
                    ),
                    child: Slider(
                      value: _crossfaderValue,
                      onChanged: (v) => setState(() => _crossfaderValue = v),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKnobRow(String label, double value, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 8)),
        SizedBox(
          height: 30,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              activeTrackColor: Colors.grey,
              inactiveTrackColor: Colors.grey[800],
              thumbColor: Colors.white,
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalFader(double value, Color color, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Expanded(
          child: RotatedBox(
            quarterTurns: 3,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                activeTrackColor: color,
                inactiveTrackColor: Colors.grey[800],
                thumbColor: Colors.white,
              ),
              child: Slider(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text("VOL", style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
