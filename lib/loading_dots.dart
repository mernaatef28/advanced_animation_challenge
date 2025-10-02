import 'package:flutter/material.dart';

class LoadingDotsAnimation extends StatefulWidget {
  const LoadingDotsAnimation({Key? key}) : super(key: key);

  @override
  State<LoadingDotsAnimation> createState() => _LoadingDotsAnimationState();
}

class _LoadingDotsAnimationState extends State<LoadingDotsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(0.0),
            const SizedBox(width: 10),
            _buildDot(0.33),
            const SizedBox(width: 10),
            _buildDot(0.66),
          ],
        );
      },
    );
  }

  Widget _buildDot(double delay) {
    // Calculate animation value with delay
    double value = (_controller.value - delay) % 1.0;

    // Create scale animation (goes up then down)
    double scale = value < 0.5
        ? 1.0 + (value * 2) * 0.5  // 1.0 to 1.5
        : 1.5 - ((value - 0.5) * 2) * 0.5;  // 1.5 to 1.0

    // Create opacity animation (fades in then out)
    double opacity = value < 0.5
        ? 0.3 + (value * 2) * 0.7  // 0.3 to 1.0
        : 1.0 - ((value - 0.5) * 2) * 0.7;  // 1.0 to 0.3

    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

// Demo page
class LoadingDotsDemo extends StatelessWidget {
  const LoadingDotsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Animation')),
      body: const Center(
        child: LoadingDotsAnimation(),
      ),
    );
  }
}