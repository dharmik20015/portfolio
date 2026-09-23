import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

class ParticleBackground extends StatefulWidget {
  final Widget child;
  final bool isDark;

  const ParticleBackground({
    super.key,
    required this.child,
    required this.isDark,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();
  Offset? _mousePos;

  static const int _particleCount = 45;
  static const double _maxDistance = 110.0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(_Particle.random(_random));
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        _updateParticles();
      })..repeat();
  }

  void _updateParticles() {
    for (final p in _particles) {
      p.x += p.vx;
      p.y += p.vy;

      if (p.x < 0 || p.x > 1.0) p.vx = -p.vx;
      if (p.y < 0 || p.y > 1.0) p.vy = -p.vy;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePos = event.localPosition;
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: _ParticlePainter(
                      particles: _particles,
                      maxDistance: _maxDistance,
                      isDark: widget.isDark,
                      mousePos: _mousePos,
                    ),
                  );
                },
              ),
            ),
            widget.child,
          ],
        ),
      ),
    );
  }
}

class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  Color color;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.color,
  });

  factory _Particle.random(Random random) {
    final colors = [
      AppColors.poisonGreen,
      AppColors.poisonGreenDark,
      AppColors.poisonGreen,
      AppColors.neonPurple,
      AppColors.neonGreen,
      AppColors.neonPink,
    ];

    return _Particle(
      x: random.nextDouble(),
      y: random.nextDouble(),
      vx: (random.nextDouble() - 0.5) * 0.0006,
      vy: (random.nextDouble() - 0.5) * 0.0006,
      radius: random.nextDouble() * 2.2 + 1.2,
      color: colors[random.nextInt(colors.length)],
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double maxDistance;
  final bool isDark;
  final Offset? mousePos;

  _ParticlePainter({
    required this.particles,
    required this.maxDistance,
    required this.isDark,
    required this.mousePos,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Subtle ambient background gradient
    final bgPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.topRight,
        radius: 1.5,
        colors: isDark
            ? [
                const Color(0xFF041E11),
                const Color(0xFF070B12),
              ]
            : [
                const Color(0xFFEFF6FF),
                const Color(0xFFF6F8FD),
              ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final linePaint = Paint()..strokeWidth = 0.8;
    final particlePaint = Paint()..style = PaintingStyle.fill;

    // Draw connecting lines between particles
    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      final pos1 = Offset(p1.x * size.width, p1.y * size.height);

      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final pos2 = Offset(p2.x * size.width, p2.y * size.height);

        final dist = (pos1 - pos2).distance;
        if (dist < maxDistance) {
          final opacity = (1.0 - (dist / maxDistance)) * (isDark ? 0.22 : 0.12);
          linePaint.color = p1.color.withValues(alpha: opacity);
          canvas.drawLine(pos1, pos2, linePaint);
        }
      }

      // Draw line to mouse if nearby
      if (mousePos != null) {
        final mDist = (pos1 - mousePos!).distance;
        if (mDist < maxDistance * 1.3) {
          final mOpacity = (1.0 - (mDist / (maxDistance * 1.3))) * 0.45;
          linePaint.color = ThemeController.instance.accentColor
              .withValues(alpha: mOpacity);
          canvas.drawLine(pos1, mousePos!, linePaint);
        }
      }

      // Draw particle dot
      particlePaint.color = p1.color.withValues(alpha: isDark ? 0.75 : 0.5);
      canvas.drawCircle(pos1, p1.radius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
