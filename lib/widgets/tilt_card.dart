import 'package:flutter/material.dart';
import '../theme/theme_controller.dart';

class TiltCard extends StatefulWidget {
  final Widget child;
  final double maxTiltAngle;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool enableGlow;
  final Color? glowColor;

  const TiltCard({
    super.key,
    required this.child,
    this.maxTiltAngle = 0.12,
    this.borderRadius,
    this.padding,
    this.enableGlow = true,
    this.glowColor,
  });

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> with SingleTickerProviderStateMixin {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  Offset _localPos = Offset.zero;
  bool _isHovered = false;

  late final AnimationController _resetController;
  late Animation<double> _animX;
  late Animation<double> _animY;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {
          _rotateX = _animX.value;
          _rotateY = _animY.value;
        });
      });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event, Size size) {
    if (size.width == 0 || size.height == 0) return;
    _resetController.stop();

    final center = Offset(size.width / 2, size.height / 2);
    final pos = event.localPosition;

    final normX = (pos.dx - center.dx) / (size.width / 2);
    final normY = (pos.dy - center.dy) / (size.height / 2);

    setState(() {
      _isHovered = true;
      _localPos = pos;
      _rotateX = -normY.clamp(-1.0, 1.0) * widget.maxTiltAngle;
      _rotateY = normX.clamp(-1.0, 1.0) * widget.maxTiltAngle;
    });
  }

  void _onExit(PointerEvent event) {
    _animX = Tween<double>(begin: _rotateX, end: 0.0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );
    _animY = Tween<double>(begin: _rotateY, end: 0.0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );
    _resetController.forward(from: 0.0);

    setState(() {
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = widget.borderRadius ?? BorderRadius.circular(16);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardSize = Size(constraints.maxWidth, constraints.maxHeight);

        return MouseRegion(
          onHover: (e) => _onHover(e, cardSize),
          onExit: _onExit,
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateX(_rotateX)
              ..rotateY(_rotateY),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: widget.padding,
              decoration: BoxDecoration(
                borderRadius: effectiveRadius,
                boxShadow: _isHovered && widget.enableGlow
                    ? [
                        BoxShadow(
                          color: (widget.glowColor ??
                                  ThemeController.instance.accentColor)
                              .withValues(alpha: 0.28),
                          blurRadius: 28,
                          spreadRadius: 2,
                          offset: const Offset(0, 10),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
              ),
              child: Stack(
                children: [
                  widget.child,
                  // Dynamic subtle lighting reflection
                  if (_isHovered)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: effectiveRadius,
                        child: CustomPaint(
                          painter: _SpecularHighlightPainter(
                            lightPos: _localPos,
                            glowColor: widget.glowColor ??
                                ThemeController.instance.accentColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SpecularHighlightPainter extends CustomPainter {
  final Offset lightPos;
  final Color glowColor;

  _SpecularHighlightPainter({
    required this.lightPos,
    required this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment(
          (lightPos.dx / size.width) * 2 - 1,
          (lightPos.dy / size.height) * 2 - 1,
        ),
        radius: 0.8,
        colors: [
          glowColor.withValues(alpha: 0.12),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant _SpecularHighlightPainter oldDelegate) =>
      oldDelegate.lightPos != lightPos;
}
