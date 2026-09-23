import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../theme/theme_controller.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;

  const CustomCursor({super.key, required this.child});

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> {
  final ValueNotifier<Offset> _pointerPos = ValueNotifier<Offset>(Offset.zero);
  final ValueNotifier<bool> _isVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isClicking = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _pointerPos.dispose();
    _isVisible.dispose();
    _isClicking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // On mobile touch devices, return child directly with zero cursor overhead
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      return widget.child;
    }

    return SizedBox.expand(
      child: MouseRegion(
        opaque: false,
        onHover: (e) {
          _pointerPos.value = e.position;
          if (!_isVisible.value) _isVisible.value = true;
        },
        onExit: (_) {
          _isVisible.value = false;
        },
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) => _isClicking.value = true,
          onPointerUp: (_) => _isClicking.value = false,
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.child,
              // Ultra-lightweight cursor rendering layer without rebuilding widget.child
              IgnorePointer(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isVisible,
                  builder: (context, isVisible, _) {
                    if (!isVisible) return const SizedBox.shrink();

                    return ListenableBuilder(
                      listenable: Listenable.merge([_pointerPos, _isClicking, ThemeController.instance]),
                      builder: (context, _) {
                        final pos = _pointerPos.value;
                        final isClicking = _isClicking.value;
                        final accent = ThemeController.instance.accentColor;

                        const double ringSize = 18.0;
                        const double clickRingSize = 24.0;
                        final double currentRingSize = isClicking ? clickRingSize : ringSize;

                        return Stack(
                          children: [
                            // Outer sleek trailing ring
                            Positioned(
                              left: pos.dx - (currentRingSize / 2),
                              top: pos.dy - (currentRingSize / 2),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeOut,
                                width: currentRingSize,
                                height: currentRingSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: accent.withValues(alpha: 0.65),
                                    width: 1.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: accent.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Tiny sharp core dot directly on cursor tip
                            Positioned(
                              left: pos.dx - 2.5,
                              top: pos.dy - 2.5,
                              child: Container(
                                width: 5.0,
                                height: 5.0,
                                decoration: BoxDecoration(
                                  color: accent,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: accent.withValues(alpha: 0.8),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
