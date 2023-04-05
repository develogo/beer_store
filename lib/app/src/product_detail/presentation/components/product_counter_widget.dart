import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCounter extends StatefulWidget {
  final int initialValue;

  const ProductCounter({Key? key, this.initialValue = 0}) : super(key: key);

  @override
  State<ProductCounter> createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  late ValueNotifier<int> _value;
  Timer? _timer;
  double _interval = 600; // intervalo inicial em milissegundos
  final double _maxInterval = 1000; // intervalo máximo em milissegundos

  @override
  void initState() {
    super.initState();
    _value = ValueNotifier(widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTapDown: _startDecrementTimer,
          onTapUp: _stopTimer,
          onTapCancel: () => _stopTimer(null),
          child: TextButton(
            onPressed: _decrement,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
            ),
            child: Text(
              "-",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 36,
          child: ValueListenableBuilder(
            valueListenable: _value,
            builder: (context, value, _) {
              return Text(
                "$value",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
        GestureDetector(
          onTapDown: _startTimer,
          onTapUp: _stopTimer,
          onTapCancel: () => _stopTimer(null),
          child: TextButton(
            onPressed: _increment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
            ),
            child: Text(
              "+",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _increment() {
    _value.value++;
  }

  void _decrement() {
    _value.value = _value.value == 1 ? 1 : _value.value - 1;
  }

  void _startDecrementTimer(TapDownDetails details) {
    _timer = Timer.periodic(Duration(milliseconds: _interval.toInt()), (_) {
      _decrement();
      if (_interval > _maxInterval) {
        _timer?.cancel();
      } else if (_interval > 50) {
        _interval -= 50;
        _timer?.cancel();
        _startDecrementTimer(details);
      }
    });
  }

  void _startTimer(TapDownDetails details) {
    _timer = Timer.periodic(Duration(milliseconds: _interval.toInt()), (_) {
      _value.value++;
      if (_interval > _maxInterval) {
        _timer?.cancel();
      } else if (_interval > 50) {
        _interval -= 50;
        _timer?.cancel();
        _startTimer(details);
      }
    });
  }

  void _stopTimer(TapUpDetails? details) {
    _timer?.cancel();
    _interval = 600; // reinicia o intervalo
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
